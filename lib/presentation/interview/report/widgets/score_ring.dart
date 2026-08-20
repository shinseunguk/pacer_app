import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_motion.dart';

const _maxScore = 100;

/// 종합 점수 원형 게이지 (시안 ScoreRing).
///
/// 숫자만 크게 쓰는 것보다 "100점 중 어디쯤"이 한눈에 들어온다.
/// 채워지는 애니메이션은 점수를 확인하는 순간을 만들어 준다.
class ScoreRing extends StatelessWidget {
  const ScoreRing({
    required this.score,
    this.size = 168,
    this.strokeWidth = 14,
    super.key,
  });

  final int score;
  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    final ratio = (score / _maxScore).clamp(0.0, 1.0);

    return SizedBox(
      width: size,
      height: size,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: ratio),
        duration: prefersReducedMotion(context)
            ? Duration.zero
            : const Duration(milliseconds: 900),
        curve: AppMotion.enter,
        builder: (context, value, _) => CustomPaint(
          painter: _ScoreRingPainter(
            progress: value,
            trackColor: colors.surface2,
            color: colors.accent,
            strokeWidth: strokeWidth,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  // 숫자도 함께 올라가야 링과 따로 놀지 않는다.
                  '${(value * _maxScore).round()}',
                  style: textTheme.headlineMedium?.copyWith(
                    fontSize: size * 0.28,
                    fontWeight: FontWeight.w800,
                    color: colors.accent,
                  ),
                ),
                Text(
                  '/ $_maxScore',
                  style: textTheme.bodySmall?.copyWith(color: colors.text3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ScoreRingPainter extends CustomPainter {
  const _ScoreRingPainter({
    required this.progress,
    required this.trackColor,
    required this.color,
    required this.strokeWidth,
  });

  final double progress;
  final Color trackColor;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = trackColor;
    canvas.drawCircle(center, radius, track);

    if (progress <= 0) return;

    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = color;

    // 12시에서 시계 방향으로 채운다.
    canvas.drawArc(rect, -math.pi / 2, 2 * math.pi * progress, false, arc);
  }

  @override
  bool shouldRepaint(_ScoreRingPainter old) =>
      old.progress != progress ||
      old.color != color ||
      old.trackColor != trackColor ||
      old.strokeWidth != strokeWidth;
}
