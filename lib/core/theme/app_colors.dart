import 'package:flutter/material.dart';

/// 디자인 시안(`docs/design/Pacer_디자인시안_v1.html`)의 oklch 토큰을 sRGB로 변환한 값.
/// 시안의 다크 모드 기준이며, 토큰 이름도 시안(`--bg`, `--surface-2` …)을 그대로 따른다.
abstract final class AppColors {
  // 배경 · 표면
  static const bg = Color(0xFF0E0E12); // oklch(0.165 0.008 285)
  static const bg2 = Color(0xFF141419); // oklch(0.195 0.009 285)
  static const surface = Color(0xFF19191E); // oklch(0.215 0.010 285)
  static const surface2 = Color(0xFF222229); // oklch(0.255 0.012 285)
  static const surface3 = Color(0xFF2D2D34); // oklch(0.300 0.013 285)

  // 선
  static const line = Color(0x17FFFFFF); // white 9%
  static const line2 = Color(0x26FFFFFF); // white 15%

  // 글자
  static const text = Color(0xFFF5F5F8); // oklch(0.970 0.004 285)
  static const text2 = Color(0xFFAAAAB1); // oklch(0.740 0.010 285)
  static const text3 = Color(0xFF73747B); // oklch(0.560 0.012 285)

  // 강조 (indigo hue 277)
  static const accent = Color(0xFF8E9AFF); // oklch(0.720 0.150 277)
  static const accent2 = Color(0xFF727BED); // oklch(0.630 0.170 277)
  static const accentSoft = Color(0x298E9AFF); // accent 16%
  static const accentLine = Color(0x528E9AFF); // accent 32%
  static const onAccent = Color(0xFFFCFCFD);

  // 상태
  static const success = Color(0xFF54CC8E); // oklch(0.760 0.140 158)
  static const successSoft = Color(0x2954CC8E);
  static const warm = Color(0xFFF9AA60); // oklch(0.800 0.130 62)
  static const warmSoft = Color(0x29F9AA60);

  /// 압박 면접 톤 (진행률·타이머 강조)
  static const pressure = Color(0xFFF75D59); // oklch(0.680 0.190 25)
  static const pressureSoft = Color(0x29F75D59);

  /// 히어로 CTA 그라데이션 (시안: linear-gradient(140deg, accent, accent-2))
  static const heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, accent2],
  );

  // 소셜 로그인 버튼 (브랜드 지정색)
  static const kakaoYellow = Color(0xFFFEE500);
  static const kakaoLabel = Color(0xFF191600);
  static const appleBlack = Color(0xFF000000);
}
