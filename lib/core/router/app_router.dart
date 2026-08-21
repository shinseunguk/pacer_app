import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/legal_document.dart';
import '../../presentation/auth/auth_notifier.dart';
import '../../presentation/providers/app_providers.dart';
import '../../presentation/purchases/paywall_screen.dart';
import '../../presentation/auth/login_screen.dart';
import '../../presentation/legal/legal_document_screen.dart';
import '../../presentation/history/history_screen.dart';
import '../../presentation/history/transcript_screen.dart';
import '../../presentation/common/app_shell.dart';
import '../../presentation/home/home_screen.dart';
import '../../presentation/interview/prep/applicant_info_screen.dart';
import '../../presentation/interview/prep/interview_options_screen.dart';
import '../../presentation/interview/prep/interview_prep_screen.dart';
import '../../presentation/interview/prep/job_category_screen.dart';
import '../../presentation/interview/report/report_screen.dart';
import '../../presentation/interview/session/interview_screen.dart';
import '../../presentation/onboarding/consent_screen.dart';
import '../../presentation/onboarding/intro_screen.dart';
import '../../presentation/onboarding/nickname_screen.dart';
import '../../presentation/profile/nickname_edit_screen.dart';
import '../../presentation/profile/profile_screen.dart';
import '../../presentation/settings/settings_screen.dart';
import '../../presentation/splash/splash_screen.dart';
import 'routes.dart';

/// Declarative routing with a login guard (S00 → S01/S02/S10 분기).
final appRouterProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<AsyncValue<AuthStatus>>(
    const AsyncLoading<AuthStatus>(),
  );
  ref.listen(
    authNotifierProvider,
    (_, next) => refresh.value = next,
    fireImmediately: true,
  );
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: refresh,
    routes: [
      GoRoute(path: AppRoutes.splash, builder: (_, _) => const SplashScreen()),
      GoRoute(path: AppRoutes.intro, builder: (_, _) => const IntroScreen()),
      GoRoute(path: AppRoutes.login, builder: (_, _) => const LoginScreen()),
      GoRoute(
        path: AppRoutes.onboardingNickname,
        builder: (_, _) => const NicknameScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboardingConsent,
        builder: (_, _) => const ConsentScreen(),
      ),
      // 홈·기록·마이는 하단 탭 셸 안에서 상태를 유지한다(시안 BottomTab).
      StatefulShellRoute.indexedStack(
        builder: (_, _, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (_, _) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.history,
                builder: (_, _) => const HistoryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (_, _) => const ProfileScreen(),
                routes: [
                  GoRoute(
                    path: 'nickname',
                    builder: (_, _) => const NicknameEditScreen(),
                  ),
                  GoRoute(
                    path: 'settings',
                    builder: (_, _) => const SettingsScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      // `/interviews/new*`가 `/interviews/:id`보다 먼저 와야 세션 id로 오인되지 않는다.
      GoRoute(
        path: AppRoutes.interviewPrep,
        builder: (_, _) => const InterviewPrepScreen(),
      ),
      GoRoute(
        path: AppRoutes.interviewJobCategory,
        builder: (_, _) => const JobCategoryScreen(),
      ),
      GoRoute(
        path: AppRoutes.interviewApplicant,
        builder: (_, _) => const ApplicantInfoScreen(),
      ),
      GoRoute(
        path: AppRoutes.interviewOptions,
        builder: (_, _) => const InterviewOptionsScreen(),
      ),
      GoRoute(
        path: AppRoutes.interviewReportPattern,
        builder: (_, state) =>
            ReportScreen(sessionId: state.pathParameters['id'] ?? ''),
      ),
      GoRoute(
        path: AppRoutes.interviewSessionPattern,
        builder: (_, state) =>
            InterviewScreen(sessionId: state.pathParameters['id'] ?? ''),
      ),

      // 페이월은 어느 화면에서든 위로 덮인다 — 셸(하단 탭) 밖에 둔다.
      GoRoute(
        path: AppRoutes.paywall,
        builder: (_, _) => const PaywallScreen(),
      ),

      GoRoute(
        path: AppRoutes.legalPattern,
        builder: (_, state) => LegalDocumentScreen(
          type: LegalDocumentType.fromValue(state.pathParameters['type'] ?? ''),
        ),
      ),

      GoRoute(
        path: AppRoutes.transcriptPattern,
        builder: (_, state) =>
            TranscriptScreen(sessionId: state.pathParameters['id'] ?? ''),
      ),
    ],
    redirect: (context, state) => _redirect(
      refresh.value,
      state.matchedLocation,
      introSeen: ref.read(sessionPrefsProvider).introSeen,
    ),
  );
});

/// Pure so it can be unit tested without a widget tree.
@visibleForTesting
String? redirectFor(
  AsyncValue<AuthStatus> auth,
  String location, {
  bool introSeen = true,
}) => _redirect(auth, location, introSeen: introSeen);

String? _redirect(
  AsyncValue<AuthStatus> auth,
  String location, {
  required bool introSeen,
}) {
  // 약관·처리방침은 로그인 전·세션 확인 중에도 읽을 수 있어야 한다.
  if (location.startsWith('/legal')) return null;

  // 아직 세션 확인 중(또는 복구 실패)이면 스플래시에 머문다.
  final status = auth.valueOrNull;
  if (status == null) {
    return location == AppRoutes.splash ? null : AppRoutes.splash;
  }

  final isOnboarding = location.startsWith('/onboarding');

  switch (status) {
    case AuthStatus.unauthenticated:
      // 소셜 로그인은 마찰이 큰 단계다. 무엇을 해주는 서비스인지 모른 채
      // 계정부터 요구하면 거기서 이탈한다 — 인트로를 먼저 보여준다.
      if (!introSeen) {
        return location == AppRoutes.intro ? null : AppRoutes.intro;
      }
      return location == AppRoutes.login ? null : AppRoutes.login;
    case AuthStatus.onboardingRequired:
      return isOnboarding ? null : AppRoutes.onboardingNickname;
    case AuthStatus.authenticated:
      final isEntryScreen =
          location == AppRoutes.login ||
          location == AppRoutes.splash ||
          location == AppRoutes.intro ||
          isOnboarding;
      return isEntryScreen ? AppRoutes.home : null;
  }
}
