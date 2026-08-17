import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pacer_app/core/router/app_router.dart';
import 'package:pacer_app/core/router/routes.dart';
import 'package:pacer_app/presentation/auth/auth_notifier.dart';

void main() {
  group('세션 확인 중', () {
    test('스플래시로 모은다', () {
      const loading = AsyncLoading<AuthStatus>();

      expect(redirectFor(loading, AppRoutes.home), AppRoutes.splash);
      expect(redirectFor(loading, AppRoutes.splash), isNull);
    });
  });

  group('미인증', () {
    const state = AsyncData(AuthStatus.unauthenticated);

    test('로그인 화면으로 보낸다', () {
      expect(redirectFor(state, AppRoutes.home), AppRoutes.login);
      expect(redirectFor(state, AppRoutes.interviewPrep), AppRoutes.login);
      expect(redirectFor(state, AppRoutes.login), isNull);
    });
  });

  group('온보딩 미완료', () {
    const state = AsyncData(AuthStatus.onboardingRequired);

    test('온보딩 밖으로 나가면 닉네임 화면으로 되돌린다', () {
      expect(redirectFor(state, AppRoutes.home), AppRoutes.onboardingNickname);
      expect(redirectFor(state, AppRoutes.onboardingNickname), isNull);
      expect(redirectFor(state, AppRoutes.onboardingConsent), isNull);
    });
  });

  group('인증 완료', () {
    const state = AsyncData(AuthStatus.authenticated);

    test('진입 화면에 있으면 홈으로 보낸다', () {
      expect(redirectFor(state, AppRoutes.login), AppRoutes.home);
      expect(redirectFor(state, AppRoutes.splash), AppRoutes.home);
      expect(redirectFor(state, AppRoutes.onboardingConsent), AppRoutes.home);
    });

    test('일반 화면은 그대로 둔다', () {
      expect(redirectFor(state, AppRoutes.home), isNull);
      expect(redirectFor(state, AppRoutes.interviewPrep), isNull);
    });
  });

  group('약관·처리방침', () {
    test('어떤 상태에서도 가드를 통과한다', () {
      const legal = '/legal/privacy';

      expect(redirectFor(const AsyncLoading<AuthStatus>(), legal), isNull);
      expect(
        redirectFor(const AsyncData(AuthStatus.unauthenticated), legal),
        isNull,
      );
      expect(
        redirectFor(const AsyncData(AuthStatus.onboardingRequired), legal),
        isNull,
      );
      expect(
        redirectFor(const AsyncData(AuthStatus.authenticated), legal),
        isNull,
      );
    });
  });

  test('로그인 중(이전 상태 유지)에는 현재 화면을 지킨다', () {
    const signingIn = AsyncLoading<AuthStatus>();
    final withPrevious = signingIn.copyWithPrevious(
      const AsyncData(AuthStatus.unauthenticated),
    );

    expect(redirectFor(withPrevious, AppRoutes.login), isNull);
  });
}
