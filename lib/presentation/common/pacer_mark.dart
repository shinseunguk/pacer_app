import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// 페이서 로고마크 — 62% 진행한 페이스 링 + 러너 도트 (디자인 시안 `PacerMark`).
class PacerMark extends StatelessWidget {
  const PacerMark({this.size = 28, this.stroke = 3, super.key});

  final double size;
  final double stroke;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CustomPaint(painter: _PacerMarkPainter(stroke: stroke)),
    );
  }
}

/// 링이 도는 비율 — 시안과 동일하게 62%.
const _progress = 0.62;

class _PacerMarkPainter extends CustomPainter {
  const _PacerMarkPainter({required this.stroke});

  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - stroke) / 2 - 1;

    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = AppColors.accentSoft;
    canvas.drawCircle(center, radius, track);

    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = AppColors.accent;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      _progress * 2 * math.pi,
      false,
      arc,
    );

    final dot = Paint()..color = AppColors.accent;
    const angle = -math.pi / 2 + _progress * 2 * math.pi;
    canvas.drawCircle(
      center + Offset(radius * math.cos(angle), radius * math.sin(angle)),
      stroke * 0.95,
      dot,
    );
    canvas.drawCircle(center, stroke * 0.7, dot);
  }

  @override
  bool shouldRepaint(_PacerMarkPainter oldDelegate) =>
      oldDelegate.stroke != stroke;
}

/// 로고마크 + 워드마크 (로그인·스플래시 상단).
class PacerWordmark extends StatelessWidget {
  const PacerWordmark({this.markSize = 62, super.key});

  final double markSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PacerMark(size: markSize, stroke: markSize * 0.097),
        const SizedBox(height: 18),
        Text('Pacer', style: Theme.of(context).textTheme.displaySmall),
      ],
    );
  }
}
