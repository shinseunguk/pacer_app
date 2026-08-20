import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pacer_app/core/theme/app_theme.dart';
import 'package:pacer_app/domain/entities/interview_setup.dart';
import 'package:pacer_app/l10n/app_localizations.dart';
import 'package:pacer_app/presentation/interview/prep/widgets/preset_picker.dart';

void main() {
  Future<InterviewPreset?> pumpPicker(
    WidgetTester tester, {
    InterviewPreset selected = InterviewPreset.standard,
  }) async {
    InterviewPreset? tapped;

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
        home: Scaffold(
          // 실제 화면(S13)은 ListView 안에 놓는다 — 높이가 무한한 자리에서도
          // 레이아웃이 성립해야 한다.
          body: ListView(
            children: [
              PresetPicker(
                selected: selected,
                onSelected: (preset) => tapped = preset,
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return tapped;
  }

  testWidgets('프리셋 3종을 이름·예상 시간과 함께 보여준다', (tester) async {
    await pumpPicker(tester);

    expect(find.text('빠른 연습'), findsOneWidget);
    expect(find.text('실전'), findsOneWidget);
    expect(find.text('심층'), findsOneWidget);
    expect(find.text('약 20분'), findsOneWidget);
    expect(find.text('약 35분'), findsOneWidget);
    expect(find.text('약 55분'), findsOneWidget);
  });

  testWidgets('기본 질문 수(5·10·15문항)는 어디에도 노출하지 않는다', (tester) async {
    await pumpPicker(tester);

    // "5문항"은 실제로 답하는 12개보다 훨씬 적어 보여 구매를 막는다 (이슈 #22).
    for (final preset in InterviewPreset.values) {
      expect(find.textContaining('${preset.questionCount}문항'), findsNothing);
    }
  });

  testWidgets('발화 수는 도입 질문과 꼬리질문을 포함해 표기한다', (tester) async {
    await pumpPicker(tester);

    // 실전(10문항) = 도입 2 + 10*2 = 22
    expect(find.text('질문 22개 내외'), findsOneWidget);
  });

  testWidgets('카드를 누르면 해당 프리셋을 올려보낸다', (tester) async {
    InterviewPreset? tapped;
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
        home: Scaffold(
          body: ListView(
            children: [
              PresetPicker(
                selected: InterviewPreset.standard,
                onSelected: (preset) => tapped = preset,
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('심층'));
    await tester.pumpAndSettle();

    expect(tapped, InterviewPreset.deep);
  });

  test('질문 수로 프리셋을 되찾고, 없는 값이면 실전으로 떨어진다', () {
    expect(InterviewPreset.fromQuestionCount(5), InterviewPreset.quick);
    expect(InterviewPreset.fromQuestionCount(15), InterviewPreset.deep);
    expect(InterviewPreset.fromQuestionCount(7), InterviewPreset.standard);
  });
}
