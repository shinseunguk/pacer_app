import '../../domain/entities/social_provider.dart';

/// Token returned by a social SDK and verified server-side.
class SocialCredential {
  const SocialCredential({required this.idToken, this.nonce});

  final String idToken;
  final String? nonce;
}

/// Obtains the provider token that the server verifies.
///
/// Real Kakao/Apple SDK adapters need native keys, so they land right before
/// the closed beta. Dev builds use [MockSocialAuthService], which pairs with
/// the server's MockSocialVerifier (idToken == socialId).
abstract interface class SocialAuthService {
  Future<SocialCredential> authenticate(SocialProvider provider);
}

class MockSocialAuthService implements SocialAuthService {
  const MockSocialAuthService({this.accountId = 'local'});

  /// Same id on every launch so dev sign-in always returns to the same account.
  final String accountId;

  @override
  Future<SocialCredential> authenticate(SocialProvider provider) async {
    return SocialCredential(idToken: '${provider.value}-dev-$accountId');
  }
}
