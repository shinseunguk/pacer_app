import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pacer_app/main.dart' as app;

/// 진행 중인 면접을 목록에서 눌러 **이어서 진행**할 수 있는지 확인한다.
///
/// 예전에는 읽기 전용 대화 전문으로 빠져 이어하기가 불가능했다 (pacer_server#17).
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('홈에서 진행 중인 면접을 누르면 이어서 진행된다', (tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // ── 로그인 · 온보딩 (필요할 때만) ──────────────────────
    final kakao = find.text('카카오로 시작하기');
    if (kakao.evaluate().isNotEmpty) {
      await tester.tap(kakao);
      await tester.pumpAndSettle(const Duration(seconds: 3));
    }
    if (find.text('어떻게 불러드릴까요?').evaluate().isNotEmpty) {
      await tester.enterText(
        find.byType(TextField),
        '이어${DateTime.now().millisecondsSinceEpoch % 10000}',
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await tester.tap(find.text('다음'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('전체 동의'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('시작하기'));
      await tester.pumpAndSettle(const Duration(seconds: 3));
    }

    // ── 면접을 하나 만들고 첫 질문만 받은 채 홈으로 나온다 ──────
    await tester.tap(find.text('새 면접 시작하기'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.enterText(
      find.byType(TextField).first,
      '주요 업무: 이어하기 확인용 공고',
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.text('건너뛰기'));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.text('면접 시작'));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.textContaining('질문 1/'), findsOneWidget);

    // 저장하고 나가기 → 홈
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // ── 목록에서 진행 중인 면접을 누른다 ────────────────────
    final inProgress = find.text('진행 중').first;
    expect(inProgress, findsOneWidget);

    await tester.tap(inProgress);
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // 대화 전문(읽기 전용)이 아니라 면접 진행 화면이어야 한다.
    expect(find.text('대화 전문'), findsNothing);
    expect(find.text('면접 진행'), findsOneWidget);
    expect(find.text('모르겠습니다'), findsOneWidget);

    // 실제로 이어서 답변할 수 있다.
    await tester.enterText(find.byType(TextField).first, '이어서 답변합니다.');
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.text('이어서 답변합니다.'), findsOneWidget);
  });
}
