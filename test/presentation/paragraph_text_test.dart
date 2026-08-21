import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pacer_app/core/theme/app_theme.dart';
import 'package:pacer_app/presentation/common/paragraph_text.dart';

Future<void> pump(WidgetTester tester, String text) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.dark(),
      home: Scaffold(body: ParagraphText(text)),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('문단마다 따로 그린다', (tester) async {
    // 한 Text로 그리면 문단 사이가 붙어 벽처럼 보인다.
    await pump(tester, '첫 문단입니다.\n둘째 문단입니다.\n셋째 문단입니다.');

    expect(find.byType(Text), findsNWidgets(3));
    expect(find.text('첫 문단입니다.'), findsOneWidget);
    expect(find.text('셋째 문단입니다.'), findsOneWidget);
  });

  testWidgets('빈 줄이 여러 개여도 문단 하나로 센다', (tester) async {
    // 모델 출력이 일정하지 않다 — \n일 때도 \n\n일 때도 같게 보여야 한다.
    await pump(tester, 'A\n\n\nB');

    expect(find.byType(Text), findsNWidgets(2));
  });

  testWidgets('앞뒤 공백을 정리한다', (tester) async {
    await pump(tester, '  앞뒤 공백  \n\n  둘째  ');

    expect(find.text('앞뒤 공백'), findsOneWidget);
    expect(find.text('둘째'), findsOneWidget);
  });

  testWidgets('행간을 넓혀 장문을 읽을 수 있게 한다', (tester) async {
    await pump(tester, '한국어 장문은 행간이 좁으면 빽빽해 읽기 어렵다.');

    final text = tester.widget<Text>(find.byType(Text));
    expect(text.style?.height, greaterThanOrEqualTo(1.5));
  });

  testWidgets('빈 문자열이면 아무것도 그리지 않는다', (tester) async {
    await pump(tester, '   \n\n  ');

    expect(find.byType(Text), findsNothing);
  });
}
