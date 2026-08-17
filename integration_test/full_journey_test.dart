import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pacer_app/main.dart' as app;

/// Phase A 전 구간 스모크 — 실제 서버·시뮬레이터에서 사용자가 하듯 눌러본다.
///
/// ```
/// (pacer_server) npm run start:dev
/// (pacer_app)    flutter test integration_test/full_journey_test.dart \
///                  -d <simulator-id> --dart-define-from-file=env/dev.json
/// ```
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('온보딩 → 면접 생성 → 답변 → 리포트 → 만족도 → 설정', (tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // ── 1. 로그인 · 온보딩 ─────────────────────────────────
    final kakao = find.text('카카오로 시작하기');
    if (kakao.evaluate().isNotEmpty) {
      await tester.tap(kakao);
      await tester.pumpAndSettle(const Duration(seconds: 3));
    }

    if (find.text('어떻게 불러드릴까요?').evaluate().isNotEmpty) {
      final nickname = '스모크${DateTime.now().millisecondsSinceEpoch % 10000}';
      await tester.enterText(find.byType(TextField), nickname);
      // 중복 확인(디바운스 400ms)이 끝나야 다음으로 넘어갈 수 있다.
      await tester.pumpAndSettle(const Duration(seconds: 2));

      await tester.tap(find.text('다음'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('전체 동의'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('시작하기'));
      await tester.pumpAndSettle(const Duration(seconds: 3));
    }

    // ── 2. 홈 ────────────────────────────────────────────
    expect(find.textContaining('안녕하세요'), findsOneWidget);
    expect(find.text('새 면접 시작하기'), findsOneWidget);

    // ── 3. 면접 준비 (공고 붙여넣기 → 지원자 정보 → 설정) ──────
    await tester.tap(find.text('새 면접 시작하기'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.enterText(
      find.byType(TextField).first,
      '주요 업무: 결제 서버 API 개발 및 운영, 대용량 트래픽 처리',
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // 지원자 정보는 선택이라 건너뛴다.
    await tester.tap(find.text('건너뛰기'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.text('면접 설정'), findsOneWidget);
    await tester.tap(find.text('압박'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('면접 시작'));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // ── 4. 면접 진행 — 첫 질문이 오고 답변이 스트리밍된다 ───────
    expect(find.textContaining('질문 1/'), findsOneWidget);

    await tester.enterText(
      find.byType(TextField).first,
      '3년차 백엔드 개발자로 결제 API의 응답 지연을 40% 줄인 경험이 있습니다.',
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // 남은 질문은 스킵으로 빠르게 소진한다.
    for (var i = 0; i < 8; i += 1) {
      final skip = find.text('모르겠습니다');
      if (skip.evaluate().isEmpty) break;

      await tester.tap(skip);
      await tester.pumpAndSettle(const Duration(seconds: 3));
    }

    // ── 5. 리포트 ────────────────────────────────────────
    final finish = find.text('면접 종료하고 리포트 보기');
    expect(finish, findsOneWidget);
    await tester.tap(finish);
    await tester.pumpAndSettle(const Duration(seconds: 6));

    expect(find.text('판정 근거'), findsOneWidget);

    // ── 6. 리포트 만족도 (MVP 성공 기준 §6) ──────────────────
    final feedbackQuestion = find.text('이 리포트가 도움이 되었나요?');
    await tester.scrollUntilVisible(feedbackQuestion, 300);
    await tester.pumpAndSettle();

    await tester.tap(find.text('도움돼요'));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.textContaining('의견 고마워요'), findsOneWidget);

    // ── 7. 홈 복귀 → 히스토리에 남는다 ────────────────────────
    await tester.scrollUntilVisible(find.text('홈으로'), 300);
    await tester.tap(find.text('홈으로'));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    await tester.tap(find.text('기록'));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.textContaining('압박'), findsWidgets);

    // ── 8. 마이 → 설정 → 화면 모드 ──────────────────────────
    await tester.tap(find.text('마이'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(find.byIcon(Icons.settings_outlined));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.text('화면 모드'), findsOneWidget);
    expect(find.text('회원 탈퇴'), findsOneWidget);

    await tester.tap(find.byType(DropdownButton<ThemeMode>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('라이트').last);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(
      Theme.of(tester.element(find.text('화면 모드'))).brightness,
      Brightness.light,
    );
  });
}
