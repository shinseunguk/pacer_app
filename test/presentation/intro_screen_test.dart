import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pacer_app/core/router/app_router.dart';
import 'package:pacer_app/core/router/routes.dart';
import 'package:pacer_app/core/storage/session_prefs.dart';
import 'package:pacer_app/core/theme/app_theme.dart';
import 'package:pacer_app/l10n/app_localizations.dart';
import 'package:pacer_app/presentation/auth/auth_notifier.dart';
import 'package:pacer_app/presentation/onboarding/intro_screen.dart';
import 'package:pacer_app/presentation/providers/app_providers.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SessionPrefs> makePrefs({bool introSeen = false}) async {
  SharedPreferences.setMockInitialValues(
    introSeen ? {'pacer.intro_seen': true} : {},
  );
  return SessionPrefs(await SharedPreferences.getInstance());
}

Future<void> pumpIntro(WidgetTester tester, SessionPrefs prefs) async {
  // 건너뛰기·시작하기가 로그인으로 넘어가므로 라우터가 있어야 한다.
  final router = GoRouter(
    initialLocation: AppRoutes.intro,
    routes: [
      GoRoute(path: AppRoutes.intro, builder: (_, _) => const IntroScreen()),
      GoRoute(
        path: AppRoutes.login,
        builder: (_, _) => const Scaffold(body: Text('로그인 화면')),
      ),
    ],
  );

  await tester.pumpWidget(
    ProviderScope(
      overrides: [sessionPrefsProvider.overrideWithValue(prefs)],
      child: MaterialApp.router(
        routerConfig: router,
        theme: AppTheme.dark(),
        localizationsDelegates: const [
          AppL10n.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppL10n.supportedLocales,
        locale: const Locale('ko'),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('첫 장은 서비스가 뭔지부터 말한다', (tester) async {
    await pumpIntro(tester, await makePrefs());

    expect(find.text('AI 면접 코치'), findsOneWidget);
    expect(find.text('면접, 혼자\n뛰지 마세요'), findsOneWidget);
    expect(find.text('다음'), findsOneWidget);
  });

  testWidgets('세 장을 넘기면 마지막에 시작하기가 뜬다', (tester) async {
    await pumpIntro(tester, await makePrefs());

    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();
    expect(find.text('맞춤 질문 · 꼬리질문'), findsOneWidget);

    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();
    expect(find.text('정량 피드백 · 성장 추적'), findsOneWidget);
    expect(find.text('시작하기'), findsOneWidget);
    expect(find.text('다음'), findsNothing);
  });

  testWidgets('마지막 장에는 건너뛰기가 없다 — 건너뛸 게 없다', (tester) async {
    await pumpIntro(tester, await makePrefs());

    expect(find.text('건너뛰기'), findsOneWidget);

    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('다음'));
    await tester.pumpAndSettle();

    expect(find.text('건너뛰기'), findsNothing);
  });

  testWidgets('건너뛰면 본 것으로 기록한다', (tester) async {
    final prefs = await makePrefs();
    await pumpIntro(tester, prefs);

    await tester.tap(find.text('건너뛰기'));
    await tester.pumpAndSettle();

    expect(prefs.introSeen, isTrue);
    expect(find.text('로그인 화면'), findsOneWidget);
  });

  testWidgets('좁고 낮은 화면에서도 넘치지 않는다', (tester) async {
    // 아트가 고정 크기라 작은 기기(SE 등)에서 오버플로가 났다.
    tester.view.physicalSize = const Size(320 * 3, 568 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await pumpIntro(tester, await makePrefs());

    expect(tester.takeException(), isNull);
  });

  group('라우팅', () {
    const unauthenticated = AsyncData(AuthStatus.unauthenticated);

    test('인트로를 안 봤으면 로그인보다 인트로가 먼저다', () {
      expect(
        redirectFor(unauthenticated, AppRoutes.splash, introSeen: false),
        AppRoutes.intro,
      );
      expect(
        redirectFor(unauthenticated, AppRoutes.intro, introSeen: false),
        isNull,
      );
    });

    test('한 번 봤으면 바로 로그인으로 간다', () {
      expect(
        redirectFor(unauthenticated, AppRoutes.splash, introSeen: true),
        AppRoutes.login,
      );
      // 다시 들어가려 해도 로그인으로 돌린다.
      expect(
        redirectFor(unauthenticated, AppRoutes.intro, introSeen: true),
        AppRoutes.login,
      );
    });

    test('로그인된 사용자는 인트로를 지나 홈으로', () {
      expect(
        redirectFor(
          const AsyncData(AuthStatus.authenticated),
          AppRoutes.intro,
          introSeen: false,
        ),
        AppRoutes.home,
      );
    });

    test('약관은 인트로 전에도 읽을 수 있다', () {
      expect(
        redirectFor(unauthenticated, '/legal/terms', introSeen: false),
        isNull,
      );
    });
  });
}
