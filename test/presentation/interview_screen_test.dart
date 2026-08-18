import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pacer_app/core/error/failure.dart';
import 'package:pacer_app/core/theme/app_colors.dart';
import 'package:pacer_app/core/theme/app_theme.dart';
import 'package:pacer_app/domain/entities/interview_message.dart';
import 'package:pacer_app/domain/entities/interview_session.dart';
import 'package:pacer_app/domain/entities/interview_turn_event.dart';
import 'package:pacer_app/domain/repositories/interview_repository.dart';
import 'package:pacer_app/l10n/app_localizations.dart';
import 'package:pacer_app/presentation/common/ui.dart';
import 'package:pacer_app/presentation/interview/session/interview_screen.dart';
import 'package:pacer_app/presentation/interview/session/widgets/chat_bubble.dart';
import 'package:pacer_app/presentation/interview/session/widgets/coach_avatar.dart';
import 'package:pacer_app/presentation/interview/session/widgets/turn_error_card.dart';
import 'package:pacer_app/presentation/interview/session/widgets/typing_dots.dart';
import 'package:pacer_app/presentation/providers/interview_providers.dart';

class _MockInterviewRepository extends Mock implements InterviewRepository {}

const _sessionId = 'session-1';

InterviewDetail _detail({
  String interviewType = 'general',
  int current = 2,
  int total = 5,
  SessionStatus status = SessionStatus.inProgress,
}) {
  return InterviewDetail(
    id: _sessionId,
    interviewType: interviewType,
    difficulty: 'mid',
    status: status,
    role: '백엔드',
    progress: InterviewProgress(current: current, total: total),
    createdAt: DateTime.utc(2026, 8, 18),
    messages: const [
      InterviewMessage(
        messageId: 'q1',
        seq: 1,
        type: MessageType.baseQuestion,
        content: '자기소개 부탁드립니다.',
      ),
    ],
    report: null,
    feedback: null,
  );
}

