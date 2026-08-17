import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pacer_app/core/error/failure.dart';
import 'package:pacer_app/domain/entities/agreements.dart';
import 'package:pacer_app/domain/entities/auth_session.dart';
import 'package:pacer_app/domain/entities/social_provider.dart';
import 'package:pacer_app/domain/repositories/auth_repository.dart';
import 'package:pacer_app/domain/repositories/user_repository.dart';
import 'package:pacer_app/presentation/auth/auth_notifier.dart';
import 'package:pacer_app/presentation/providers/app_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockUserRepository extends Mock implements UserRepository {}

const _allAgreed = Agreements(
  terms: true,
  privacy: true,
  llmConsent: true,
  marketing: false,
);

AuthSession _session({bool onboardingCompleted = false}) => AuthSession(
  accessToken: 'access',
  refreshToken: 'refresh',
  isNewUser: !onboardingCompleted,
  onboardingCompleted: onboardingCompleted,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _MockAuthRepository authRepository;
  late _MockUserRepository userRepository;

  setUpAll(() {
    registerFallbackValue(SocialProvider.kakao);
    registerFallbackValue(const Agreements());
  });

  Future<ProviderContainer> createContainer({
    bool onboardingCompleted = false,
  }) async {
    SharedPreferences.setMockInitialValues({
      if (onboardingCompleted) 'pacer.onboarding_completed': true,
    });
    final prefs = await SharedPreferences.getInstance();

    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        authRepositoryProvider.overrideWithValue(authRepository),
        userRepositoryProvider.overrideWithValue(userRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  setUp(() {
    authRepository = _MockAuthRepository();
    userRepository = _MockUserRepository();

    when(() => authRepository.hasStoredSession()).thenAnswer((_) async => false);
    when(() => authRepository.signOut()).thenAnswer((_) async {});
    when(
      () => userRepository.completeOnboarding(
        nickname: any(named: 'nickname'),
        agreements: any(named: 'agreements'),
      ),
    ).thenAnswer((_) async {});
  });

  group('앱 시작(build)', () {
    test('저장된 세션이 없으면 미인증', () async {
      final container = await createContainer();

      final status = await container.read(authNotifierProvider.future);

      expect(status, AuthStatus.unauthenticated);
    });

    test('세션이 있고 온보딩까지 마쳤으면 인증 완료', () async {
      when(
        () => authRepository.hasStoredSession(),
      ).thenAnswer((_) async => true);
      final container = await createContainer(onboardingCompleted: true);

      final status = await container.read(authNotifierProvider.future);

      expect(status, AuthStatus.authenticated);
    });

    test('세션은 있지만 온보딩 전이면 온보딩 필요', () async {
      when(
        () => authRepository.hasStoredSession(),
      ).thenAnswer((_) async => true);
      final container = await createContainer();

      final status = await container.read(authNotifierProvider.future);

      expect(status, AuthStatus.onboardingRequired);
    });
  });

  group('signIn', () {
    test('신규 사용자는 온보딩으로 보낸다', () async {
      when(
        () => authRepository.signIn(any()),
      ).thenAnswer((_) async => _session());
      final container = await createContainer();
      await container.read(authNotifierProvider.future);

      await container
          .read(authNotifierProvider.notifier)
          .signIn(SocialProvider.kakao);

      expect(
        container.read(authNotifierProvider).value,
        AuthStatus.onboardingRequired,
      );
    });

    test('온보딩을 마친 사용자는 바로 홈 상태가 된다', () async {
      when(
        () => authRepository.signIn(any()),
      ).thenAnswer((_) async => _session(onboardingCompleted: true));
      final container = await createContainer();
      await container.read(authNotifierProvider.future);

      await container
          .read(authNotifierProvider.notifier)
          .signIn(SocialProvider.apple);

      expect(
        container.read(authNotifierProvider).value,
        AuthStatus.authenticated,
      );
      expect(container.read(sessionPrefsProvider).onboardingCompleted, isTrue);
    });

    test('로그인 실패는 AsyncError로 노출하고 상태를 바꾸지 않는다', () async {
      when(
        () => authRepository.signIn(any()),
      ).thenThrow(const NetworkFailure());
      final container = await createContainer();
      await container.read(authNotifierProvider.future);

      await container
          .read(authNotifierProvider.notifier)
          .signIn(SocialProvider.kakao);

      final state = container.read(authNotifierProvider);
      expect(state.hasError, isTrue);
      expect(state.error, isA<NetworkFailure>());
      expect(state.valueOrNull, AuthStatus.unauthenticated);
    });
  });

  test('온보딩을 마치면 인증 완료로 바뀌고 플래그가 저장된다', () async {
    when(() => authRepository.hasStoredSession()).thenAnswer((_) async => true);
    final container = await createContainer();
    await container.read(authNotifierProvider.future);

    await container
        .read(authNotifierProvider.notifier)
        .completeOnboarding(nickname: '승욱', agreements: _allAgreed);

    expect(container.read(authNotifierProvider).value, AuthStatus.authenticated);
    expect(container.read(sessionPrefsProvider).onboardingCompleted, isTrue);
    verify(
      () => userRepository.completeOnboarding(
        nickname: '승욱',
        agreements: _allAgreed,
      ),
    ).called(1);
  });

  test('로그아웃하면 미인증으로 돌아가고 플래그가 지워진다', () async {
    when(() => authRepository.hasStoredSession()).thenAnswer((_) async => true);
    final container = await createContainer(onboardingCompleted: true);
    await container.read(authNotifierProvider.future);

    await container.read(authNotifierProvider.notifier).signOut();

    expect(
      container.read(authNotifierProvider).value,
      AuthStatus.unauthenticated,
    );
    expect(container.read(sessionPrefsProvider).onboardingCompleted, isFalse);
  });

  test('세션 만료 통보를 받으면 즉시 미인증이 된다', () async {
    when(() => authRepository.hasStoredSession()).thenAnswer((_) async => true);
    final container = await createContainer(onboardingCompleted: true);
    await container.read(authNotifierProvider.future);

    await container.read(authNotifierProvider.notifier).handleSessionExpired();

    expect(
      container.read(authNotifierProvider).value,
      AuthStatus.unauthenticated,
    );
  });
}
