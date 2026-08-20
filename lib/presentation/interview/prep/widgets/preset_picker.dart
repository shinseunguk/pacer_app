import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../domain/entities/interview_setup.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../common/pressable.dart';

/// S13 면접 길이 선택 — 카드 3개.
///
/// 슬라이더를 쓰지 않는 이유: 3~15 중 하나를 고르는 건 **정보가 없는 선택**이라
/// 대부분 기본값에 그대로 둔다. 이름과 예상 시간이 있어야 무엇을 고르는지 안다.
///
/// **기본 질문 수는 표시하지 않는다.** "5문항"이라고 쓰면 5개만 받는 것처럼 보이는데
/// 실제로 답하는 건 12개다(도입 2 + 직무 5 + 꼬리질문 ~5).
class PresetPicker extends StatelessWidget {
  const PresetPicker({
    required this.selected,
    required this.onSelected,
    this.lockedPresets = const {},
    this.onLockedTap,
    super.key,
  });

  final InterviewPreset selected;
  final ValueChanged<InterviewPreset> onSelected;

  /// 이용권이 없어 고를 수 없는 프리셋 (결제 연동 전에는 비어 있다).
  final Set<InterviewPreset> lockedPresets;
  final ValueChanged<InterviewPreset>? onLockedTap;

  @override
  Widget build(BuildContext context) {
    // 카드 높이를 서로 맞추려면 stretch가 필요한데, 이 위젯은 ListView 안에 놓여
    // 높이가 무한대다. IntrinsicHeight로 한 번 재서 유한한 높이를 만들어 준다.
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final preset in InterviewPreset.values) ...[
            if (preset != InterviewPreset.values.first)
              const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _PresetCard(
                preset: preset,
                isSelected: preset == selected,
                isLocked: lockedPresets.contains(preset),
                onTap: () => lockedPresets.contains(preset)
                    ? onLockedTap?.call(preset)
                    : onSelected(preset),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PresetCard extends StatelessWidget {
  const _PresetCard({
    required this.preset,
    required this.isSelected,
    required this.isLocked,
    required this.onTap,
  });

  final InterviewPreset preset;
  final bool isSelected;
  final bool isLocked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Pressable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radius),
      child: Opacity(
        opacity: isLocked ? 0.55 : 1,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: isSelected ? colors.accentSoft : colors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radius),
            border: Border.all(
              color: isSelected ? colors.accent : colors.line,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 카드 높이는 IntrinsicHeight가 서로 맞춰주므로 자리를 비워둘 필요가 없다.
              if (isLocked) ...[
                Icon(Icons.lock_outline, size: 15, color: colors.text3),
                const SizedBox(height: AppSpacing.xs),
              ],
              Text(
                _label(l10n, preset),
                textAlign: TextAlign.center,
                style: textTheme.titleSmall?.copyWith(
                  color: isSelected ? colors.accent : colors.text,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.setupPresetMinutes(preset.minutes),
                textAlign: TextAlign.center,
                style: textTheme.bodySmall?.copyWith(color: colors.text2),
              ),
              Text(
                l10n.setupPresetTurns(preset.approxTurns),
                textAlign: TextAlign.center,
                style: textTheme.labelSmall?.copyWith(color: colors.text3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _label(AppL10n l10n, InterviewPreset preset) => switch (preset) {
    InterviewPreset.quick => l10n.setupPresetQuick,
    InterviewPreset.standard => l10n.setupPresetStandard,
    InterviewPreset.deep => l10n.setupPresetDeep,
  };
}
