import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pacer_app/core/error/failure.dart';
import 'package:pacer_app/domain/repositories/user_repository.dart';
import 'package:pacer_app/presentation/onboarding/nickname_check_notifier.dart';
import 'package:pacer_app/presentation/providers/app_providers.dart';

class _MockUserRepository extends Mock implements UserRepository {}

/// 디바운스(400ms)보다 넉넉히 기다린다.
const _afterDebounce = Duration(milliseconds: 600);

void main() {
  late _MockUserRepository repository;

  ProviderContainer createContainer() {
    final container = ProviderContainer(
      overrides: [userRepositoryProvider.overrideWithValue(repository)],
    );
    // autoDispose 프로바이더라 구독이 없으면 폐기된다 — 화면이 보고 있는 상황을 흉내낸다.
    container.listen(nicknameCheckProvider, (_, _) {});
    addTearDown(container.dispose);
    return container;
  }

  setUp(() {
    repository = _MockUserRepository();
    when(
      () => repository.isNicknameAvailable(any()),
    ).thenAnswer((_) async => true);
  });

  test('빈 입력은 아무것도 표시하지 않는다', () {
    final container = createContainer();
    final notifier = container.read(nicknameCheckProvider.notifier);

    notifier.onChanged('   ');

    expect(container.read(nicknameCheckProvider).status, NicknameStatus.idle);
    expect(container.read(nicknameCheckProvider).canSubmit, isFalse);
  });

  test('규칙 위반은 서버에 묻지 않고 즉시 막는다', () async {
    final container = createContainer();

    container.read(nicknameCheckProvider.notifier).onChanged('ㅋㅋ');

    final state = container.read(nicknameCheckProvider);
    expect(state.status, NicknameStatus.invalid);
    expect(state.isError, isTrue);
    expect(state.canSubmit, isFalse);

    await Future<void>.delayed(_afterDebounce);
    verifyNever(() => repository.isNicknameAvailable(any()));
  });

  test('규칙을 통과하면 잠시 뒤 서버에 중복을 확인한다', () async {
    final container = createContainer();

    container.read(nicknameCheckProvider.notifier).onChanged('승욱');
    expect(
      container.read(nicknameCheckProvider).status,
      NicknameStatus.checking,
    );

    await Future<void>.delayed(_afterDebounce);

    final state = container.read(nicknameCheckProvider);
    expect(state.status, NicknameStatus.available);
    expect(state.canSubmit, isTrue);
    verify(() => repository.isNicknameAvailable('승욱')).called(1);
  });

  test('이미 쓰는 닉네임이면 진행을 막는다', () async {
    when(
      () => repository.isNicknameAvailable(any()),
    ).thenAnswer((_) async => false);
    final container = createContainer();

    container.read(nicknameCheckProvider.notifier).onChanged('승욱');
    await Future<void>.delayed(_afterDebounce);

    final state = container.read(nicknameCheckProvider);
    expect(state.status, NicknameStatus.taken);
    expect(state.canSubmit, isFalse);
    expect(state.message, contains('이미 사용'));
  });

  test('타이핑이 이어지면 마지막 입력만 확인한다(디바운스)', () async {
    final container = createContainer();
    final notifier = container.read(nicknameCheckProvider.notifier);

    notifier.onChanged('승');
    notifier.onChanged('승욱');
    notifier.onChanged('승욱이');
    await Future<void>.delayed(_afterDebounce);

    verify(() => repository.isNicknameAvailable('승욱이')).called(1);
    verifyNever(() => repository.isNicknameAvailable('승욱'));
  });

  test('확인에 실패해도 제출은 막지 않는다(서버가 최종 판정)', () async {
    when(
      () => repository.isNicknameAvailable(any()),
    ).thenThrow(const NetworkFailure());
    final container = createContainer();

    container.read(nicknameCheckProvider.notifier).onChanged('승욱');
    await Future<void>.delayed(_afterDebounce);

    final state = container.read(nicknameCheckProvider);
    expect(state.status, NicknameStatus.checkFailed);
    expect(state.canSubmit, isTrue);
  });

  test('이모지 닉네임도 확인 대상이다', () async {
    final container = createContainer();

    container.read(nicknameCheckProvider.notifier).onChanged('승욱🔥');
    await Future<void>.delayed(_afterDebounce);

    expect(
      container.read(nicknameCheckProvider).status,
      NicknameStatus.available,
    );
    verify(() => repository.isNicknameAvailable('승욱🔥')).called(1);
  });
}
