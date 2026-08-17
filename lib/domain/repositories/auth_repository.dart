import '../entities/auth_session.dart';
import '../entities/social_provider.dart';

abstract interface class AuthRepository {
  /// Acquires a provider token, exchanges it for Pacer tokens and stores them.
  Future<AuthSession> signIn(SocialProvider provider);

  /// True when a token pair is already on the device (app launch, S00).
  Future<bool> hasStoredSession();

  /// Revokes the refresh token server-side and clears local storage.
  Future<void> signOut();
}
