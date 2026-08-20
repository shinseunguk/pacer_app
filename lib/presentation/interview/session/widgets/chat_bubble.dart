import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../domain/entities/interview_message.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../common/motion.dart';
import 'coach_avatar.dart';
import 'typing_dots.dart';

/// 면접관/지원자 발화 말풍선. 꼬리질문은 살짝 다른 색으로 구분한다.
class ChatBubble extends StatelessWidget {
  const ChatBubble({required this.message, this.animate = false, super.key});

  final InterviewMessage message;

  /// 이번에 새로 도착한 발화만 등장 모션을 태운다.
  /// 스크롤로 다시 그려지는 발화까지 재생하면 대화가 계속 들썩인다.
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final isSkip = message.type == MessageType.skip;

    final text = isSkip ? l10n.interviewSkipped : (message.content ?? '');
    if (text.isEmpty) return const SizedBox.shrink();

    final bubble = _Bubble(
      type: message.type,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          // 답변 말풍선만 강조색을 배경으로 깔므로 그 위에는 onAccent를 쓴다.
          color: switch (message.type) {
            MessageType.answer => context.colors.onAccent,
            MessageType.skip => context.colors.text2,
            _ => context.colors.text,
          },
          fontStyle: isSkip ? FontStyle.italic : FontStyle.normal,
        ),
      ),
    );

    final isInterviewer = message.type.isInterviewer;
    final entrance = BubbleIn(
      fromLeft: isInterviewer,
      enabled: animate,
      child: isInterviewer
          ? _CoachTurn(child: bubble)
          : Align(alignment: Alignment.centerRight, child: bubble),
    );

    return entrance;
  }
}

/// 로고마크 칩 + "페이서" 라벨을 붙인 면접관 발화 묶음 (시안 `ChatTurn`).
class _CoachTurn extends StatelessWidget {
  const _CoachTurn({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CoachAvatar(),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.interviewCoachName,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: context.colors.text3,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.type, required this.child});

  final MessageType type;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + 2,
      ),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * 0.72,
      ),
      decoration: BoxDecoration(
        color: switch (type) {
          MessageType.introQuestion => context.colors.surface,
          MessageType.baseQuestion => context.colors.surface,
          MessageType.followUp => context.colors.surface2,
          MessageType.answer => context.colors.accent,
          MessageType.skip => context.colors.surface2,
        },
        borderRadius: BorderRadius.circular(AppSpacing.radius),
        border: Border.all(
          color: type == MessageType.followUp
              ? context.colors.accent
              : context.colors.line,
        ),
      ),
      child: child,
    );
  }
}

/// 스트리밍 대기 표시 — 면접관 말풍선 자리에 점 3개를 띄운다 (시안 `TypingDots`).
class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const _CoachTurn(
      child: _Bubble(
        type: MessageType.baseQuestion,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: TypingDots(),
        ),
      ),
    );
  }
}