void main() {
  late _MockInterviewRepository repository;

  Future<void> pumpScreen(
    WidgetTester tester, {
    InterviewDetail? detail,
    ThemeData? theme,
  }) async {
    when(
      () => repository.getDetail(any()),
    ).thenAnswer((_) async => detail ?? _detail());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          interviewRepositoryProvider.overrideWithValue(repository),
        ],
        child: MaterialApp(
          theme: theme ?? AppTheme.dark(),
          localizationsDelegates: const [
            AppL10n.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppL10n.supportedLocales,
          locale: const Locale('ko'),
          home: const InterviewScreen(sessionId: _sessionId),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  PacerProgressBar progressBar(WidgetTester tester) =>
      tester.widget<PacerProgressBar>(find.byType(PacerProgressBar));

  setUp(() {
    repository = _MockInterviewRepository();
  });

  testWidgets('면접관 발화에 로고마크 칩과 "페이서" 라벨을 붙인다', (tester) async {
    await pumpScreen(tester);

    expect(find.byType(CoachAvatar), findsOneWidget);
    expect(find.text('페이서'), findsOneWidget);
    expect(find.text('자기소개 부탁드립니다.'), findsOneWidget);
  });

  testWidgets('진행바를 질문 수만큼 나눈 세그먼트 바로 그린다', (tester) async {
    await pumpScreen(tester);

    final bar = progressBar(tester);
    expect(bar.segments, 5);
    expect(bar.value, 2);
    // 세그먼트 바는 연속 바(LinearProgressIndicator)를 쓰지 않는다.
    expect(find.byType(LinearProgressIndicator), findsNothing);
  });

  testWidgets('압박 면접은 진행바를 pressure 톤으로 칠한다', (tester) async {
    await pumpScreen(tester, detail: _detail(interviewType: 'pressure'));

    expect(progressBar(tester).color, AppColors.dark.pressure);
  });

  testWidgets('라이트 모드에서도 압박 톤은 모드 팔레트를 따른다', (tester) async {
    await pumpScreen(
      tester,
      detail: _detail(interviewType: 'pressure'),
      theme: AppTheme.light(),
    );

    expect(progressBar(tester).color, AppColors.light.pressure);
  });

  testWidgets('일반 면접은 진행바에 기본 강조색을 쓴다', (tester) async {
    await pumpScreen(tester);

    expect(progressBar(tester).color, isNull);
  });

  testWidgets('세그먼트 트랙은 배경에 묻히지 않도록 소프트 톤을 쓴다', (tester) async {
    // 진행바가 카드가 아니라 페이지 배경 위에 놓여, 기본 트랙(surface2)이면
    // 라이트 모드에서 배경과 거의 같은 색이 된다.
    await pumpScreen(tester, theme: AppTheme.light());

    expect(progressBar(tester).trackColor, AppColors.light.accentSoft);
  });

  testWidgets('압박 면접 트랙도 같은 계열의 소프트 톤을 쓴다', (tester) async {
    await pumpScreen(
      tester,
      detail: _detail(interviewType: 'pressure'),
      theme: AppTheme.light(),
    );

    expect(progressBar(tester).trackColor, AppColors.light.pressureSoft);
  });

  testWidgets('답변 말풍선 글자는 강조색 배경 위에서 onAccent를 쓴다', (tester) async {
    when(() => repository.submitAnswer(any(), any())).thenAnswer(
      (_) => const Stream<InterviewTurnEvent>.empty(),
    );

    await pumpScreen(tester, theme: AppTheme.light());
    await tester.enterText(find.byType(TextField), '답변입니다.');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    final answer = tester.widget<Text>(
      find.descendant(of: find.byType(ChatBubble), matching: find.text('답변입니다.')),
    );
    expect(answer.style?.color, AppColors.light.onAccent);
  });

  testWidgets('말풍선 등장 모션은 새로 도착한 발화에만 태운다', (tester) async {
    // 스크롤·재빌드로 다시 그려지는 발화까지 재생하면 대화가 계속 들썩인다.
    when(() => repository.submitAnswer(any(), any())).thenAnswer(
      (_) => const Stream<InterviewTurnEvent>.empty(),
    );

    await pumpScreen(tester);
    expect(tester.widget<ChatBubble>(find.byType(ChatBubble)).animate, isTrue);

    // 답변을 보내면 목록이 다시 빌드된다 — 기존 질문은 재생하지 않아야 한다.
    await tester.enterText(find.byType(TextField), '답변입니다.');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    final bubbles = find.byType(ChatBubble);
    expect(bubbles, findsNWidgets(2));
    expect(tester.widget<ChatBubble>(bubbles.at(0)).animate, isFalse);
    expect(tester.widget<ChatBubble>(bubbles.at(1)).animate, isTrue);
  });

  testWidgets('일시정지를 누르면 바텀시트로 두 갈래를 제시한다', (tester) async {
    await pumpScreen(tester);

    await tester.tap(find.text('일시정지'));
    await tester.pumpAndSettle();

    expect(find.text('면접을 잠시 멈출까요?'), findsOneWidget);
    expect(find.text('이어서 진행'), findsOneWidget);
    expect(find.text('저장하고 나가기'), findsOneWidget);
    // 이어서 진행을 고르면 일시정지 호출 없이 시트만 닫힌다.
    await tester.tap(find.text('이어서 진행'));
    await tester.pumpAndSettle();

    expect(find.text('면접을 잠시 멈출까요?'), findsNothing);
    verifyNever(() => repository.pause(any()));
  });

  testWidgets('발화를 받는 중에는 점 3개 인디케이터를 띄운다', (tester) async {
    final controller = StreamController<InterviewTurnEvent>();
    addTearDown(controller.close);
    when(
      () => repository.submitAnswer(any(), any()),
    ).thenAnswer((_) => controller.stream);

    await pumpScreen(tester);

    await tester.enterText(find.byType(TextField), '답변입니다.');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();

    expect(find.byType(TypingDots), findsOneWidget);
  });

  testWidgets('전송에 실패하면 스낵바 대신 인라인 오류 카드로 재시도를 남긴다', (tester) async {
    when(
      () => repository.submitAnswer(any(), any()),
    ).thenAnswer((_) => Stream.error(const NetworkFailure()));

    await pumpScreen(tester);

    await tester.enterText(find.byType(TextField), '답변입니다.');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    expect(find.byType(TurnErrorCard), findsOneWidget);
    expect(find.text('다시 시도'), findsOneWidget);
    expect(find.byType(SnackBar), findsNothing);
    // 답변은 그대로 두어 다시 보낼 수 있게 한다.
    expect(find.text('답변입니다.'), findsWidgets);
  });

  testWidgets('다시 시도는 실패한 답변을 겹쳐 쌓지 않는다', (tester) async {
    when(
      () => repository.submitAnswer(any(), any()),
    ).thenAnswer((_) => Stream.error(const NetworkFailure()));

    await pumpScreen(tester);

    await tester.enterText(find.byType(TextField), '답변입니다.');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    await tester.tap(find.text('다시 시도'));
    await tester.pumpAndSettle();

    verify(() => repository.submitAnswer(_sessionId, '답변입니다.')).called(2);
    // 말풍선 하나 + 입력창에 남은 텍스트 하나 = 2. 재시도로 늘지 않는다.
    expect(find.text('답변입니다.'), findsNWidgets(2));
  });
}
