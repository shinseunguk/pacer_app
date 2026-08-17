import 'package:flutter/material.dart';

/// 로딩 인디케이터 — iOS는 쿠퍼티노 스피너, 안드로이드는 머티리얼 원형으로 그린다.
class AppSpinner extends StatelessWidget {
  const AppSpinner({
    this.size = 22,
    this.color,
    this.strokeWidth = 2,
    super.key,
  });

  final double size;
  final Color? color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator.adaptive(
        strokeWidth: strokeWidth,
        valueColor: color == null ? null : AlwaysStoppedAnimation(color),
      ),
    );
  }
}
