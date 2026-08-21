import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// LLM이 쓴 긴 글을 문단으로 끊어 그린다.
///
/// 평가 근거·모범답안은 1,000자를 넘기도 한다. `Text` 하나로 그리면 줄바꿈이
/// 살아 있어도 문단 사이가 붙어 벽처럼 보인다. 문단마다 간격을 주고 행간을 넓혀야
/// 읽힌다.
///
/// 빈 줄이 하나든 여럿이든 같은 문단 구분으로 본다 — 모델 출력이 일정하지 않다.
class ParagraphText extends StatelessWidget {
  const ParagraphText(
    this.text, {
    this.style,
    this.spacing = AppSpacing.sm + 2,
    this.height = 1.6,
    super.key,
  });

  final String text;
  final TextStyle? style;

  /// 문단 사이 간격.
  final double spacing;

  /// 행간 배수. 한국어 장문은 1.5 아래로 내려가면 빽빽해진다.
  final double height;

  List<String> get _paragraphs => text
      .split(RegExp(r'\n+'))
      .map((paragraph) => paragraph.trim())
      .where((paragraph) => paragraph.isNotEmpty)
      .toList();

  @override
  Widget build(BuildContext context) {
    final baseStyle = style ?? Theme.of(context).textTheme.bodyMedium;
    final paragraphStyle = baseStyle?.copyWith(height: height);
    final paragraphs = _paragraphs;

    if (paragraphs.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (index, paragraph) in paragraphs.indexed) ...[
          if (index > 0) SizedBox(height: spacing),
          Text(paragraph, style: paragraphStyle),
        ],
      ],
    );
  }
}
