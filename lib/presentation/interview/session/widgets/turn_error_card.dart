import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../common/failure_message.dart';

/// 답변 전송 실패 안내 — 스낵바는 금방 사라져 재시도 경로를 잃으므로
/// 입력창 바로 위에 남는 카드로 띄운다 (시안 S20).
class TurnErrorCard extends StatelessWidget {
  const TurnErrorCard({required this.error, required this.onRetry, super.key});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final colors = context.colors;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.sm + 4),
      decoration: BoxDecoration(
        color: colors.pressureSoft,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        border: Border.all(color: colors.pressure),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 18, color: colors.pressure),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              failureMessage(error),
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: colors.text),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          TextButton(onPressed: onRetry, child: Text(l10n.interviewRetry)),
        ],
      ),
    );
  }
}
