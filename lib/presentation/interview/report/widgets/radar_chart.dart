import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_motion.dart';

/// 레이더 차트가 의미를 갖는 최소 축 수.
///
/// 2개 이하면 다각형이 선이나 점으로 찌그러진다. 평가 항목 수는 서버가 정하므로
/// (지금은 4개) 언젠가 줄어들 수 있고, 그때 화면이 깨지면 안 된다.
const kMinRadarAxes = 3;

const _maxScore = 100;
const _gridSteps = 4;

class RadarEntry {
  const RadarEntry({required this.label, required this.score});

  final String label;
  final int score;
}

/// 항목별 점수 레이더 차트 (시안 RadarChart).
///
/// 축이 [kMinRadarAxes]개 미만이면 그리지 않는다 — 호출부가 막대 표시로 폴백해야 한다.
/// 판단을 여기 두면 호출부마다 조건을 흩뿌리지 않아도 된다.
class RadarChart extends StatelessWidget {
  const RadarChart({required this.entries, this.size = 220, super.key});

  final List<RadarEntry> entries;
  final double size;

  static bool canRender(int axisCount) => axisCount >= kMinRadarAxes;

  @override
  Widget build(BuildContext context) {
    if (!canRender(entries.length)) return const SizedBox.shrink();

    final colors = context.colors;
    final labelStyle = Theme.of(
      context,
    ).textTheme.labelSmall?.copyWith(color: colors.text2);

    return SizedBox(
      width: size,
      height: size,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: prefersReducedMotion(context)
            ? Duration.zero
            : const Duration(milliseconds: 700),
        curve: AppMotion.enter,
        builder: (context, value, _) => CustomPaint(
          painter: _RadarPainter(
            entries: entries,
            progress: value,
            gridColor: colors.line,
            fillColor: colors.accent.withValues(alpha: 0.22),
            strokeColor: colors.accent,
            labelStyle: labelStyle,
            textDirection: Directionality.of(context),
          ),
        ),
      ),
    );
  }
}

class _RadarPainter extends CustomPainter {
  const _RadarPainter({
    required this.entries,
    required this.progress,
    required this.gridColor,
    required this.fillColor,
    required this.strokeColor,
    required this.labelStyle,
    required this.textDirection,
  });

  final List<RadarEntry> entries;
  final double progress;
  final Color gridColor;
  final Color fillColor;
  final Color strokeColor;
  final TextStyle? labelStyle;
  final TextDirection textDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    // 라벨이 바깥에 붙으므로 반지름을 그만큼 줄여 잘리지 않게 한다.
    final radius = size.shortestSide / 2 - 26;
    if (radius <= 0) return;

    _paintGrid(canvas, center, radius);
    _paintShape(canvas, center, radius);
    _paintLabels(canvas, center, radius);
  }

  void _paintGrid(Canvas canvas, Offset center, double radius) {
    final grid = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = gridColor;

    for (var step = 1; step <= _gridSteps; step++) {
      final path = Path();
      final stepRadius = radius * step / _gridSteps;

      for (var i = 0; i < entries.length; i++) {
        final point = _pointAt(center, stepRadius, i);
        i == 0 ? path.moveTo(point.dx, point.dy) : path.lineTo(point.dx, point.dy);
      }
      canvas.drawPath(path..close(), grid);
    }

    for (var i = 0; i < entries.length; i++) {
      canvas.drawLine(center, _pointAt(center, radius, i), grid);
    }
  }

  void _paintShape(Canvas canvas, Offset center, double radius) {
    final path = Path();

    for (var i = 0; i < entries.length; i++) {
      final ratio = (entries[i].score / _maxScore).clamp(0.0, 1.0) * progress;
      final point = _pointAt(center, radius * ratio, i);
      i == 0 ? path.moveTo(point.dx, point.dy) : path.lineTo(point.dx, point.dy);
    }
    path.close();

    canvas.drawPath(path, Paint()..color = fillColor);
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeJoin = StrokeJoin.round
        ..color = strokeColor,
    );
  }

  void _paintLabels(Canvas canvas, Offset center, double radius) {
    for (var i = 0; i < entries.length; i++) {
      final painter = TextPainter(
        text: TextSpan(text: entries[i].label, style: labelStyle),
        textDirection: textDirection,
      )..layout();

      final anchor = _pointAt(center, radius + 16, i);
      // 라벨 상자의 중심을 축 끝에 맞춘다.
      painter.paint(
        canvas,
        anchor - Offset(painter.width / 2, painter.height / 2),
      );
    }
  }

  /// 12시부터 시계 방향으로 균등 배치.
  Offset _pointAt(Offset center, double radius, int index) {
    final angle = -math.pi / 2 + 2 * math.pi * index / entries.length;
    return center + Offset(math.cos(angle) * radius, math.sin(angle) * radius);
  }

  @override
  bool shouldRepaint(_RadarPainter old) =>
      old.progress != progress ||
      old.entries != entries ||
      old.strokeColor != strokeColor ||
      old.gridColor != gridColor;
}
