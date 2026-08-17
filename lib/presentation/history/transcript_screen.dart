import 'package:flutter/material.dart';
import '../common/app_spinner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/interview_report.dart';
import '../../l10n/app_localizations.dart';
import '../common/app_error_view.dart';
import '../interview/session/widgets/chat_bubble.dart';
import '../providers/interview_providers.dart';

/// S41 — 대화 전문 재열람 (질문·답변·꼬리질문 + 모범답안 + 리포트 요약).
class TranscriptScreen extends ConsumerWidget {
  const TranscriptScreen({required this.sessionId, super.key});

  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppL10n.of(context);
    final detail = ref.watch(interviewDetailProvider(sessionId));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.transcriptTitle)),
      body: SafeArea(
        child: detail.when(
          loading: () => const Center(child: AppSpinner(size: 28)),
          error: (error, _) => AppErrorView(
            error: error,
            onRetry: () => ref.invalidate(interviewDetailProvider(sessionId)),
          ),
          data: (data) => ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              if (data.report != null) _ReportSummary(report: data.report!),
              for (final message in data.messages) ...[
                ChatBubble(message: message),
                if (message.feedback?.modelAnswer != null)
                  _ModelAnswer(answer: message.feedback!.modelAnswer!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportSummary extends StatelessWidget {
  const _ReportSummary({required this.report});

  final InterviewReport report;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              report.isPass ? l10n.reportPass : l10n.reportFail,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: report.isPass ? AppColors.success : AppColors.pressure,
              ),
            ),
            if (report.showScore)
              Text(
                '${report.overallScore} / 100',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              report.passReason,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _ModelAnswer extends StatelessWidget {
  const _ModelAnswer({required this.answer});

  final String answer;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.transcriptModelAnswer,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.accent),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(answer, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
