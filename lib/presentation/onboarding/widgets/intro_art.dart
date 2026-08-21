import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

/// 인트로 슬라이드의 아트워크 (시안 `OnboardArt`).
enum IntroArt { hero, chat, growth }

class IntroArtwork extends StatelessWidget {
  const IntroArtwork({required this.kind, super.key});

  final IntroArt kind;

  @override
  Widget build(BuildContext context) => switch (kind) {
    IntroArt.hero => const _HeroArt(),
    IntroArt.chat => const _ChatArt(),
    IntroArt.growth => const _GrowthArt(),
  };
}

/// 페이스 링 + 중앙 아이콘. 서비스의 정체성을 한 장으로 보여준다.
class _HeroArt extends StatelessWidget {
  const _HeroArt();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return SizedBox.square(
      dimension: 230,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size.square(230),
            painter: _PaceRingPainter(
              line: colors.line,
              accent: colors.accent,
              accentSoft: colors.accentSoft,
            ),
          ),
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [colors.accent, colors.accent2],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(Icons.bolt, size: 46, color: colors.onAccent),
          ),
        ],
      ),
    );
  }
}

class _PaceRingPainter extends CustomPainter {
  const _PaceRingPainter({
    required this.line,
    required this.accent,
    required this.accentSoft,
  });

  final Color line;
  final Color accent;
  final Color accentSoft;

  /// 시안의 페이스 링은 66%까지 채워져 있다 — "달리는 중"을 뜻한다.
  static const _progress = 0.66;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    const outer = 105.0;

    final guide = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = line;

    for (final ratio in [0.74, 0.48]) {
      canvas.drawCircle(center, outer * ratio, guide);
    }
    _dashedCircle(canvas, center, outer, guide);

    canvas.drawCircle(
      center,
      78,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..color = accentSoft,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: outer),
      -math.pi / 2,
      2 * math.pi * _progress,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 7
        ..strokeCap = StrokeCap.round
        ..color = accent,
    );
  }

  /// 바깥 링은 점선 — 아직 달릴 구간이 남았다는 표시.
  void _dashedCircle(Canvas canvas, Offset center, double radius, Paint paint) {
    const dash = 2 / 105;
    const gap = 7 / 105;
    for (var a = 0.0; a < 2 * math.pi; a += dash + gap) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        a,
        dash,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_PaceRingPainter old) =>
      old.accent != accent || old.line != line;
}

/// 말풍선 세 개로 "질문 → 답변 → 꼬리질문" 흐름을 보여준다.
class _ChatArt extends StatelessWidget {
  const _ChatArt();

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);

    return SizedBox(
      width: 270,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Bubble(text: l10n.introArtQuestion, isMine: false, widthFactor: 0.78),
          const SizedBox(height: 12),
          _Bubble(text: l10n.introArtAnswer, isMine: true, widthFactor: 0.64),
          const SizedBox(height: 12),
          _Bubble(
            text: l10n.introArtFollowUp,
            isMine: false,
            widthFactor: 0.7,
            badge: l10n.introArtFollowUpBadge,
          ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.text,
    required this.isMine,
    required this.widthFactor,
    this.badge,
  });

  final String text;
  final bool isMine;
  final double widthFactor;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          decoration: BoxDecoration(
            gradient: isMine
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [colors.accent, colors.accent2],
                  )
                : null,
            color: isMine ? null : colors.surface,
            border: isMine ? null : Border.all(color: colors.line),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(17),
              topRight: const Radius.circular(17),
              bottomLeft: Radius.circular(isMine ? 17 : 5),
              bottomRight: Radius.circular(isMine ? 5 : 17),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (badge != null) ...[
                _MiniPill(label: badge!),
                const SizedBox(height: 6),
              ],
              Text(
                text,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                  color: isMine ? colors.onAccent : colors.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniPill extends StatelessWidget {
  const _MiniPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: colors.warmSoft,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.local_fire_department, size: 11, color: colors.warm),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: colors.warm,
            ),
          ),
        ],
      ),
    );
  }
}

/// 점수가 오르는 라인 — 반복할수록 나아진다는 약속.
class _GrowthArt extends StatelessWidget {
  const _GrowthArt();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: 250,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: colors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '83',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w800,
                  height: 1,
                  color: colors.accent,
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  '↑ 12',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: colors.success,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 82,
            child: CustomPaint(
              size: const Size(double.infinity, 82),
              painter: _TrendPainter(
                accent: colors.accent,
                fill: colors.accent.withValues(alpha: 0.16),
                line: colors.line,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendPainter extends CustomPainter {
  const _TrendPainter({
    required this.accent,
    required this.fill,
    required this.line,
  });

  final Color accent;
  final Color fill;
  final Color line;

  /// 0~1로 정규화한 점수. 우상향이면 충분하고 실제 값일 필요는 없다.
  static const _points = [0.12, 0.38, 0.55, 0.92];

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
      Offset(0, size.height * 0.55),
      Offset(size.width, size.height * 0.55),
      Paint()
        ..color = line
        ..strokeWidth = 1,
    );

    final step = size.width / (_points.length - 1);
    final offsets = [
      for (final (i, value) in _points.indexed)
        Offset(step * i, size.height * (1 - value)),
    ];

    final path = Path()..moveTo(offsets.first.dx, offsets.first.dy);
    for (final point in offsets.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }

    final area = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(area, Paint()..color = fill);

    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = accent,
    );

    for (final point in offsets) {
      final isLast = point == offsets.last;
      canvas.drawCircle(point, isLast ? 6 : 4, Paint()..color = accent);
      if (!isLast) {
        canvas.drawCircle(
          point,
          2,
          Paint()..color = fill.withValues(alpha: 1),
        );
      }
    }
  }

  @override
  bool shouldRepaint(_TrendPainter old) => old.accent != accent;
}
