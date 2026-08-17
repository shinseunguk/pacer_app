import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pacer_app/main.dart' as app;

/// 마이 → 닉네임 수정 흐름을 실제로 눌러 확인한다 (서버 필요).
///
/// ```
/// (pacer_server) npm run start:dev
/// (pacer_app)    flutter test integration_test/nickname_edit_test.dart \
///                  -d <simulator-id> --dart-define-from-file=env/dev.json
/// ```
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('닉네임을 수정하면 홈 인사에 반영된다', (tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // 온보딩 전이면 이 테스트는 대상이 아니다.
    if (find.text('마이').evaluate().isEmpty) {
      markTestSkipped('로그인·온보딩이 끝난 상태에서만 실행합니다.');
      return;
    }

    await tester.tap(find.text('마이'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // 프로필 카드를 눌러 수정 화면으로
    await tester.tap(find.text('닉네임 수정').first);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    final field = find.byType(TextField);
    expect(field, findsOneWidget);

    // 규칙 위반 — 저장 버튼이 잠긴다
    await tester.enterText(field, 'ㅋㅋ');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.textContaining('한글·영문·숫자·이모지'), findsWidgets);

    final saveButton = find.widgetWithText(FilledButton, '저장');
    expect(tester.widget<FilledButton>(saveButton).onPressed, isNull);

    // 이모지 포함 새 닉네임 — 중복 확인 통과 후 저장
    final newNickname = '페이서${DateTime.now().second}🔥';
    await tester.enterText(field, newNickname);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(tester.widget<FilledButton>(saveButton).onPressed, isNotNull);
    await tester.tap(saveButton);
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // 마이 화면으로 돌아오고 새 닉네임이 보인다
    expect(find.text(newNickname), findsWidgets);

    // 홈 인사에도 반영
    await tester.tap(find.text('홈'));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.textContaining(newNickname), findsOneWidget);
  });
}
