/// Social sign-in providers supported in Phase A (Google is P1).
enum SocialProvider {
  kakao('kakao'),
  apple('apple');

  const SocialProvider(this.value);

  /// Path segment used by `POST /auth/login/{provider}`.
  final String value;
}
