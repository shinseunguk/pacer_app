import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pacer_app/core/theme/app_theme.dart';
import 'package:pacer_app/domain/entities/entitlement.dart';
import 'package:pacer_app/domain/entities/interview_session.dart';
import 'package:pacer_app/domain/entities/usage_summary.dart';
import 'package:pacer_app/domain/entities/user_profile.dart';
import 'package:pacer_app/domain/repositories/interview_repository.dart';
import 'package:pacer_app/domain/repositories/subscription_repository.dart';
import 'package:pacer_app/domain/repositories/user_repository.dart';
import 'package:pacer_app/l10n/app_localizations.dart';
import 'package:pacer_app/presentation/home/home_screen.dart';
import 'package:pacer_app/presentation/providers/app_providers.dart';
import 'package:pacer_app/presentation/providers/interview_providers.dart';

class _MockUserRepository extends Mock implements UserRepository {}

class _MockInterviewRepository extends Mock implements InterviewRepository {}

class _MockSubscriptionRepository extends Mock
    implements SubscriptionRepository {}

Entitlement _free(int remaining) => Entitlement(
  plan: SubscriptionPlan.free,
  isPro: false,
  expiresAt: null,
  autoRenewing: false,
  freeInterviewsUsed: kFreeInterviewLimit - remaining,
  freeInterviewsRemaining: remaining,
);

const _profile = UserProfile(
  id: 'user-1',
  nickname: '승욱',
  email: null,
  isPro: false,
  usage: UsageSummary(
    date: '2026-08-16',
    baseQuestionUsed: 13,
    limit: 20,
    remaining: 7,
  ),
);

InterviewSummary _summary({
  int? score,
  String? passResult,
  String? role = '백엔드',
  SessionStatus status = SessionStatus.completed,
}) => InterviewSummary(
  id: 'session-1',
  role: role,
  interviewType: 'pressure',
  status: status,
  score: score,
  passResult: passResult,
  createdAt: DateTime(2026, 8, 15),
);

void main() {
  late _MockUserRepository userRepository;
  late _MockInterviewRepository interviewRepository;
  late _MockSubscriptionRepository subscriptionRepository;

  Future<void> pumpHome(
    WidgetTester tester, {
    List<InterviewSummary> history = const [],
    Entitlement? entitlement,
  }) async {
    when(() => subscriptionRepository.getEntitlement()).thenAnswer(
      (_) async => entitlement ?? _free(kFreeInterviewLimit),
    );
    when(() => userRepository.getMyProfile()).thenAnswer((_) async => _profile);
    when(
      () => interviewRepository.getHistory(
        cursor: any(named: 'cursor'),
        limit: any(named: 'limit'),
      ),
    ).thenAnswer(
      (_) async => InterviewHistoryPage(items: history, nextCursor: null),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userRepositoryProvider.overrideWithValue(userRepository),
          interviewRepositoryProvider.overrideWithValue(interviewRepository),
          subscriptionRepositoryProvider.overrideWithValue(
            subscriptionRepository,
          ),
        ],
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
          home: const HomeScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  setUp(() {
    userRepository = _MockUserRepository();
    interviewRepository = _MockInterviewRepository();
    subscriptionRepository = _MockSubscriptionRepository();
  });

  testWidgets('인사·사용량·히어로 CTA를 시안 구성대로 보여준다', (tester) async {
    await pumpHome(tester);

    expect(find.text('안녕하세요, 승욱님'), findsOneWidget);
    expect(find.text('오늘도 한 발 앞서 준비해볼까요?'), findsOneWidget);
    expect(find.text('새 면접 시작하기'), findsOneWidget);
    expect(find.text('공고 입력'), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });

  group('이용권 스트립', () {
    testWidgets('무료는 남은 횟수를 보여주고 자정 초기화라고 하지 않는다', (tester) async {
      // 무료 2회는 평생 누적이라 리셋되지 않는다 — 기존 문구가 오해를 준다 (#21).
      await pumpHome(tester, entitlement: _free(2));

      expect(find.text('무료 체험'), findsOneWidget);
      expect(find.text('2회 남음'), findsOneWidget);
      expect(find.text('5문항 면접 · 자정 초기화 없음'), findsOneWidget);
      expect(find.textContaining('자정 초기화 ·'), findsNothing);
    });

    testWidgets('무료를 다 쓰면 그 사실을 알리고 페이월 입구가 된다', (tester) async {
      await pumpHome(tester, entitlement: _free(0));

      expect(find.text('0회 남음'), findsOneWidget);
      expect(find.text('무료 체험을 모두 사용했어요'), findsOneWidget);
    });

    testWidgets('구독자는 무제한과 갱신일을 보여준다', (tester) async {
      await pumpHome(
        tester,
        entitlement: Entitlement(
          plan: SubscriptionPlan.pro,
          isPro: true,
          expiresAt: DateTime.utc(2026, 9, 20, 3),
          autoRenewing: true,
          freeInterviewsUsed: 2,
          freeInterviewsRemaining: 0,
        ),
      );

      expect(find.text('Pro · 무제한'), findsOneWidget);
      expect(find.textContaining('갱신'), findsOneWidget);
      expect(find.text('무료 체험'), findsNothing);
    });

    testWidgets('해지한 구독자에게는 갱신일 대신 만료 안내를 보여준다', (tester) async {
      await pumpHome(
        tester,
        entitlement: Entitlement(
          plan: SubscriptionPlan.pro,
          isPro: true,
          expiresAt: DateTime.utc(2026, 9, 20),
          autoRenewing: false,
          freeInterviewsUsed: 0,
          freeInterviewsRemaining: 0,
        ),
      );

      expect(find.text('기간 만료 후 무료로 전환돼요'), findsOneWidget);
    });
  });

  testWidgets('기록이 없으면 첫 면접을 유도한다', (tester) async {
    await pumpHome(tester);

    expect(find.textContaining('아직 진행한 면접이 없어요'), findsOneWidget);
  });

  testWidgets('최근 면접은 점수와 함께 카드로 보여준다', (tester) async {
    await pumpHome(
      tester,
      history: [_summary(score: 78, passResult: 'pass')],
    );

    expect(find.text('백엔드'), findsOneWidget);
    expect(find.text('78'), findsOneWidget);
    expect(find.textContaining('압박 면접'), findsOneWidget);
  });

  testWidgets('완료 전 면접은 점수 대신 진행 중으로 표시한다', (tester) async {
    await pumpHome(
      tester,
      history: [_summary(status: SessionStatus.inProgress)],
    );

    expect(find.text('진행 중'), findsOneWidget);
  });

  testWidgets('직무를 고르지 않은 면접은 유형 대신 "직무 미지정"으로 보여준다', (tester) async {
    // 예전에는 유형으로 대체해 "압박 / 압박 면접"처럼 같은 말이 두 번 나왔다.
    await pumpHome(tester, history: [_summary(role: null, score: 47)]);

    expect(find.text('직무 미지정'), findsOneWidget);
    expect(find.text('압박'), findsNothing);
  });
}
