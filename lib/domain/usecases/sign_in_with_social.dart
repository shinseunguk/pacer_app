import '../entities/auth_session.dart';
import '../entities/social_provider.dart';
import '../repositories/auth_repository.dart';

class SignInWithSocialUseCase {
  const SignInWithSocialUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthSession> call(SocialProvider provider) =>
      _repository.signIn(provider);
}
