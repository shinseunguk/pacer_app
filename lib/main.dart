import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'presentation/providers/app_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = AppConfig.fromEnvironment();
  // 키가 없으면 목 로그인을 쓰므로 SDK를 초기화하지 않는다.
  if (config.hasKakaoKey) {
    KakaoSdk.init(nativeAppKey: config.kakaoNativeAppKey);
  }

  // SharedPreferences는 동기 접근이 필요해 부팅 시 한 번 로드하고 주입한다.
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const PacerApp(),
    ),
  );
}
