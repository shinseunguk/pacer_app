import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pacer_app/main.dart' as app;

/// 실기기/시뮬레이터 통합 테스트 — 로그인(dev 목) → 온보딩 → 홈까지 실제로 탭한다.
///
/// 서버가 떠 있어야 한다:
/// ```
/// (pacer_server) docker compose up -d && npm run start:dev
/// (pacer_app)    flutter test integration_test -d <simulator-id> \
///                  --dart-define-from-file=env/dev.json
/// ```
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('로그인 → 온보딩 → 홈', (tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(milliseconds: 300));

    // 이미 로그인된 상태면 로그인 화면을 건너뛴다(목 계정은 기기당 동일).
    final kakao = find.text('카카오로 시작하기');
    if (kakao.evaluate().isNotEmpty) {
      await tester.tap(kakao);
      await tester.pumpAndSettle(const Duration(seconds: 3));
    }

    final nicknameField = find.byType(TextField);
    if (nicknameField.evaluate().isNotEmpty) {
      await tester.enterText(nicknameField.first, '승욱');
      await tester.pumpAndSettle();

      await tester.tap(find.text('다음'));
      await tester.pumpAndSettle();

      // 동의 화면 — 전체 동의 후 시작
      await tester.tap(find.text('전체 동의'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('시작하기'));
      await tester.pumpAndSettle(const Duration(seconds: 3));
    }

    // 홈 도착: 인사 문구 + 히어로 CTA + 하단 탭
    expect(find.textContaining('안녕하세요'), findsOneWidget);
    expect(find.text('새 면접 시작하기'), findsOneWidget);
    expect(find.text('기록'), findsOneWidget);

    // 탭 이동이 동작하는지 확인
    await tester.tap(find.text('마이'));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('로그아웃'), findsOneWidget);
  });
}
