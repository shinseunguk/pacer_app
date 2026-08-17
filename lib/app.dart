import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';

class PacerApp extends ConsumerWidget {
  const PacerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Pacer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(platform: defaultTargetPlatform),
      darkTheme: AppTheme.dark(platform: defaultTargetPlatform),
      // 시안이 라이트·다크를 모두 정의하므로 기기 설정을 따른다.
      themeMode: ThemeMode.system,
      routerConfig: ref.watch(appRouterProvider),
      localizationsDelegates: const [
        AppL10n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppL10n.supportedLocales,
    );
  }
}
