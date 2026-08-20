import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pacer_app/core/theme/app_theme.dart';
import 'package:pacer_app/domain/entities/entitlement.dart';
import 'package:pacer_app/domain/entities/interview_report.dart';
import 'package:pacer_app/domain/entities/interview_message.dart';
import 'package:pacer_app/domain/entities/interview_session.dart';
import 'package:pacer_app/domain/repositories/interview_repository.dart';
import 'package:pacer_app/domain/repositories/subscription_repository.dart';
import 'package:pacer_app/l10n/app_localizations.dart';
import 'package:pacer_app/presentation/interview/report/report_screen.dart';
import 'package:pacer_app/presentation/interview/report/widgets/radar_chart.dart';
import 'package:pacer_app/presentation/interview/report/widgets/score_ring.dart';
import 'package:pacer_app/presentation/providers/app_providers.dart';
import 'package:pacer_app/presentation/providers/interview_providers.dart';

class _MockInterviewRepository extends Mock implements InterviewRepository {}

class _MockSubscriptionRepository extends Mock
    implements SubscriptionRepository {}

const _sessionId = 'session-1';

const _fourCriteria = [
  CriterionScore(criterion: 'logic', score: 72, weight: 0.3),
  CriterionScore(criterion: 'job_fit', score: 65, weight: 0.3),
  CriterionScore(criterion: 'structure', score: 80, weight: 0.2),
  CriterionScore(criterion: 'keyword', score: 58, weight: 0.2),
];

InterviewReport _report({
  bool showScore = true,
  List<CriterionScore> scores = _fourCriteria,
}) => InterviewReport(
  overallScore: 71,
  showScore: showScore,
  passResult: 'pass',
  passReason: '핵심 경험을 구체적으로 설명했습니다.',
  weightPreset: 'general',
  scores: scores,
);

const _proEntitlement = Entitlement(
  plan: SubscriptionPlan.pro,
  isPro: true,
  expiresAt: null,
  autoRenewing: true,
  freeInterviewsUsed: 0,
  freeInterviewsRemaining: 0,
);

void main() {
  late _MockInterviewRepository repository;
  late _MockSubscriptionRepository subscriptions;

  Future<void> pumpReport(
    WidgetTester tester, {
    InterviewReport? report,
    ThemeData? theme,
  }) async {
    when(
      () => repository.complete(any()),
    ).thenAnswer((_) async => report ?? _report());
    when(() => repository.getDetail(any())).thenAnswer(
      (_) async => InterviewDetail(
        id: _sessionId,
        interviewType: 'general',
        difficulty: 'mid',
        status: SessionStatus.completed,
        role: '백엔드',
        progress: const InterviewProgress(current: 5, total: 5),
        createdAt: DateTime.utc(2026, 8, 20),
        messages: const [],
        report: null,
        feedback: null,
      ),
    );
    when(
      () => subscriptions.getEntitlement(),
    ).thenAnswer((_) async => _proEntitlement);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          interviewRepositoryProvider.overrideWithValue(repository),
          subscriptionRepositoryProvider.overrideWithValue(subscriptions),
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
          home: const ReportScreen(sessionId: _sessionId),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  setUp(() {
    repository = _MockInterviewRepository();
    subscriptions = _MockSubscriptionRepository();
  });

  testWidgets('종합 점수를 원형 게이지로, 항목별 점수를 레이더로 보여준다', (tester) async {
    await pumpReport(tester);

    expect(find.byType(ScoreRing), findsOneWidget);
    expect(find.byType(RadarChart), findsOneWidget);
    expect(find.text('71'), findsOneWidget);
  });

  testWidgets('라이트 모드에서도 같은 구성을 그린다', (tester) async {
    await pumpReport(tester, theme: AppTheme.light());

    expect(find.byType(ScoreRing), findsOneWidget);
    expect(find.byType(RadarChart), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('점수를 꺼둔 면접은 게이지 대신 합불과 근거만 남긴다', (tester) async {
    await pumpReport(tester, report: _report(showScore: false));

    expect(find.byType(ScoreRing), findsNothing);
    expect(find.byType(RadarChart), findsNothing);
    // 점수를 껐어도 합불과 근거는 그대로 제공된다.
    expect(find.text('합격'), findsOneWidget);
    expect(find.text('핵심 경험을 구체적으로 설명했습니다.'), findsOneWidget);
    expect(find.text('점수 표시를 꺼둔 면접이에요.'), findsOneWidget);
  });

  testWidgets('평가 항목이 2개로 줄면 레이더 대신 막대만 남는다', (tester) async {
    // 항목 수는 서버가 정한다 — 줄어들어도 화면이 깨지면 안 된다.
    await pumpReport(
      tester,
      report: _report(
        scores: const [
          CriterionScore(criterion: 'logic', score: 72, weight: 0.5),
          CriterionScore(criterion: 'job_fit', score: 65, weight: 0.5),
        ],
      ),
    );

    expect(find.byType(RadarChart), findsNothing);
    expect(find.byType(ScoreRing), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
