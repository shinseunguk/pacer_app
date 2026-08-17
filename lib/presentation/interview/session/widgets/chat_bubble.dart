import 'package:flutter/material.dart';

import '../../../common/app_spinner.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../domain/entities/interview_message.dart';
import '../../../../l10n/app_localizations.dart';

/// 면접관/지원자 발화 말풍선. 꼬리질문은 살짝 다른 색으로 구분한다.
class ChatBubble extends StatelessWidget {
  const ChatBubble({required this.message, super.key});

  final InterviewMessage message;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final isInterviewer = message.type.isInterviewer;
    final isSkip = message.type == MessageType.skip;

    final text = isSkip ? l10n.interviewSkipped : (message.content ?? '');
    if (text.isEmpty) return const SizedBox.shrink();

    return Align(
      alignment: isInterviewer ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 2,
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
        decoration: BoxDecoration(
          color: switch (message.type) {
            MessageType.baseQuestion => context.colors.surface,
            MessageType.followUp => context.colors.surface2,
            MessageType.answer => context.colors.accent,
            MessageType.skip => context.colors.surface2,
          },
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          border: Border.all(
            color: message.type == MessageType.followUp
                ? context.colors.accent
                : context.colors.line,
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isSkip ? context.colors.text2 : context.colors.text,
            fontStyle: isSkip ? FontStyle.italic : FontStyle.normal,
          ),
        ),
      ),
    );
  }
}

/// 스트리밍 대기 표시 (시안의 TypingDots 대응).
class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          border: Border.all(color: context.colors.line),
        ),
        child: const AppSpinner(size: 18),
      ),
    );
  }
}
