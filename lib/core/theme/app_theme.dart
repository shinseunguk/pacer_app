import 'package:flutter/material.dart';

import 'app_colors.dart';

/// 간격·모서리 스케일 (시안의 padding/radius 값 기준).
abstract final class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;

  /// 카드 기본 모서리 (시안 Card radius 16~20)
  static const radius = 18.0;
  static const radiusSm = 12.0;

  /// 히어로 CTA 등 큰 블록
  static const radiusLg = 24.0;

  /// 버튼 높이 (시안 Btn size=lg)
  static const buttonHeight = 54.0;
}

/// 숫자 표기 — 시안은 별도 서체(Space Grotesk)에 tnum을 켠다.
/// 여기서는 Pretendard의 tabular figures로 자릿수 흔들림만 맞춘다.
const kNumberFeatures = [FontFeature.tabularFigures()];

abstract final class AppTheme {
  static const _fontFamily = 'Pretendard';

  /// 시안은 라이트/다크 두 모드를 갖지만 Phase A는 다크만 제공한다.
  ///
  /// [platform]에 따라 탭 피드백을 바꾼다 — iOS는 리플 없이 눌린 표시만,
  /// 안드로이드는 머티리얼 리플 그대로. 각 OS 기본 감각을 따르기 위함이다.
  static ThemeData dark({TargetPlatform? platform}) {
    final isApple =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
    const scheme = ColorScheme.dark(
      primary: AppColors.accent,
      onPrimary: AppColors.onAccent,
      secondary: AppColors.accent2,
      surface: AppColors.surface,
      onSurface: AppColors.text,
      error: AppColors.pressure,
      outline: AppColors.line2,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      fontFamily: _fontFamily,
      scaffoldBackgroundColor: AppColors.bg,
      platform: platform,
      // iOS는 리플을 쓰지 않는다. 안드로이드는 기본 리플(InkSparkle)을 유지.
      splashFactory: isApple
          ? NoSplash.splashFactory
          : InkSparkle.splashFactory,
      splashColor: isApple ? Colors.transparent : null,
      highlightColor: isApple ? Colors.transparent : null,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
        },
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.bg,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: _fontFamily,
          color: AppColors.text,
          fontSize: 17,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radius),
          side: const BorderSide(color: AppColors.line),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(AppSpacing.buttonHeight),
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.onAccent,
          disabledBackgroundColor: AppColors.surface3,
          disabledForegroundColor: AppColors.text3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          textStyle: const TextStyle(
            fontFamily: _fontFamily,
            fontSize: 15.5,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ).copyWith(overlayColor: isApple ? _pressOverlay(Colors.black) : null),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(AppSpacing.buttonHeight),
          foregroundColor: AppColors.text,
          backgroundColor: AppColors.surface,
          side: const BorderSide(color: AppColors.line2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          textStyle: const TextStyle(
            fontFamily: _fontFamily,
            fontSize: 15.5,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ).copyWith(overlayColor: isApple ? _pressOverlay(Colors.white) : null),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.accent,
          textStyle: const TextStyle(
            fontFamily: _fontFamily,
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        hintStyle: const TextStyle(color: AppColors.text3, fontSize: 15),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 15,
        ),
        border: _inputBorder(AppColors.line),
        enabledBorder: _inputBorder(AppColors.line),
        focusedBorder: _inputBorder(AppColors.accent),
        errorBorder: _inputBorder(AppColors.pressure),
        focusedErrorBorder: _inputBorder(AppColors.pressure),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.line, space: 1),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.surface2,
        contentTextStyle: TextStyle(
          fontFamily: _fontFamily,
          color: AppColors.text,
          fontSize: 13.5,
        ),
        behavior: SnackBarBehavior.floating,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.bg2,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
      ),
      // 시안 타이포 스케일: 제목은 큼직하고 자간을 좁힌다(-0.03em).
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          color: AppColors.text,
          fontSize: 34,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.0,
        ),
        headlineMedium: TextStyle(
          color: AppColors.text,
          fontSize: 27,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.8,
          height: 1.25,
        ),
        titleLarge: TextStyle(
          color: AppColors.text,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        titleMedium: TextStyle(
          color: AppColors.text,
          fontSize: 15,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
        bodyLarge: TextStyle(
          color: AppColors.text,
          fontSize: 15.5,
          height: 1.55,
        ),
        bodyMedium: TextStyle(
          color: AppColors.text,
          fontSize: 14,
          height: 1.55,
        ),
        bodySmall: TextStyle(
          color: AppColors.text2,
          fontSize: 12.5,
          height: 1.5,
        ),
        labelSmall: TextStyle(
          color: AppColors.text3,
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// iOS용 — 눌린 동안만 얇게 덮는 오버레이 (리플 애니메이션 없음).
  static WidgetStateProperty<Color?> _pressOverlay(Color tint) {
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return tint.withValues(alpha: 0.12);
      }
      return null;
    });
  }

  static OutlineInputBorder _inputBorder(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: color),
  );
}
