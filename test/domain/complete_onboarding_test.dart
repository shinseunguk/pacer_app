import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pacer_app/core/error/failure.dart';
import 'package:pacer_app/domain/entities/agreements.dart';
import 'package:pacer_app/domain/repositories/user_repository.dart';
import 'package:pacer_app/domain/usecases/complete_onboarding.dart';

class _MockUserRepository extends Mock implements UserRepository {}

const _allAgreed = Agreements(
  terms: true,
  privacy: true,
  llmConsent: true,
  marketing: false,
);

void main() {
  late _MockUserRepository repository;
  late CompleteOnboardingUseCase useCase;

  setUpAll(() {
    registerFallbackValue(const Agreements());
  });

  setUp(() {
    repository = _MockUserRepository();
    useCase = CompleteOnboardingUseCase(repository);
    when(
      () => repository.completeOnboarding(
        nickname: any(named: 'nickname'),
        agreements: any(named: 'agreements'),
      ),
    ).thenAnswer((_) async {});
  });

  test('닉네임을 trim해서 저장한다', () async {
    await useCase(nickname: '  승욱  ', agreements: _allAgreed);

    verify(
      () => repository.completeOnboarding(
        nickname: '승욱',
        agreements: _allAgreed,
      ),
    ).called(1);
  });

  test('닉네임이 비면 요청하지 않고 ValidationFailure', () async {
    await expectLater(
      useCase(nickname: '   ', agreements: _allAgreed),
      throwsA(isA<ValidationFailure>()),
    );
    verifyNever(
      () => repository.completeOnboarding(
        nickname: any(named: 'nickname'),
        agreements: any(named: 'agreements'),
      ),
    );
  });

  test('닉네임이 20자를 넘으면 ValidationFailure', () async {
    await expectLater(
      useCase(nickname: 'a' * 21, agreements: _allAgreed),
      throwsA(isA<ValidationFailure>()),
    );
  });

  test('필수 동의가 빠지면 ValidationFailure', () async {
    await expectLater(
      useCase(
        nickname: '승욱',
        agreements: const Agreements(terms: true, privacy: true),
      ),
      throwsA(
        isA<ValidationFailure>().having(
          (failure) => failure.code,
          'code',
          'AGREEMENT_REQUIRED',
        ),
      ),
    );
  });

  test('Agreements 전체 토글은 선택 항목까지 함께 바꾼다', () {
    const empty = Agreements();

    expect(empty.copyWithAll(true).allAccepted, isTrue);
    expect(empty.copyWithAll(true).allRequiredAccepted, isTrue);
    expect(empty.copyWithAll(false).allRequiredAccepted, isFalse);
  });
}
