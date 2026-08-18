import 'package:flutter/widgets.dart';

/// 등장 모션 토큰 (시안 `rise` / `pop` / `bubble`).
///
/// 시안 HTML은 모션 CSS가 외부 번들에 있어 값이 남아 있지 않고 화면정의서에도
/// 규격이 없다. 아래 값은 이 프로젝트의 정본으로 삼는다 — 화면에서 duration·curve를
/// 직접 쓰지 말고 여기를 통해서만 참조한다.
abstract final class AppMotion {
  /// 화면 진입 — 콘텐츠가 아래에서 올라오며 페이드인.
  static const rise = Duration(milliseconds: 280);

  /// 강조 요소 — 살짝 커지며 나타난다.
  static const pop = Duration(milliseconds: 240);

  /// 말풍선 — 방향에서 밀려 들어오며 나타난다.
  static const bubble = Duration(milliseconds: 260);

  /// 여러 요소를 차례로 띄울 때 요소 간 간격.
  static const stagger = Duration(milliseconds: 60);

  /// rise가 올라오기 시작하는 거리.
  static const riseOffset = 16.0;

  /// bubble이 좌우에서 밀려 들어오는 거리.
  static const bubbleOffset = 12.0;

  /// pop이 시작하는 배율.
  static const popScale = 0.9;

  /// 감속만 있는 기본 커브 — 등장은 빠르게 시작해 부드럽게 멈춘다.
  static const enter = Curves.easeOutCubic;

  /// pop만 살짝 튀어 강조된다.
  static const popCurve = Curves.easeOutBack;
}

/// 시스템 "동작 줄이기"가 켜져 있으면 등장 모션을 생략한다.
///
/// 접근성 설정이자 저사양 기기·스크린샷 테스트에서도 흔들림을 없애 준다.
bool prefersReducedMotion(BuildContext context) =>
    MediaQuery.disableAnimationsOf(context);
