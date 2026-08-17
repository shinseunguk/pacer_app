import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pacer_app/core/error/failure.dart';
import 'package:pacer_app/core/theme/app_theme.dart';
import 'package:pacer_app/domain/entities/interview_report.dart';
import 'package:pacer_app/domain/repositories/interview_repository.dart';
import 'package:pacer_app/l10n/app_localizations.dart';
import 'package:pacer_app/presentation/interview/report/widgets/report_feedback.dart';
import 'package:pacer_app/presentation/providers/interview_providers.dart';

class _MockInterviewRepository extends Mock implements InterviewRepository {}

const _sessionId = 'session-1';

void main() {
  late _MockInterviewRepository repository;

  Future<void> pumpCard(
    WidgetTester tester, {
    SessionFeedback? initial,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [interviewRepositoryProvider.overrideWithValue(repository)],
        child: MaterialApp(
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
            body: ReportFeedbackCard(sessionId: _sessionId, initial: initial),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  setUpAll(() {
    registerFallbackValue(FeedbackRating.up);
  });

  setUp(() {
    repository = _MockInterviewRepository();
    when(
      () => repository.submitFeedback(
        any(),
        rating: any(named: 'rating'),
        comment: any(named: 'comment'),
      ),
    ).thenAnswer(
      (invocation) async => SessionFeedback(
        rating: invocation.namedArguments[#rating] as FeedbackRating,
        comment: invocation.namedArguments[#comment] as String?,
      ),
    );
  });

  testWidgets('👍는 바로 저장하고 감사 문구로 바뀐다', (tester) async {
    await pumpCard(tester);

    expect(find.text('이 리포트가 도움이 되었나요?'), findsOneWidget);

    await tester.tap(find.text('도움돼요'));
    await tester.pumpAndSettle();

    verify(
      () => repository.submitFeedback(
        _sessionId,
        rating: FeedbackRating.up,
        comment: null,
      ),
    ).called(1);
    expect(find.textContaining('의견 고마워요'), findsOneWidget);
  });

  testWidgets('👎는 이유를 물어보고 함께 보낸다', (tester) async {
    await pumpCard(tester);

    await tester.tap(find.text('아쉬워요'));
    await tester.pumpAndSettle();

    // 👎만으로는 아직 보내지 않는다 — 이유를 받는다.
    verifyNever(
      () => repository.submitFeedback(
        any(),
        rating: any(named: 'rating'),
        comment: any(named: 'comment'),
      ),
    );
    expect(find.byType(TextField), findsOneWidget);

    await tester.enterText(find.byType(TextField), '  점수 근거가 약해요  ');
    await tester.tap(find.text('보내기'));
    await tester.pumpAndSettle();

    verify(
      () => repository.submitFeedback(
        _sessionId,
        rating: FeedbackRating.down,
        comment: '점수 근거가 약해요',
      ),
    ).called(1);
  });

  testWidgets('이전에 남긴 평가를 복원한다', (tester) async {
    await pumpCard(
      tester,
      initial: const SessionFeedback(rating: FeedbackRating.up),
    );

    expect(find.textContaining('의견 고마워요'), findsOneWidget);
  });

  testWidgets('전송 실패는 알리고 다시 시도할 수 있게 되돌린다', (tester) async {
    when(
      () => repository.submitFeedback(
        any(),
        rating: any(named: 'rating'),
        comment: any(named: 'comment'),
      ),
    ).thenThrow(const NetworkFailure());
    await pumpCard(tester);

    await tester.tap(find.text('도움돼요'));
    await tester.pumpAndSettle();

    expect(find.byType(SnackBar), findsOneWidget);
    // 감사 문구로 넘어가지 않고 질문이 그대로 남는다.
    expect(find.text('이 리포트가 도움이 되었나요?'), findsOneWidget);
  });
}
