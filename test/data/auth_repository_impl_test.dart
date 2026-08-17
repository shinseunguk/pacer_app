import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pacer_app/core/error/failure.dart';
import 'package:pacer_app/core/storage/token_storage.dart';
import 'package:pacer_app/data/datasources/auth_remote_data_source.dart';
import 'package:pacer_app/data/datasources/social_auth_service.dart';
import 'package:pacer_app/data/models/auth_session_model.dart';
import 'package:pacer_app/data/repositories/auth_repository_impl.dart';
import 'package:pacer_app/domain/entities/social_provider.dart';

class _MockRemote extends Mock implements AuthRemoteDataSource {}

class _MockSocial extends Mock implements SocialAuthService {}

class _MockStorage extends Mock implements TokenStorage {}

const _model = AuthSessionModel(
  accessToken: 'access-1',
  refreshToken: 'refresh-1',
  isNewUser: true,
);

void main() {
  late _MockRemote remote;
  late _MockSocial social;
  late _MockStorage storage;
  late AuthRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(SocialProvider.kakao);
    registerFallbackValue(
      const StoredTokens(accessToken: '', refreshToken: ''),
    );
  });

  setUp(() {
    remote = _MockRemote();
    social = _MockSocial();
    storage = _MockStorage();
    repository = AuthRepositoryImpl(
      remote: remote,
      social: social,
      storage: storage,
    );

    when(
      () => social.authenticate(any()),
    ).thenAnswer((_) async => const SocialCredential(idToken: 'kakao-dev'));
    when(
      () => remote.login(any(), any(), nonce: any(named: 'nonce')),
    ).thenAnswer((_) async => _model);
    when(() => storage.save(any())).thenAnswer((_) async {});
    when(() => storage.clear()).thenAnswer((_) async {});
    when(() => remote.logout()).thenAnswer((_) async {});
  });

  test('로그인에 성공하면 토큰을 보안 저장소에 남긴다', () async {
    final session = await repository.signIn(SocialProvider.kakao);

    expect(session.accessToken, 'access-1');
    expect(session.onboardingCompleted, isFalse);
    final saved = verify(() => storage.save(captureAny())).captured.single;
    expect((saved as StoredTokens).refreshToken, 'refresh-1');
  });

  test('서버 오류는 Failure로 변환해 던진다', () async {
    when(() => remote.login(any(), any(), nonce: any(named: 'nonce'))).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/auth/login/kakao'),
        type: DioExceptionType.connectionError,
      ),
    );

    await expectLater(
      repository.signIn(SocialProvider.kakao),
      throwsA(isA<NetworkFailure>()),
    );
    verifyNever(() => storage.save(any()));
  });

  test('로그아웃 API가 실패해도 로컬 토큰은 지운다', () async {
    when(() => remote.logout()).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/auth/logout'),
        type: DioExceptionType.connectionError,
      ),
    );

    await repository.signOut();

    verify(() => storage.clear()).called(1);
  });

  test('저장된 토큰이 있으면 세션이 있다고 본다', () async {
    when(() => storage.read()).thenAnswer(
      (_) async =>
          const StoredTokens(accessToken: 'a', refreshToken: 'r'),
    );

    await expectLater(repository.hasStoredSession(), completion(isTrue));

    when(() => storage.read()).thenAnswer((_) async => null);
    await expectLater(repository.hasStoredSession(), completion(isFalse));
  });
}
