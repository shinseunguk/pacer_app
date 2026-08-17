import 'package:flutter/material.dart';
import '../../common/app_spinner.dart';
import '../../common/pressable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/interview_message.dart';
import '../../../domain/entities/interview_session.dart';
import '../../../l10n/app_localizations.dart';
import '../../common/app_error_view.dart';
import '../../common/failure_message.dart';
import '../../providers/user_providers.dart';
import 'interview_session_notifier.dart';
import 'widgets/chat_bubble.dart';

/// S20 — 채팅 면접. 답변은 SSE로 스트리밍되어 흘러 들어온다.
class InterviewScreen extends ConsumerStatefulWidget {
  const InterviewScreen({required this.sessionId, super.key});

  final String sessionId;

  @override
  ConsumerState<InterviewScreen> createState() => _InterviewScreenState();
}

class _InterviewScreenState extends ConsumerState<InterviewScreen> {
  final _inputController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final provider = interviewSessionProvider(widget.sessionId);
    final sessionState = ref.watch(provider);

    ref.listen(provider, (_, next) {
      final error = next.valueOrNull?.turnError;
      if (error == null) return;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(failureMessage(error))));
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.interviewTitle),
        actions: [
          if (sessionState.valueOrNull?.status == SessionStatus.inProgress)
            TextButton(
              onPressed: () => ref.read(provider.notifier).pause(),
              child: Text(l10n.interviewPause),
            ),
        ],
      ),
      body: SafeArea(
        child: sessionState.when(
          loading: () => const Center(child: AppSpinner(size: 28)),
          error: (error, _) => AppErrorView(
            error: error,
            onRetry: () => ref.invalidate(provider),
          ),
          data: (data) => _body(context, l10n, data),
        ),
      ),
    );
  }

  Widget _body(
    BuildContext context,
    AppL10n l10n,
    InterviewSessionState state,
  ) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    return Column(
      children: [
        _ProgressHeader(progress: state.progress),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            itemCount: state.messages.length + (state.isStreaming ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= state.messages.length) {
                return const TypingIndicator();
              }
              return ChatBubble(message: state.messages[index]);
            },
          ),
        ),
        _Composer(
          state: state,
          controller: _inputController,
          onSend: () => _send(state),
          onSkip: () => ref
              .read(interviewSessionProvider(widget.sessionId).notifier)
              .skip(),
          onResume: () => ref
              .read(interviewSessionProvider(widget.sessionId).notifier)
              .resume(),
          onFinish: _finish,
        ),
      ],
    );
  }

  Future<void> _send(InterviewSessionState state) async {
    final content = _inputController.text.trim();
    if (content.isEmpty || !state.canAnswer) return;

    hapticTap();

    final notifier = ref.read(
      interviewSessionProvider(widget.sessionId).notifier,
    );
    await notifier.sendAnswer(content);

    if (!mounted) return;
    // 전송에 실패하면 입력을 지우지 않는다(임시 보관 — 화면정의서 §4).
    final failed =
        ref
            .read(interviewSessionProvider(widget.sessionId))
            .valueOrNull
            ?.turnError !=
        null;
    if (!failed) {
      _inputController.clear();
      ref.invalidate(myProfileProvider);
    }
  }

  void _finish() {
    context.push(AppRoutes.interviewReport(widget.sessionId));
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }
}

class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader({required this.progress});

  final InterviewProgress progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final total = progress.total == 0 ? 1 : progress.total;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.interviewProgress(progress.current, progress.total),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: AppSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.xs),
            child: LinearProgressIndicator(
              value: (progress.current / total).clamp(0, 1),
              backgroundColor: AppColors.surface2,
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({
    required this.state,
    required this.controller,
    required this.onSend,
    required this.onSkip,
    required this.onResume,
    required this.onFinish,
  });

  final InterviewSessionState state;
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onSkip;
  final VoidCallback onResume;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);

    if (state.status == SessionStatus.paused) {
      return _Panel(
        children: [
          Text(
            l10n.interviewPausedNotice,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          FilledButton(onPressed: onResume, child: Text(l10n.interviewResume)),
        ],
      );
    }

    if (state.isFinished) {
      return _Panel(
        children: [
          FilledButton(onPressed: onFinish, child: Text(l10n.interviewFinish)),
        ],
      );
    }

    return _Panel(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                enabled: state.canAnswer,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(hintText: l10n.interviewInputHint),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            IconButton.filled(
              onPressed: state.canAnswer ? onSend : null,
              icon: const Icon(Icons.send),
              tooltip: l10n.interviewSend,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: state.canAnswer ? onSkip : null,
            child: Text(l10n.interviewSkip),
          ),
        ),
      ],
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}
