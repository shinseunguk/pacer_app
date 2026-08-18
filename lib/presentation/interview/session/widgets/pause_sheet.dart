import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';

/// 일시정지 바텀시트에서 사용자가 고른 행동.
enum PauseChoice {
  /// 시트만 닫고 면접을 계속한다.
  keepGoing,

  /// 세션을 일시정지하고 화면을 떠난다.
  saveAndExit,
}

/// S20 일시정지 — 시안은 다이얼로그가 아니라 바텀시트로 두 갈래를 제시한다.
/// 사용자가 시트 밖을 눌러 닫으면 [PauseChoice.keepGoing]과 같게 취급하도록 null을 반환한다.
Future<PauseChoice?> showPauseSheet(BuildContext context) {
  return showModalBottomSheet<PauseChoice>(
    context: context,
    showDragHandle: true,
    builder: (context) => const _PauseSheet(),
  );
}

class _PauseSheet extends StatelessWidget {
  const _PauseSheet();

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          0,
          AppSpacing.md,
          AppSpacing.md,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.interviewPauseSheetTitle, style: textTheme.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.interviewPauseSheetDesc,
              style: textTheme.bodySmall?.copyWith(color: context.colors.text2),
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton(
              onPressed: () =>
                  Navigator.of(context).pop(PauseChoice.keepGoing),
              child: Text(l10n.interviewContinue),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(PauseChoice.saveAndExit),
              child: Text(l10n.interviewExit),
            ),
          ],
        ),
      ),
    );
  }
}
