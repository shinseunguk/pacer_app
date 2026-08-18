import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../common/pacer_mark.dart';

/// 면접관 발화 앞에 붙는 로고마크 칩 (디자인 시안 `CoachAvatar`).
class CoachAvatar extends StatelessWidget {
  const CoachAvatar({this.size = 30, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colors.accentSoft,
        shape: BoxShape.circle,
        border: Border.all(color: colors.accentLine),
      ),
      alignment: Alignment.center,
      child: PacerMark(size: size * 0.58, stroke: size * 0.075),
    );
  }
}
