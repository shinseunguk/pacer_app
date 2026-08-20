import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pacer_app/core/theme/app_theme.dart';
import 'package:pacer_app/domain/entities/entitlement.dart';
import 'package:pacer_app/domain/entities/interview_setup.dart';
import 'package:pacer_app/domain/repositories/subscription_repository.dart';
import 'package:pacer_app/l10n/app_localizations.dart';
import 'package:pacer_app/presentation/interview/prep/interview_options_screen.dart';
import 'package:pacer_app/presentation/interview/prep/interview_setup_notifier.dart';
import 'package:pacer_app/presentation/providers/app_providers.dart';

class _MockSubscriptionRepository extends Mock
    implements SubscriptionRepository {}

const _free = Entitlement(
  plan: SubscriptionPlan.free,
  isPro: false,
  expiresAt: null,
  autoRenewing: false,
  freeInterviewsUsed: 0,
  freeInterviewsRemaining: kFreeInterviewLimit,
);

const _pro = Entitlement(
  plan: SubscriptionPlan.pro,
  isPro: true,
  expiresAt: null,
  autoRenewing: true,
  freeInterviewsUsed: 0,
  freeInterviewsRemaining: 0,
);

void main() {
  late _MockSubscriptionRepository repository;
  late ProviderContainer container;

  Future<void> pumpOptions(WidgetTester tester, Entitlement entitlement) async {
    when(
      () => repository.getEntitlement(),
    ).thenAnswer((_) async => entitlement);

    final scope = ProviderScope(
      overrides: [subscriptionRepositoryProvider.overrideWithValue(repository)],
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
        home: const InterviewOptionsScreen(),
      ),
    );

    await tester.pumpWidget(scope);
    await tester.pumpAndSettle();

    container = ProviderScope.containerOf(
      tester.element(find.byType(InterviewOptionsScreen)),
    );
  }

  setUp(() {
    repository = _MockSubscriptionRepository();
  });

  testWidgets('무료 사용자는 잠긴 기본값 대신 고를 수 있는 길이로 시작한다', (tester) async {
    // 기본값은 '실전'(10문항)이라 그대로 두면 잠긴 카드가 선택된 채로 뜨고,
    // 시작을 누르면 402를 맞는다.
    await pumpOptions(tester, _free);

    expect(
      container.read(interviewSetupProvider).questionCount,
      kFreeQuestionCount,
    );
    expect(find.byIcon(Icons.lock_outline), findsNWidgets(2));
  });

  testWidgets('구독자는 기본값(실전 10문항) 그대로 두고 잠금이 없다', (tester) async {
    await pumpOptions(tester, _pro);

    expect(
      container.read(interviewSetupProvider).questionCount,
      kDefaultQuestionCount,
    );
    expect(find.byIcon(Icons.lock_outline), findsNothing);
  });
}
