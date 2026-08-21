import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pacer_app/core/theme/app_theme.dart';
import 'package:pacer_app/domain/entities/entitlement.dart';
import 'package:pacer_app/domain/entities/usage_summary.dart';
import 'package:pacer_app/domain/entities/user_profile.dart';
import 'package:pacer_app/domain/repositories/subscription_repository.dart';
import 'package:pacer_app/domain/repositories/user_repository.dart';
import 'package:pacer_app/l10n/app_localizations.dart';
import 'package:pacer_app/presentation/profile/profile_screen.dart';
import 'package:pacer_app/presentation/providers/app_providers.dart';

class _MockUserRepository extends Mock implements UserRepository {}

class _MockSubscriptionRepository extends Mock
    implements SubscriptionRepository {}

/// 서버는 여전히 일일 질문 수를 세어 내려준다 — 화면에만 안 보이면 된다.
const _profile = UserProfile(
  id: 'user-1',
  nickname: '승욱',
  email: 'me@example.com',
  isPro: false,
  usage: UsageSummary(
    date: '2026-08-21',
    baseQuestionUsed: 24,
    limit: 20,
    remaining: 0,
  ),
);

Entitlement _free(int remaining) => Entitlement(
  plan: SubscriptionPlan.free,
  isPro: false,
  expiresAt: null,
  autoRenewing: false,
  freeInterviewsUsed: kFreeInterviewLimit - remaining,
  freeInterviewsRemaining: remaining,
);

void main() {
  late _MockUserRepository users;
  late _MockSubscriptionRepository subscriptions;

  Future<void> pumpProfile(WidgetTester tester, Entitlement entitlement) async {
    when(() => users.getMyProfile()).thenAnswer((_) async => _profile);
    when(
      () => subscriptions.getEntitlement(),
    ).thenAnswer((_) async => entitlement);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userRepositoryProvider.overrideWithValue(users),
          subscriptionRepositoryProvider.overrideWithValue(subscriptions),
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
          home: const ProfileScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  setUp(() {
    users = _MockUserRepository();
    subscriptions = _MockSubscriptionRepository();
  });

  testWidgets('죽은 일일 질문 카운터를 더 이상 보여주지 않는다', (tester) async {
    // 하루 20개 한도는 아무것도 막지 않는데 24/20처럼 넘긴 숫자가 그대로 보였다.
    await pumpProfile(tester, _free(2));

    expect(find.text('24/20'), findsNothing);
    expect(find.text('오늘 기본 질문'), findsNothing);
  });

  testWidgets('무료면 남은 횟수를 보여주고 눌러서 구독으로 갈 수 있다', (tester) async {
    await pumpProfile(tester, _free(2));

    expect(find.text('이용권'), findsOneWidget);
    expect(find.text('무료 체험 · 2회 남음'), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right), findsWidgets);
  });

  testWidgets('무료를 다 쓰면 그 사실을 알린다', (tester) async {
    await pumpProfile(tester, _free(0));

    expect(find.text('무료 체험을 모두 사용했어요'), findsOneWidget);
  });

  testWidgets('구독자는 Pro와 갱신일을 보여준다', (tester) async {
    await pumpProfile(
      tester,
      Entitlement(
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
  });
}
