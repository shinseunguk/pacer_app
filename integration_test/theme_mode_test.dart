import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pacer_app/main.dart' as app;

/// 설정에서 화면 모드를 고르면 실제로 바뀌는지 확인한다 (서버 필요, 온보딩 완료 상태).
/// 앱을 새로 설치하면 세션이 없으므로 필요할 때 로그인·온보딩을 마친다.
Future<void> _ensureSignedIn(WidgetTester tester) async {
  final kakao = find.text('카카오로 시작하기');
  if (kakao.evaluate().isNotEmpty) {
    await tester.tap(kakao);
    await tester.pumpAndSettle(const Duration(seconds: 3));
  }

  final nickname = find.byType(TextField);
  if (nickname.evaluate().isNotEmpty) {
    await tester.enterText(
      nickname.first,
      '모드${DateTime.now().millisecondsSinceEpoch % 100000}',
    );
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('전체 동의'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('시작하기'));
    await tester.pumpAndSettle(const Duration(seconds: 3));
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('설정에서 라이트/다크를 고르면 즉시 적용된다', (tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    await _ensureSignedIn(tester);

    await tester.tap(find.text('마이'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.text('화면 모드'), findsOneWidget);

    // 라이트로 고정
    await tester.tap(find.byType(DropdownButton<ThemeMode>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('라이트').last);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(
      Theme.of(tester.element(find.text('화면 모드'))).brightness,
      Brightness.light,
    );

    // 다크로 고정
    await tester.tap(find.byType(DropdownButton<ThemeMode>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('다크').last);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(
      Theme.of(tester.element(find.text('화면 모드'))).brightness,
      Brightness.dark,
    );

    // 시스템으로 되돌려 둔다
    await tester.tap(find.byType(DropdownButton<ThemeMode>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('시스템 설정').last);
    await tester.pumpAndSettle(const Duration(seconds: 1));
  });
}
