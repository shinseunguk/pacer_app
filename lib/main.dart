import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/observability/scrub_event.dart';
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

  Widget buildApp() => ProviderScope(
    overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    child: const PacerApp(),
  );

  // DSN이 없으면 Sentry를 거치지 않고 그대로 띄운다(로컬 개발·CI).
  if (!config.hasSentryDsn) {
    runApp(buildApp());
    return;
  }

  await SentryFlutter.init(
    (options) {
      options.dsn = config.sentryDsn;
      options.environment = config.flavor.name;

      // 사용자가 면접 답변·자기소개를 직접 입력한다 — 원문이 새지 않게 막는다.
      options.sendDefaultPii = false;
      options.beforeSend = scrubEvent;
      options.beforeBreadcrumb = scrubBreadcrumb;

      // 화면 위젯에 입력값이 그대로 찍힐 수 있어 스크린샷·뷰 계층은 보내지 않는다.
      options.attachScreenshot = false;
      // ignore: experimental_member_use
      options.attachViewHierarchy = false;
    },
    appRunner: () => runApp(buildApp()),
  );
}
