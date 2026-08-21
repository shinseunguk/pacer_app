import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pacer_app/core/theme/app_theme.dart';
import 'package:pacer_app/domain/entities/interview_message.dart';
import 'package:pacer_app/domain/entities/interview_report.dart';
import 'package:pacer_app/domain/entities/interview_session.dart';
import 'package:pacer_app/domain/repositories/interview_repository.dart';
import 'package:pacer_app/l10n/app_localizations.dart';
import 'package:pacer_app/presentation/history/history_screen.dart';
import 'package:pacer_app/presentation/history/widgets/growth_chart.dart';
import 'package:pacer_app/presentation/interview/report/widgets/radar_chart.dart';
import 'package:pacer_app/presentation/providers/interview_providers.dart';

class _MockInterviewRepository extends Mock implements InterviewRepository {}

InterviewSummary summary({
  required String id,
  int? score,
  String? passResult,
  SessionStatus status = SessionStatus.completed,
  required int day,
}) => InterviewSummary(
  id: id,
  role: '백엔드',
  interviewType: 'general',
  status: status,
  score: score,
  passResult: passResult,
  createdAt: DateTime.utc(2026, 8, day),
);

const _report = InterviewReport(
  overallScore: 72,
  showScore: true,
  passResult: 'pass',
  passReason: '근거',
  weightPreset: 'general',
  scores: [
    CriterionScore(criterion: 'logic', score: 82, weight: 0.25),
    CriterionScore(criterion: 'job_fit', score: 78, weight: 0.25),
    CriterionScore(criterion: 'structure', score: 61, weight: 0.25),
    CriterionScore(criterion: 'keyword', score: 80, weight: 0.25),
  ],
);

void main() {
  late _MockInterviewRepository repository;

  Future<void> pumpHistory(
    WidgetTester tester,
    List<InterviewSummary> items,
  ) async {
    when(
      () => repository.getHistory(
        cursor: any(named: 'cursor'),
        limit: any(named: 'limit'),
      ),
    ).thenAnswer(
      (_) async => InterviewHistoryPage(items: items, nextCursor: null),
    );
    when(() => repository.getDetail(any())).thenAnswer(
      (_) async => InterviewDetail(
        id: 's',
        interviewType: 'general',
        difficulty: 'mid',
        status: SessionStatus.completed,
        role: '백엔드',
        progress: const InterviewProgress(current: 5, total: 5),
        createdAt: DateTime.utc(2026, 8, 20),
        messages: const [],
        report: _report,
        feedback: null,
      ),
    );

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
          home: const HistoryScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  setUp(() {
    repository = _MockInterviewRepository();
  });

  testWidgets('기록이 없으면 첫 면접을 유도한다', (tester) async {
    await pumpHistory(tester, []);

    expect(find.text('아직 기록이 없어요'), findsOneWidget);
    expect(find.text('첫 면접 시작하기'), findsOneWidget);
    expect(find.byType(GrowthChart), findsNothing);
  });

  testWidgets('완주 1회로는 추이를 그리지 않고, 그 기록은 보여준다', (tester) async {
    // 비교 대상이 없으면 "성장"이 성립하지 않는다.
    await pumpHistory(tester, [summary(id: 'a', score: 70, day: 20)]);

    expect(find.text('아직 기록이 없어요'), findsOneWidget);
    expect(find.byType(GrowthChart), findsNothing);
    expect(find.text('면접 이력'), findsOneWidget);
  });

  testWidgets('완주 2회부터 추이와 지표가 보인다', (tester) async {
    await pumpHistory(tester, [
      summary(id: 'b', score: 82, passResult: 'pass', day: 20),
      summary(id: 'a', score: 70, passResult: 'fail', day: 18),
    ]);

    expect(find.byType(GrowthChart), findsOneWidget);
    expect(find.text('종합 점수 추이'), findsOneWidget);
    expect(find.text('82'), findsWidgets);
    // 70 → 82 이므로 +12
    expect(find.textContaining('12'), findsWidgets);
    expect(find.text('연속 연습'), findsOneWidget);
    expect(find.text('총 면접'), findsOneWidget);
  });

  testWidgets('역량 탭은 최근 면접의 항목별 점수와 약점을 보여준다', (tester) async {
    await pumpHistory(tester, [
      summary(id: 'b', score: 82, day: 20),
      summary(id: 'a', score: 70, day: 18),
    ]);

    await tester.tap(find.text('역량'));
    await tester.pumpAndSettle();

    expect(find.byType(RadarChart), findsOneWidget);
    // 가중치가 같으면 최저 점수가 약점이다 — structure(61).
    expect(find.textContaining('답변 구조'), findsWidgets);
    expect(find.textContaining('61'), findsWidgets);
  });

  testWidgets('진행 중인 면접은 점으로 잡지 않는다', (tester) async {
    await pumpHistory(tester, [
      summary(id: 'c', status: SessionStatus.inProgress, day: 21),
      summary(id: 'b', score: 82, day: 20),
      summary(id: 'a', score: 70, day: 18),
    ]);

    // 총 면접은 3회지만 추이 점은 2개다.
    expect(find.text('3회'), findsOneWidget);
    expect(find.byType(GrowthChart), findsOneWidget);
  });
}
