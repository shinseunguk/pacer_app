import 'package:flutter/material.dart';

import '../../common/app_spinner.dart';
import '../../../core/theme/app_colors.dart';

/// 소셜 로그인 버튼 — 시안대로 공급자 브랜드 색을 그대로 쓴다(높이 54, radius 15).
class SocialSignInButton extends StatelessWidget {
  const SocialSignInButton({
    required this.label,
    required this.background,
    required this.foreground,
    required this.mark,
    required this.onPressed,
    this.isLoading = false,
    this.bordered = false,
    super.key,
  });

  const SocialSignInButton.kakao({
    required String label,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Key? key,
  }) : this(
         label: label,
         background: AppColors.kakaoYellow,
         foreground: AppColors.kakaoLabel,
         mark: const _KakaoMark(color: AppColors.kakaoLabel),
         onPressed: onPressed,
         isLoading: isLoading,
         key: key,
       );

  const SocialSignInButton.apple({
    required String label,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Key? key,
  }) : this(
         label: label,
         background: AppColors.appleBlack,
         foreground: Colors.white,
         mark: const Icon(Icons.apple, size: 20, color: Colors.white),
         onPressed: onPressed,
         isLoading: isLoading,
         bordered: true,
         key: key,
       );

  final String label;
  final Color background;
  final Color foreground;
  final Widget mark;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          disabledBackgroundColor: background.withValues(alpha: 0.4),
          disabledForegroundColor: foreground.withValues(alpha: 0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: bordered
                ? BorderSide(color: context.colors.line2)
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? AppSpinner(size: 20, color: foreground)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [mark, const SizedBox(width: 10), Text(label)],
              ),
      ),
    );
  }
}

/// 시안과 동일한 일반형 말풍선 마크(브랜드 로고 재현 아님).
class _KakaoMark extends StatelessWidget {
  const _KakaoMark({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CustomPaint(painter: _KakaoMarkPainter(color)),
    );
  }
}

class _KakaoMarkPainter extends CustomPainter {
  const _KakaoMarkPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final w = size.width;
    final h = size.height;

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w / 2, h * 0.44),
        width: w * 0.9,
        height: h * 0.72,
      ),
      paint,
    );

    final tail = Path()
      ..moveTo(w * 0.33, h * 0.68)
      ..lineTo(w * 0.27, h * 0.95)
      ..lineTo(w * 0.52, h * 0.74)
      ..close();
    canvas.drawPath(tail, paint);
  }

  @override
  bool shouldRepaint(_KakaoMarkPainter oldDelegate) =>
      oldDelegate.color != color;
}
