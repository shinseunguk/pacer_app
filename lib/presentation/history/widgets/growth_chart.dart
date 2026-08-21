import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_motion.dart';
import '../../../domain/entities/growth_summary.dart';

/// 종합 점수 추이 라인 차트 (시안 `GrowthChart`).
///
/// 세로축을 0~100으로 고정하지 않고 **실제 점수 범위에 맞춰 늘린다.**
/// 60~80점대만 나오는 사람에게 0~100 축을 주면 선이 가운데 눌려 변화가 안 보인다.
class GrowthChart extends StatelessWidget {
  const GrowthChart({required this.points, this.height = 148, super.key});

  final List<GrowthPoint> points;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SizedBox(
      height: height,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: prefersReducedMotion(context)
            ? Duration.zero
            : const Duration(milliseconds: 700),
        curve: AppMotion.enter,
        builder: (context, value, _) => CustomPaint(
          size: Size.infinite,
          painter: _GrowthPainter(
            points: points,
            progress: value,
            accent: colors.accent,
            fill: colors.accent.withValues(alpha: 0.14),
            grid: colors.line,
            labelStyle: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: colors.text3, fontSize: 10),
            textDirection: Directionality.of(context),
          ),
        ),
      ),
    );
  }
}

class _GrowthPainter extends CustomPainter {
  const _GrowthPainter({
    required this.points,
    required this.progress,
    required this.accent,
    required this.fill,
    required this.grid,
    required this.labelStyle,
    required this.textDirection,
  });

  final List<GrowthPoint> points;
  final double progress;
  final Color accent;
  final Color fill;
  final Color grid;
  final TextStyle? labelStyle;
  final TextDirection textDirection;

  /// 축 위아래 여유. 최고점이 천장에 붙으면 답답해 보인다.
  static const _padding = 8;
  static const _labelHeight = 18.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final chartHeight = size.height - _labelHeight;
    final scores = points.map((p) => p.score).toList();
    final min = (scores.reduce((a, b) => a < b ? a : b) - _padding).clamp(0, 100);
    final max = (scores.reduce((a, b) => a > b ? a : b) + _padding).clamp(0, 100);
    final span = (max - min) == 0 ? 1 : max - min;

    double yOf(int score) =>
        chartHeight * (1 - (score - min) / span);

    final step = size.width / (points.length - 1);
    final all = [
      for (final (i, point) in points.indexed)
        Offset(step * i, yOf(point.score)),
    ];

    canvas.drawLine(
      Offset(0, chartHeight),
      Offset(size.width, chartHeight),
      Paint()
        ..color = grid
        ..strokeWidth = 1,
    );

    // 애니메이션 중에는 왼쪽부터 차오른다.
    final visible = (all.length * progress).ceil().clamp(2, all.length);
    final shown = all.take(visible).toList();

    final path = Path()..moveTo(shown.first.dx, shown.first.dy);
    for (final point in shown.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }

    canvas.drawPath(
      Path.from(path)
        ..lineTo(shown.last.dx, chartHeight)
        ..lineTo(shown.first.dx, chartHeight)
        ..close(),
      Paint()..color = fill,
    );

    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = accent,
    );

    for (final (i, point) in shown.indexed) {
      final isLast = i == all.length - 1;
      canvas.drawCircle(point, isLast ? 6 : 4, Paint()..color = accent);
      if (!isLast) {
        canvas.drawCircle(
          point,
          2,
          Paint()..color = fill.withValues(alpha: 1),
        );
      }
    }

    _paintDateLabels(canvas, size, step, chartHeight);
  }

  /// 점이 많으면 라벨이 겹친다 — 처음·끝만 남기고 사이는 건너뛴다.
  void _paintDateLabels(
    Canvas canvas,
    Size size,
    double step,
    double chartHeight,
  ) {
    const maxLabels = 4;
    final stride = (points.length / maxLabels).ceil().clamp(1, points.length);

    for (final (i, point) in points.indexed) {
      final isEdge = i == 0 || i == points.length - 1;
      if (!isEdge && i % stride != 0) continue;

      final painter = TextPainter(
        text: TextSpan(
          text: '${point.date.month}/${point.date.day}',
          style: labelStyle,
        ),
        textDirection: textDirection,
      )..layout();

      var dx = step * i - painter.width / 2;
      dx = dx.clamp(0, size.width - painter.width);
      painter.paint(canvas, Offset(dx, chartHeight + 5));
    }
  }

  @override
  bool shouldRepaint(_GrowthPainter old) =>
      old.progress != progress ||
      old.points != points ||
      old.accent != accent;
}
