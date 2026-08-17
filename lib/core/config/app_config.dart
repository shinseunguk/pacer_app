/// Build flavors. Injected with `--dart-define=FLAVOR=dev|prod`.
enum Flavor { dev, prod }

/// Environment configuration.
///
/// Values come from `--dart-define`(-from-file) so nothing is hardcoded per build:
/// `flutter run --dart-define-from-file=env/dev.json`
class AppConfig {
  const AppConfig({
    required this.apiBaseUrl,
    required this.flavor,
    required this.kakaoNativeAppKey,
  });

  final String apiBaseUrl;
  final Flavor flavor;

  /// 카카오 네이티브 앱 키 — 콘솔에서 발급받아 dart-define으로 주입한다.
  /// 비어 있으면 목 로그인으로 폴백한다(키 없는 개발 환경 유지).
  final String kakaoNativeAppKey;

  static const _defaultBaseUrl = 'http://localhost:3000/v1';

  factory AppConfig.fromEnvironment() {
    const flavorName = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
    const baseUrl = String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: _defaultBaseUrl,
    );

    const kakaoKey = String.fromEnvironment('KAKAO_NATIVE_APP_KEY');

    return const AppConfig(
      apiBaseUrl: baseUrl,
      flavor: flavorName == 'prod' ? Flavor.prod : Flavor.dev,
      kakaoNativeAppKey: kakaoKey,
    );
  }

  bool get isDev => flavor == Flavor.dev;

  bool get hasKakaoKey => kakaoNativeAppKey.isNotEmpty;

  /// 카카오 키가 없는 개발 환경에서는 서버의 목 검증기와 짝을 이루는
  /// 목 로그인을 쓴다 (idToken == socialId).
  bool get useMockSocialLogin => isDev && !hasKakaoKey;
}
