import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../common/pacer_mark.dart';

/// 각 단계가 화면에 머무는 시간. 실측 소요(90~105초)에 맞춰 나눴다.
///
/// **진행률(%)은 보여주지 않는다.** 서버가 한 번에 응답하는 구조라 실제 진행을 알 수 없고,
/// 모르는 값을 그럴듯하게 그리면 그건 거짓말이다. 대신 *무엇을 하는 중인지*만 알린다.
const _stepDurations = [
  Duration(seconds: 22),
  Duration(seconds: 33),
  Duration(seconds: 40),
];

/// 리포트 생성 대기 화면.
///
/// 스피너만 90초 돌면 멈춘 것처럼 보인다. 지금 무슨 일이 벌어지는지 알려주면
/// 같은 시간도 기다릴 만해진다.
class ReportLoadingView extends StatefulWidget {
  const ReportLoadingView({super.key});

  @override
  State<ReportLoadingView> createState() => _ReportLoadingViewState();
}

class _ReportLoadingViewState extends State<ReportLoadingView> {
  int _step = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _scheduleNext();
  }

  void _scheduleNext() {
    if (_step >= _stepDurations.length) return;

    _timer = Timer(_stepDurations[_step], () {
      if (!mounted) return;
      setState(() => _step += 1);
      _scheduleNext();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _stepLabel(AppL10n l10n) => switch (_step) {
    0 => l10n.reportLoadingStep1,
    1 => l10n.reportLoadingStep2,
    2 => l10n.reportLoadingStep3,
    _ => l10n.reportLoadingStep4,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _PulsingMark(),
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.reportLoadingTitle,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            // 단계가 바뀔 때 글자가 툭 끊기지 않고 넘어가게 한다.
            AnimatedSwitcher(
              duration: AppMotion.bubble,
              child: Text(
                _stepLabel(l10n),
                key: ValueKey(_step),
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(color: colors.accent),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _StepDots(current: _step, total: _stepDurations.length + 1),
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.reportLoadingNote,
              textAlign: TextAlign.center,
              style: textTheme.bodySmall?.copyWith(color: colors.text3),
            ),
          ],
        ),
      ),
    );
  }
}

/// 로고마크가 천천히 숨쉬듯 커졌다 작아진다 — 살아 있다는 신호.
class _PulsingMark extends StatefulWidget {
  const _PulsingMark();

  @override
  State<_PulsingMark> createState() => _PulsingMarkState();
}

class _PulsingMarkState extends State<_PulsingMark>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  );

  @override
  void initState() {
    super.initState();
    // 동작 줄이기가 켜져 있으면 반복 애니메이션을 돌리지 않는다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || prefersReducedMotion(context)) return;
      _controller.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.scale(
        scale: 1 + _controller.value * 0.12,
        child: Opacity(opacity: 0.75 + _controller.value * 0.25, child: child),
      ),
      child: const PacerMark(size: 64, stroke: 5),
    );
  }
}

/// 단계 표시 점. 남은 시간이 아니라 **어디쯤 왔는지**만 알린다.
class _StepDots extends StatelessWidget {
  const _StepDots({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < total; i++) ...[
          if (i > 0) const SizedBox(width: 6),
          AnimatedContainer(
            duration: AppMotion.bubble,
            width: i == current ? 20 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: i <= current ? colors.accent : colors.line,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ],
      ],
    );
  }
}
