import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pacer_app/core/error/failure.dart';
import 'package:pacer_app/domain/repositories/auth_repository.dart';
import 'package:pacer_app/domain/repositories/user_repository.dart';
import 'package:pacer_app/presentation/auth/auth_notifier.dart';
import 'package:pacer_app/presentation/providers/app_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockUserRepository extends Mock implements UserRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _MockAuthRepository authRepository;
  late _MockUserRepository userRepository;

  Future<ProviderContainer> createContainer() async {
    SharedPreferences.setMockInitialValues({
      'pacer.onboarding_completed': true,
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

    when(() => authRepository.hasStoredSession()).thenAnswer((_) async => true);
    when(() => authRepository.signOut()).thenAnswer((_) async {});
    when(() => userRepository.withdraw()).thenAnswer((_) async {});
  });

  test('탈퇴하면 파기 요청 후 세션을 지우고 미인증이 된다', () async {
    final container = await createContainer();
    await container.read(authNotifierProvider.future);

    await container.read(authNotifierProvider.notifier).withdraw();

    verify(() => userRepository.withdraw()).called(1);
    // 서버가 재발급을 끊어도 기기의 토큰은 직접 지워야 한다.
    verify(() => authRepository.signOut()).called(1);
    expect(
      container.read(authNotifierProvider).value,
      AuthStatus.unauthenticated,
    );
    expect(container.read(sessionPrefsProvider).onboardingCompleted, isFalse);
  });

  test('활성 구독이면 탈퇴가 막히고 로그인 상태가 유지된다', () async {
    when(() => userRepository.withdraw()).thenThrow(
      const ServerFailure('구독이 활성 상태예요.', code: 'ACTIVE_SUBSCRIPTION'),
    );
    final container = await createContainer();
    await container.read(authNotifierProvider.future);

    await container.read(authNotifierProvider.notifier).withdraw();

    final state = container.read(authNotifierProvider);
    expect(state.hasError, isTrue);
    expect((state.error as Failure).code, 'ACTIVE_SUBSCRIPTION');
    // 실패했으므로 로그아웃되지 않는다.
    verifyNever(() => authRepository.signOut());
    expect(state.valueOrNull, AuthStatus.authenticated);
  });

  test('탈퇴 요청이 실패하면 토큰을 지우지 않는다', () async {
    when(() => userRepository.withdraw()).thenThrow(const NetworkFailure());
    final container = await createContainer();
    await container.read(authNotifierProvider.future);

    await container.read(authNotifierProvider.notifier).withdraw();

    verifyNever(() => authRepository.signOut());
    expect(container.read(authNotifierProvider).hasError, isTrue);
  });
}
