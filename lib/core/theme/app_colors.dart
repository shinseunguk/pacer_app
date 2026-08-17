import 'package:flutter/material.dart';

/// 디자인 시안(`docs/design/Pacer_디자인시안_v1.html`)의 oklch 토큰을 sRGB로 변환한 값.
/// 시안의 `buildVars(mode, hue)`와 같은 구조로 라이트·다크 두 벌을 둔다.
///
/// 화면에서는 [AppColors]를 직접 쓰지 말고 `context.colors` 로 접근한다
/// — 그래야 모드에 따라 값이 바뀐다.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.bg,
    required this.bg2,
    required this.surface,
    required this.surface2,
    required this.surface3,
    required this.line,
    required this.line2,
    required this.text,
    required this.text2,
    required this.text3,
    required this.accent,
    required this.accent2,
    required this.accentSoft,
    required this.accentLine,
    required this.onAccent,
    required this.success,
    required this.successSoft,
    required this.warm,
    required this.warmSoft,
    required this.pressure,
    required this.pressureSoft,
  });

  // 배경 · 표면
  final Color bg;
  final Color bg2;
  final Color surface;
  final Color surface2;
  final Color surface3;

  // 선
  final Color line;
  final Color line2;

  // 글자
  final Color text;
  final Color text2;
  final Color text3;

  // 강조 (indigo hue 277)
  final Color accent;
  final Color accent2;
  final Color accentSoft;
  final Color accentLine;
  final Color onAccent;

  // 상태
  final Color success;
  final Color successSoft;
  final Color warm;
  final Color warmSoft;

  /// 압박 면접 톤 (진행률·타이머 강조) 겸 위험/오류 색
  final Color pressure;
  final Color pressureSoft;

  /// 히어로 CTA 그라데이션 (시안: linear-gradient(140deg, accent, accent-2))
  LinearGradient get heroGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, accent2],
  );

  static const dark = AppColors(
    bg: Color(0xFF0E0E12), // oklch(0.165 0.008 285)
    bg2: Color(0xFF141419),
    surface: Color(0xFF19191E),
    surface2: Color(0xFF222229),
    surface3: Color(0xFF2D2D34),
    line: Color(0x17FFFFFF), // white 9%
    line2: Color(0x26FFFFFF), // white 15%
    text: Color(0xFFF5F5F8),
    text2: Color(0xFFAAAAB1),
    text3: Color(0xFF73747B),
    accent: Color(0xFF8E9AFF), // oklch(0.720 0.150 277)
    accent2: Color(0xFF727BED),
    accentSoft: Color(0x298E9AFF), // accent 16%
    accentLine: Color(0x528E9AFF), // accent 32%
    onAccent: Color(0xFFFCFCFD),
    success: Color(0xFF54CC8E),
    successSoft: Color(0x2954CC8E),
    warm: Color(0xFFF9AA60),
    warmSoft: Color(0x29F9AA60),
    pressure: Color(0xFFF75D59),
    pressureSoft: Color(0x29F75D59),
  );

  static const light = AppColors(
    bg: Color(0xFFF6F6FA), // oklch(0.975 0.005 285)
    bg2: Color(0xFFEFF0F4),
    surface: Color(0xFFFFFFFF),
    surface2: Color(0xFFF5F5F9),
    surface3: Color(0xFFECECF1),
    line: Color(0x14000000), // black 8%
    line2: Color(0x24000000), // black 14%
    text: Color(0xFF1C1C22),
    text2: Color(0xFF57575F),
    text3: Color(0xFF85858D),
    accent: Color(0xFF6168D9), // oklch(0.570 0.170 277)
    accent2: Color(0xFF4E50C6),
    accentSoft: Color(0x1A6168D9), // accent 10%
    accentLine: Color(0x386168D9), // accent 22%
    onAccent: Color(0xFFFCFCFD),
    success: Color(0xFF169F65),
    successSoft: Color(0x1F169F65),
    warm: Color(0xFFE0843E),
    warmSoft: Color(0x21E0843E),
    pressure: Color(0xFFD73337),
    pressureSoft: Color(0x1FD73337),
  );

  // 소셜 로그인 버튼은 공급자 브랜드 색이라 모드와 무관하게 고정한다.
  static const kakaoYellow = Color(0xFFFEE500);
  static const kakaoLabel = Color(0xFF191600);
  static const appleBlack = Color(0xFF000000);

  @override
  AppColors copyWith({
    Color? bg,
    Color? bg2,
    Color? surface,
    Color? surface2,
    Color? surface3,
    Color? line,
    Color? line2,
    Color? text,
    Color? text2,
    Color? text3,
    Color? accent,
    Color? accent2,
    Color? accentSoft,
    Color? accentLine,
    Color? onAccent,
    Color? success,
    Color? successSoft,
    Color? warm,
    Color? warmSoft,
    Color? pressure,
    Color? pressureSoft,
  }) {
    return AppColors(
      bg: bg ?? this.bg,
      bg2: bg2 ?? this.bg2,
      surface: surface ?? this.surface,
      surface2: surface2 ?? this.surface2,
      surface3: surface3 ?? this.surface3,
      line: line ?? this.line,
      line2: line2 ?? this.line2,
      text: text ?? this.text,
      text2: text2 ?? this.text2,
      text3: text3 ?? this.text3,
      accent: accent ?? this.accent,
      accent2: accent2 ?? this.accent2,
      accentSoft: accentSoft ?? this.accentSoft,
      accentLine: accentLine ?? this.accentLine,
      onAccent: onAccent ?? this.onAccent,
      success: success ?? this.success,
      successSoft: successSoft ?? this.successSoft,
      warm: warm ?? this.warm,
      warmSoft: warmSoft ?? this.warmSoft,
      pressure: pressure ?? this.pressure,
      pressureSoft: pressureSoft ?? this.pressureSoft,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;

    Color mix(Color a, Color b) => Color.lerp(a, b, t) ?? a;
    return AppColors(
      bg: mix(bg, other.bg),
      bg2: mix(bg2, other.bg2),
      surface: mix(surface, other.surface),
      surface2: mix(surface2, other.surface2),
      surface3: mix(surface3, other.surface3),
      line: mix(line, other.line),
      line2: mix(line2, other.line2),
      text: mix(text, other.text),
      text2: mix(text2, other.text2),
      text3: mix(text3, other.text3),
      accent: mix(accent, other.accent),
      accent2: mix(accent2, other.accent2),
      accentSoft: mix(accentSoft, other.accentSoft),
      accentLine: mix(accentLine, other.accentLine),
      onAccent: mix(onAccent, other.onAccent),
      success: mix(success, other.success),
      successSoft: mix(successSoft, other.successSoft),
      warm: mix(warm, other.warm),
      warmSoft: mix(warmSoft, other.warmSoft),
      pressure: mix(pressure, other.pressure),
      pressureSoft: mix(pressureSoft, other.pressureSoft),
    );
  }
}

extension AppColorsX on BuildContext {
  /// 현재 모드(라이트/다크)의 색 토큰.
  AppColors get colors =>
      Theme.of(this).extension<AppColors>() ?? AppColors.dark;
}
