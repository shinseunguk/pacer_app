import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/agreements.dart';
import '../../domain/entities/social_provider.dart';
import '../providers/app_providers.dart';

/// Where the user stands in the entry flow (S00 분기 기준).
enum AuthStatus { unauthenticated, onboardingRequired, authenticated }

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, AuthStatus>(
  AuthNotifier.new,
);

class AuthNotifier extends AsyncNotifier<AuthStatus> {
  @override
  Future<AuthStatus> build() async {
    final hasSession = await ref
        .read(authRepositoryProvider)
        .hasStoredSession();
    if (!hasSession) return AuthStatus.unauthenticated;

    return ref.read(sessionPrefsProvider).onboardingCompleted
        ? AuthStatus.authenticated
        : AuthStatus.onboardingRequired;
  }

  Future<void> signIn(SocialProvider provider) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final session = await ref.read(signInWithSocialProvider)(provider);
      await ref
          .read(sessionPrefsProvider)
          .setOnboardingCompleted(session.onboardingCompleted);

      return session.onboardingCompleted
          ? AuthStatus.authenticated
          : AuthStatus.onboardingRequired;
    });
  }

  Future<void> completeOnboarding({
    required String nickname,
    required Agreements agreements,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(completeOnboardingProvider)(
        nickname: nickname,
        agreements: agreements,
      );
      await ref.read(sessionPrefsProvider).setOnboardingCompleted(true);
      return AuthStatus.authenticated;
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(signOutProvider)();
      await ref.read(sessionPrefsProvider).clear();
      return AuthStatus.unauthenticated;
    });
  }

  /// 회원 탈퇴 — 파기 요청 후 로그인 화면으로 돌아간다.
  Future<void> withdraw() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(withdrawAccountProvider)();
      await ref.read(sessionPrefsProvider).clear();
      return AuthStatus.unauthenticated;
    });
  }

  /// Called by the auth interceptor when a refresh finally fails.
  Future<void> handleSessionExpired() async {
    await ref.read(sessionPrefsProvider).clear();
    state = const AsyncData(AuthStatus.unauthenticated);
  }
}
