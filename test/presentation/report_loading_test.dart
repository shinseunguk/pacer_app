import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pacer_app/core/theme/app_theme.dart';
import 'package:pacer_app/l10n/app_localizations.dart';
import 'package:pacer_app/presentation/interview/report/widgets/report_loading_view.dart';

Future<void> pumpLoading(WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.dark(),
      localizationsDelegates: const [
        AppL10n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppL10n.supportedLocales,
      locale: const Locale('ko'),
      home: const Scaffold(body: ReportLoadingView()),
    ),
  );
  await tester.pump();
}

void main() {
  testWidgets('무엇을 하고 있는지 먼저 알린다', (tester) async {
    await pumpLoading(tester);

    expect(find.text('면접을 채점하고 있어요'), findsOneWidget);
    expect(find.text('대화를 처음부터 다시 읽고 있어요'), findsOneWidget);

    await tester.pump(const Duration(minutes: 2));
  });

  testWidgets('시간이 지나면 다음 단계로 넘어간다', (tester) async {
    await pumpLoading(tester);

    await tester.pump(const Duration(seconds: 25));
    await tester.pump();
    expect(find.text('항목별로 점수를 매기고 있어요'), findsOneWidget);

    await tester.pump(const Duration(seconds: 35));
    await tester.pump();
    expect(find.text('질문마다 모범답안을 정리하고 있어요'), findsOneWidget);

    await tester.pump(const Duration(minutes: 2));
  });

  testWidgets('마지막 단계에서 멈추고 더 넘어가지 않는다', (tester) async {
    // 단계가 다 끝나도 응답이 안 올 수 있다. 그때 화면이 깨지면 안 된다.
    await pumpLoading(tester);

    await tester.pump(const Duration(minutes: 5));
    await tester.pump();

    expect(find.text('거의 다 됐어요'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('진행률(%)은 보여주지 않는다', (tester) async {
    // 서버가 한 번에 응답하는 구조라 실제 진행을 알 수 없다.
    // 모르는 값을 그럴듯하게 그리면 거짓말이 된다.
    await pumpLoading(tester);

    expect(find.textContaining('%'), findsNothing);
    expect(find.byType(LinearProgressIndicator), findsNothing);

    await tester.pump(const Duration(minutes: 2));
  });

  testWidgets('오래 걸린다는 것과 이탈해도 된다는 것을 알린다', (tester) async {
    await pumpLoading(tester);

    expect(
      find.text('꼼꼼히 보느라 1~2분 걸려요. 화면을 벗어나도 채점은 계속돼요.'),
      findsOneWidget,
    );

    await tester.pump(const Duration(minutes: 2));
  });
}
