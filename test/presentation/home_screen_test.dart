import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pacer_app/core/theme/app_theme.dart';
import 'package:pacer_app/domain/entities/interview_session.dart';
import 'package:pacer_app/domain/entities/usage_summary.dart';
import 'package:pacer_app/domain/entities/user_profile.dart';
import 'package:pacer_app/domain/repositories/interview_repository.dart';
import 'package:pacer_app/domain/repositories/user_repository.dart';
import 'package:pacer_app/l10n/app_localizations.dart';
import 'package:pacer_app/presentation/home/home_screen.dart';
import 'package:pacer_app/presentation/providers/app_providers.dart';
import 'package:pacer_app/presentation/providers/interview_providers.dart';

class _MockUserRepository extends Mock implements UserRepository {}

class _MockInterviewRepository extends Mock implements InterviewRepository {}

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

InterviewSummary _summary({int? score, String? passResult}) => InterviewSummary(
  id: 'session-1',
  role: '백엔드',
  interviewType: 'pressure',
  score: score,
  passResult: passResult,
  createdAt: DateTime(2026, 8, 15),
);

void main() {
  late _MockUserRepository userRepository;
  late _MockInterviewRepository interviewRepository;

  Future<void> pumpHome(
    WidgetTester tester, {
    List<InterviewSummary> history = const [],
  }) async {
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
  });

  testWidgets('인사·사용량·히어로 CTA를 시안 구성대로 보여준다', (tester) async {
    await pumpHome(tester);

    expect(find.text('안녕하세요, 승욱님'), findsOneWidget);
    expect(find.text('오늘도 한 발 앞서 준비해볼까요?'), findsOneWidget);
    // 사용량은 "쓴 개수/한도"로 표기한다.
    expect(find.textContaining('13'), findsWidgets);
    expect(find.text('새 면접 시작하기'), findsOneWidget);
    expect(find.text('공고 입력'), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
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
    await pumpHome(tester, history: [_summary()]);

    expect(find.text('진행 중'), findsOneWidget);
  });
}
