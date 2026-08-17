import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 탭 피드백을 OS 기본 감각에 맞춘다.
///
/// - iOS/macOS: 리플 없이 살짝 줄어들고 흐려지며 가벼운 햅틱
/// - 안드로이드: 머티리얼 리플(잉크) 그대로
class Pressable extends StatefulWidget {
  const Pressable({
    required this.child,
    required this.onTap,
    this.pressedScale = 0.97,
    this.pressedOpacity = 0.88,
    this.borderRadius,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;

  /// 큰 블록(히어로 카드)일수록 덜 줄여야 자연스럽다. (iOS 전용)
  final double pressedScale;
  final double pressedOpacity;

  /// 안드로이드 리플이 카드 모서리를 넘지 않도록 잘라낼 반경.
  final BorderRadius? borderRadius;

  @override
  State<Pressable> createState() => _PressableState();
}

const _pressDuration = Duration(milliseconds: 110);

class _PressableState extends State<Pressable> {
  bool _isPressed = false;

  void _setPressed(bool value) {
    if (widget.onTap == null || _isPressed == value) return;
    setState(() => _isPressed = value);
  }

  void _handleTap() {
    if (widget.onTap == null) return;
    HapticFeedback.selectionClick();
    widget.onTap!();
  }

  @override
  Widget build(BuildContext context) {
    if (!isApplePlatform(Theme.of(context).platform)) {
      // 안드로이드: 잉크 리플이 기본이라 그대로 쓴다.
      return Material(
        type: MaterialType.transparency,
        borderRadius: widget.borderRadius,
        clipBehavior: widget.borderRadius == null ? Clip.none : Clip.antiAlias,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: widget.borderRadius,
          child: widget.child,
        ),
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: _handleTap,
      child: AnimatedScale(
        scale: _isPressed ? widget.pressedScale : 1,
        duration: _pressDuration,
        curve: Curves.easeOut,
        child: AnimatedOpacity(
          opacity: _isPressed ? widget.pressedOpacity : 1,
          duration: _pressDuration,
          child: widget.child,
        ),
      ),
    );
  }
}

bool isApplePlatform(TargetPlatform platform) =>
    platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

/// 머티리얼 버튼처럼 리플이 이미 있는 위젯에서, iOS에서만 햅틱을 얹는다.
/// (안드로이드는 리플이 피드백 역할을 하므로 진동을 더하지 않는다.)
void hapticTap() {
  if (!isApplePlatform(defaultTargetPlatform)) return;
  HapticFeedback.selectionClick();
}
