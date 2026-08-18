import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// 면접관이 발화를 만드는 중임을 알리는 점 3개 애니메이션 (디자인 시안 `TypingDots`).
class TypingDots extends StatefulWidget {
  const TypingDots({this.dotSize = 6, super.key});

  final double dotSize;

  @override
  State<TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<TypingDots>
    with SingleTickerProviderStateMixin {
  static const _dotCount = 3;
  static const _cycle = Duration(milliseconds: 1200);

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _cycle,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = context.colors.text3;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var index = 0; index < _dotCount; index++) ...[
              if (index > 0) SizedBox(width: widget.dotSize * 0.7),
              Opacity(
                opacity: _opacityAt(index),
                child: Container(
                  width: widget.dotSize,
                  height: widget.dotSize,
                  decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  /// 점마다 위상을 어긋나게 해 좌 → 우로 번지듯 밝아지게 한다.
  double _opacityAt(int index) {
    final phase = (_controller.value - index / (_dotCount * 2)) % 1.0;
    final wave = (1 - (phase * 2 - 1).abs()).clamp(0.0, 1.0);
    return 0.3 + wave * 0.7;
  }
}
