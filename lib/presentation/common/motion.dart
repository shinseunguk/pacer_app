import 'package:flutter/material.dart';

import '../../core/theme/app_motion.dart';

/// 등장 모션 3종 (시안 `rise` / `pop` / `bubble`).
///
/// 셋 다 [TweenAnimationBuilder]로 처음 붙을 때 한 번만 재생한다 — 컨트롤러가 없어
/// dispose를 신경 쓸 필요가 없고, 리스트 안에서도 가볍다.
///
/// 시스템 "동작 줄이기"가 켜져 있으면 [child]를 그대로 돌려준다.

/// 화면 진입 — 아래에서 살짝 올라오며 페이드인.
class RiseIn extends StatelessWidget {
  const RiseIn({required this.child, this.order = 0, super.key});

  final Widget child;

  /// 여러 요소를 차례로 띄울 때의 순번. 0이면 지연 없이 바로 시작한다.
  final int order;

  @override
  Widget build(BuildContext context) {
    if (prefersReducedMotion(context)) return child;

    return _EntranceBuilder(
      duration: AppMotion.rise,
      order: order,
      curve: AppMotion.enter,
      builder: (t, child) => Opacity(
        opacity: t,
        child: Transform.translate(
          offset: Offset(0, AppMotion.riseOffset * (1 - t)),
          child: child,
        ),
      ),
      child: child,
    );
  }
}

/// 뱃지·점수 등 강조 요소 — 살짝 커지며 나타난다.
class PopIn extends StatelessWidget {
  const PopIn({required this.child, this.order = 0, super.key});

  final Widget child;
  final int order;

  @override
  Widget build(BuildContext context) {
    if (prefersReducedMotion(context)) return child;

    return _EntranceBuilder(
      duration: AppMotion.pop,
      order: order,
      curve: AppMotion.popCurve,
      builder: (t, child) => Opacity(
        // easeOutBack은 1을 넘겼다 돌아오므로 투명도는 따로 잘라 쓴다.
        opacity: t.clamp(0.0, 1.0),
        child: Transform.scale(
          scale: AppMotion.popScale + (1 - AppMotion.popScale) * t,
          child: child,
        ),
      ),
      child: child,
    );
  }
}

/// 면접 말풍선 — 말하는 쪽에서 밀려 들어오며 나타난다.
class BubbleIn extends StatelessWidget {
  const BubbleIn({
    required this.child,
    required this.fromLeft,
    this.enabled = true,
    super.key,
  });

  final Widget child;

  /// 면접관은 왼쪽, 지원자는 오른쪽에서 들어온다.
  final bool fromLeft;

  /// 이미 화면에 있던 말풍선은 스크롤로 다시 그려져도 재생하지 않는다.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!enabled || prefersReducedMotion(context)) return child;

    return _EntranceBuilder(
      duration: AppMotion.bubble,
      order: 0,
      curve: AppMotion.enter,
      builder: (t, child) => Opacity(
        opacity: t,
        child: Transform.translate(
          offset: Offset(
            (fromLeft ? -1 : 1) * AppMotion.bubbleOffset * (1 - t),
            0,
          ),
          child: child,
        ),
      ),
      child: child,
    );
  }
}

/// 0 → 1로 한 번 흐르는 값을 [builder]에 넘긴다. [order]만큼 시작을 늦춘다.
class _EntranceBuilder extends StatelessWidget {
  const _EntranceBuilder({
    required this.duration,
    required this.order,
    required this.curve,
    required this.builder,
    required this.child,
  });

  final Duration duration;
  final int order;
  final Curve curve;
  final Widget Function(double t, Widget? child) builder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final delay = AppMotion.stagger * order;
    final total = duration + delay;

    // 지연은 전체 구간 앞쪽을 비워 두는 Interval로 만든다.
    final start = total.inMicroseconds == 0
        ? 0.0
        : delay.inMicroseconds / total.inMicroseconds;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: total,
      curve: Interval(start, 1, curve: curve),
      builder: (context, t, child) => builder(t, child),
      child: child,
    );
  }
}
