import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import 'pressable.dart';

/// 시안 `ui.jsx` / `shell.jsx`의 공통 원자 컴포넌트를 옮긴 것.
/// (Card, Pill, SectionLabel, Stat, ListRow, ProgressBar)

/// 표면 카드 — 배경 surface + 얇은 라인.
class PacerCard extends StatelessWidget {
  const PacerCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = AppSpacing.radius,
    this.onTap,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: context.colors.line),
      ),
      child: child,
    );

    if (onTap == null) return content;
    return Pressable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: content,
    );
  }
}

enum PillTone { accent, success, warm, neutral, pressure }

/// 작은 상태 뱃지.
class Pill extends StatelessWidget {
  const Pill({
    required this.label,
    this.tone = PillTone.neutral,
    this.icon,
    super.key,
  });

  final String label;
  final PillTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final (fg, bg) = switch (tone) {
      PillTone.accent => (context.colors.accent, context.colors.accentSoft),
      PillTone.success => (context.colors.success, context.colors.successSoft),
      PillTone.warm => (context.colors.warm, context.colors.warmSoft),
      PillTone.pressure => (
        context.colors.pressure,
        context.colors.pressureSoft,
      ),
      PillTone.neutral => (context.colors.text2, context.colors.surface2),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: fg),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: fg,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// 섹션 제목 + 우측 액션.
class SectionLabel extends StatelessWidget {
  const SectionLabel({
    required this.label,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final String label;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm, top: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.titleMedium),
          if (actionLabel != null)
            GestureDetector(
              onTap: onAction,
              child: Row(
                children: [
                  Text(
                    actionLabel!,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: context.colors.text2,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 15,
                    color: context.colors.text3,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// 큰 숫자 + 라벨 (홈 통계).
class StatValue extends StatelessWidget {
  const StatValue({
    required this.value,
    required this.label,
    this.color,
    super.key,
  });

  final String value;
  final String label;

  /// 기본값은 본문 색 (모드에 따라 달라지므로 build에서 결정)
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(
            color: color ?? context.colors.text,
            fontSize: 19,
            fontWeight: FontWeight.w700,
            height: 1,
            fontFeatures: kNumberFeatures,
          ),
        ),
        const SizedBox(height: 3),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}

/// 얇은 진행 바 (기본) / 질문 수만큼 칸이 나뉜 세그먼트 바 (면접 진행).
class PacerProgressBar extends StatelessWidget {
  const PacerProgressBar({
    required this.value,
    required this.max,
    this.height = 7,
    this.segments = 0,
    this.color,
    this.trackColor,
    super.key,
  });

  final int value;
  final int max;
  final double height;

  /// 0이면 연속 바, 1 이상이면 그 수만큼 칸을 나눈다.
  final int segments;

  /// 기본값은 강조색 (모드에 따라 달라지므로 build에서 결정)
  final Color? color;

  /// 아직 차지 않은 구간의 색. 바가 카드 위가 아니라 페이지 배경 위에 놓이면
  /// 기본값(surface2)이 배경과 구분되지 않으므로 호출부에서 지정한다.
  final Color? trackColor;

  @override
  Widget build(BuildContext context) {
    final barColor = color ?? context.colors.accent;
    final emptyColor = trackColor ?? context.colors.surface2;

    if (segments > 0) {
      return Row(
        children: [
          for (var i = 0; i < segments; i++) ...[
            if (i > 0) const SizedBox(width: 3),
            Expanded(
              child: Container(
                height: height,
                decoration: BoxDecoration(
                  color: i < value ? barColor : emptyColor,
                  borderRadius: BorderRadius.circular(height),
                ),
              ),
            ),
          ],
        ],
      );
    }

    final ratio = max == 0 ? 0.0 : (value / max).clamp(0.0, 1.0);
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: LinearProgressIndicator(
        value: ratio,
        minHeight: height,
        backgroundColor: emptyColor,
        color: barColor,
      ),
    );
  }
}

/// 리스트 한 줄 (아이콘 · 제목/부제 · 우측 값 + 셰브런).
class PacerListRow extends StatelessWidget {
  const PacerListRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
    this.showDivider = true,
    super.key,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      pressedScale: 0.985,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: showDivider
            ? BoxDecoration(
                border: Border(bottom: BorderSide(color: context.colors.line)),
              )
            : null,
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: context.colors.surface2,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(icon, size: 19, color: context.colors.text2),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing!,
            Icon(Icons.chevron_right, size: 16, color: context.colors.text3),
          ],
        ),
      ),
    );
  }
}
