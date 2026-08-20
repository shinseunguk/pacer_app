import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pacer_app/core/theme/app_theme.dart';
import 'package:pacer_app/l10n/app_localizations.dart';
import 'package:pacer_app/presentation/interview/report/widgets/radar_chart.dart';
import 'package:pacer_app/presentation/interview/report/widgets/score_ring.dart';

Widget wrap(Widget child, {ThemeData? theme}) => MaterialApp(
  theme: theme ?? AppTheme.dark(),
  localizationsDelegates: const [
    AppL10n.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: AppL10n.supportedLocales,
  locale: const Locale('ko'),
  home: Scaffold(body: Center(child: child)),
);

List<RadarEntry> entries(int count) => [
  for (var i = 0; i < count; i++) RadarEntry(label: '항목$i', score: 60 + i * 5),
];

void main() {
  group('ScoreRing', () {
    testWidgets('점수를 100점 만점으로 보여준다', (tester) async {
      await tester.pumpWidget(wrap(const ScoreRing(score: 78)));
      await tester.pumpAndSettle();

      expect(find.text('78'), findsOneWidget);
      expect(find.text('/ 100'), findsOneWidget);
    });

    testWidgets('0점도 그릴 수 있다', (tester) async {
      await tester.pumpWidget(wrap(const ScoreRing(score: 0)));
      await tester.pumpAndSettle();

      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('100점을 넘겨 들어와도 표시가 깨지지 않는다', (tester) async {
      // 서버가 가중 재계산을 하므로 이론상 100을 넘지 않지만, 화면이 그걸
      // 신뢰하고 깨질 이유는 없다.
      await tester.pumpWidget(wrap(const ScoreRing(score: 130)));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });

    testWidgets('라이트 모드에서도 예외 없이 그린다', (tester) async {
      await tester.pumpWidget(
        wrap(const ScoreRing(score: 64), theme: AppTheme.light()),
      );
      await tester.pumpAndSettle();

      expect(find.text('64'), findsOneWidget);
    });
  });

  group('RadarChart', () {
    test('축이 3개 미만이면 그리지 않는다 — 다각형이 선으로 찌그러진다', () {
      expect(RadarChart.canRender(0), isFalse);
      expect(RadarChart.canRender(2), isFalse);
      expect(RadarChart.canRender(3), isTrue);
      expect(RadarChart.canRender(4), isTrue);
    });

    testWidgets('평가 항목 수가 달라져도 깨지지 않는다', (tester) async {
      // 항목 수는 서버가 정한다. 지금은 4개지만 늘거나 줄 수 있다.
      for (final count in [3, 4, 5, 7]) {
        await tester.pumpWidget(wrap(RadarChart(entries: entries(count))));
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull, reason: '축 $count개');
      }
    });

    testWidgets('축이 부족하면 자리를 차지하지 않는다', (tester) async {
      await tester.pumpWidget(wrap(RadarChart(entries: entries(2))));
      await tester.pumpAndSettle();

      final size = tester.getSize(find.byType(RadarChart));
      expect(size, Size.zero);
    });

    testWidgets('좁은 폭에서도 예외 없이 그린다', (tester) async {
      await tester.pumpWidget(
        wrap(SizedBox(width: 40, child: RadarChart(entries: entries(4)))),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  });
}
