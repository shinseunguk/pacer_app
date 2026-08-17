/// Build flavors. Injected with `--dart-define=FLAVOR=dev|prod`.
enum Flavor { dev, prod }

/// Environment configuration.
///
/// Values come from `--dart-define`(-from-file) so nothing is hardcoded per build:
/// `flutter run --dart-define-from-file=env/dev.json`
class AppConfig {
  const AppConfig({required this.apiBaseUrl, required this.flavor});

  final String apiBaseUrl;
  final Flavor flavor;

  static const _defaultBaseUrl = 'http://localhost:3000/v1';

  factory AppConfig.fromEnvironment() {
    const flavorName = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
    const baseUrl = String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: _defaultBaseUrl,
    );

    return const AppConfig(
      apiBaseUrl: baseUrl,
      flavor: flavorName == 'prod' ? Flavor.prod : Flavor.dev,
    );
  }

  bool get isDev => flavor == Flavor.dev;

  /// Real Kakao/Apple SDK sign-in needs native keys, so dev builds use the
  /// server's mock social verifier instead (idToken == socialId).
  bool get useMockSocialLogin => isDev;
}
