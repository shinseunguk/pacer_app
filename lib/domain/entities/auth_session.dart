/// Result of a social sign-in.
class AuthSession {
  const AuthSession({
    required this.accessToken,
    required this.refreshToken,
    required this.isNewUser,
    required this.onboardingCompleted,
  });

  final String accessToken;
  final String refreshToken;
  final bool isNewUser;

  /// False until the user finishes nickname + required agreements (S02/S03).
  final bool onboardingCompleted;
}
