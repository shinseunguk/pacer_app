import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/config/app_config.dart';
import '../../core/error/failure.dart';
import '../../core/network/auth_interceptor.dart';
import '../../core/network/dio_client.dart';
import '../../core/storage/session_prefs.dart';
import '../../core/storage/token_storage.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/datasources/kakao_social_auth_service.dart';
import '../../data/datasources/social_auth_service.dart';
import '../../data/datasources/user_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/entities/social_provider.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/check_nickname.dart';
import '../../domain/usecases/complete_onboarding.dart';
import '../../domain/usecases/get_my_profile.dart';
import '../../domain/usecases/sign_in_with_social.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/update_nickname.dart';
import '../../domain/usecases/withdraw_account.dart';
import '../auth/auth_notifier.dart';

/// Overridden in `main()` after `SharedPreferences.getInstance()`.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider must be overridden');
});

final appConfigProvider = Provider<AppConfig>(
  (ref) => AppConfig.fromEnvironment(),
);

final sessionPrefsProvider = Provider<SessionPrefs>(
  (ref) => SessionPrefs(ref.watch(sharedPreferencesProvider)),
);

final secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(),
);

final tokenStorageProvider = Provider<TokenStorage>(
  (ref) => TokenStorage(ref.watch(secureStorageProvider)),
);

/// Authenticated client. The refresh client is a separate Dio without the
/// auth interceptor so a 401 during refresh cannot loop.
final dioProvider = Provider<Dio>((ref) {
  final config = ref.watch(appConfigProvider);
  final dio = createDio(config);

  dio.interceptors.add(
    AuthInterceptor(
      storage: ref.watch(tokenStorageProvider),
      refreshClient: createDio(config),
      onSessionExpired: () async {
        await ref.read(authNotifierProvider.notifier).handleSessionExpired();
      },
    ),
  );
  return dio;
});

final socialAuthServiceProvider = Provider<SocialAuthService>((ref) {
  final config = ref.watch(appConfigProvider);

  if (config.useMockSocialLogin) return const MockSocialAuthService();
  if (config.hasKakaoKey) return const KakaoSocialAuthService();
  return const UnavailableSocialAuthService();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remote: AuthRemoteDataSource(ref.watch(dioProvider)),
    social: ref.watch(socialAuthServiceProvider),
    storage: ref.watch(tokenStorageProvider),
  );
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(UserRemoteDataSource(ref.watch(dioProvider)));
});

final signInWithSocialProvider = Provider(
  (ref) => SignInWithSocialUseCase(ref.watch(authRepositoryProvider)),
);

final signOutProvider = Provider(
  (ref) => SignOutUseCase(ref.watch(authRepositoryProvider)),
);

final completeOnboardingProvider = Provider(
  (ref) => CompleteOnboardingUseCase(ref.watch(userRepositoryProvider)),
);

final checkNicknameProvider = Provider(
  (ref) => CheckNicknameUseCase(ref.watch(userRepositoryProvider)),
);

final updateNicknameProvider = Provider(
  (ref) => UpdateNicknameUseCase(ref.watch(userRepositoryProvider)),
);

final withdrawAccountProvider = Provider(
  (ref) => WithdrawAccountUseCase(
    user: ref.watch(userRepositoryProvider),
    auth: ref.watch(authRepositoryProvider),
  ),
);

final getMyProfileProvider = Provider(
  (ref) => GetMyProfileUseCase(ref.watch(userRepositoryProvider)),
);

/// Placeholder until the Kakao/Apple SDKs are wired into prod builds.
class UnavailableSocialAuthService implements SocialAuthService {
  const UnavailableSocialAuthService();

  @override
  Future<SocialCredential> authenticate(SocialProvider provider) async {
    throw const ServerFailure('아직 준비 중인 로그인 방식이에요.');
  }
}
