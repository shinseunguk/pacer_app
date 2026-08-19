import 'package:flutter_test/flutter_test.dart';
import 'package:pacer_app/core/config/app_config.dart';

void main() {
  group('소셜 로그인 방식 결정', () {
    test('dev + 카카오 키 없음 → 목 로그인', () {
      const config = AppConfig(
        apiBaseUrl: 'http://localhost:3000/v1',
        flavor: Flavor.dev,
        kakaoNativeAppKey: '',
      sentryDsn: '',
      );

      expect(config.hasKakaoKey, isFalse);
      expect(config.useMockSocialLogin, isTrue);
    });

    test('dev + 카카오 키 있음 → 실제 카카오', () {
      const config = AppConfig(
        apiBaseUrl: 'http://localhost:3000/v1',
        flavor: Flavor.dev,
        kakaoNativeAppKey: 'abc123',
      sentryDsn: '',
      );

      expect(config.hasKakaoKey, isTrue);
      // 키가 있으면 dev에서도 실제 로그인을 쓴다.
      expect(config.useMockSocialLogin, isFalse);
    });

    test('prod는 키가 없어도 목을 쓰지 않는다', () {
      const config = AppConfig(
        apiBaseUrl: 'https://api.pacer.app/v1',
        flavor: Flavor.prod,
        kakaoNativeAppKey: '',
      sentryDsn: '',
      );

      expect(config.useMockSocialLogin, isFalse);
    });
  });
}
