import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pacer_app/core/error/failure.dart';
import 'package:pacer_app/domain/entities/usage_summary.dart';
import 'package:pacer_app/domain/entities/user_profile.dart';
import 'package:pacer_app/domain/repositories/user_repository.dart';
import 'package:pacer_app/domain/usecases/update_nickname.dart';

class _MockUserRepository extends Mock implements UserRepository {}

const _profile = UserProfile(
  id: 'user-1',
  nickname: '승욱',
  email: null,
  isPro: false,
  usage: UsageSummary(
    date: '2026-08-17',
    baseQuestionUsed: 0,
    limit: 20,
    remaining: 20,
  ),
);

void main() {
  late _MockUserRepository repository;
  late UpdateNicknameUseCase useCase;

  setUp(() {
    repository = _MockUserRepository();
    useCase = UpdateNicknameUseCase(repository);
    when(
      () => repository.updateNickname(any()),
    ).thenAnswer((_) async => _profile);
  });

  test('앞뒤 공백을 잘라 저장한다', () async {
    await useCase('  승욱  ');

    verify(() => repository.updateNickname('승욱')).called(1);
  });

  test('이모지 닉네임도 저장한다', () async {
    await useCase('승욱🔥');

    verify(() => repository.updateNickname('승욱🔥')).called(1);
  });

  test('규칙 위반은 서버에 보내지 않는다', () async {
    for (final bad in ['ㅋㅋ', '승욱!', '김', '신 승욱']) {
      await expectLater(useCase(bad), throwsA(isA<ValidationFailure>()));
    }
    verifyNever(() => repository.updateNickname(any()));
  });

  test('중복(409)은 서버 오류를 그대로 전달한다', () async {
    when(() => repository.updateNickname(any())).thenThrow(
      const ServerFailure('이미 사용 중인 닉네임이에요.', code: 'NICKNAME_TAKEN'),
    );

    await expectLater(
      useCase('승욱'),
      throwsA(
        isA<ServerFailure>().having((e) => e.code, 'code', 'NICKNAME_TAKEN'),
      ),
    );
  });
}
