import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_motion.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../common/motion.dart';
import '../common/pacer_mark.dart';
import '../providers/app_providers.dart';
import 'widgets/intro_art.dart';

class _Slide {
  const _Slide({
    required this.badge,
    required this.title,
    required this.body,
    required this.art,
  });

  final String badge;
  final String title;
  final String body;
  final IntroArt art;
}

/// S00a — 서비스 소개 3장.
///
/// 로그인 앞에 둔다. 소셜 로그인은 마찰이 큰 단계라, 무엇을 해주는 서비스인지
/// 모르는 채로 계정부터 요구하면 거기서 이탈한다.
class IntroScreen extends ConsumerStatefulWidget {
  const IntroScreen({super.key});

  @override
  ConsumerState<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends ConsumerState<IntroScreen> {
  int _step = 0;

  List<_Slide> _slides(AppL10n l10n) => [
    _Slide(
      badge: l10n.introBadge1,
      title: l10n.introTitle1,
      body: l10n.introBody1,
      art: IntroArt.hero,
    ),
    _Slide(
      badge: l10n.introBadge2,
      title: l10n.introTitle2,
      body: l10n.introBody2,
      art: IntroArt.chat,
    ),
    _Slide(
      badge: l10n.introBadge3,
      title: l10n.introTitle3,
      body: l10n.introBody3,
      art: IntroArt.growth,
    ),
  ];

  Future<void> _finish() async {
    await ref.read(sessionPrefsProvider).setIntroSeen();
    if (!mounted) return;
    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    final slides = _slides(l10n);
    final slide = slides[_step];
    final isLast = _step == slides.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(26, 18, 26, 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const PacerMark(size: 26, stroke: 3),
                      const SizedBox(width: 9),
                      Text(
                        'Pacer',
                        style: textTheme.titleMedium?.copyWith(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ],
                  ),
                  // 마지막 장에는 건너뛸 것이 없다.
                  if (!isLast)
                    TextButton(
                      onPressed: _finish,
                      child: Text(
                        l10n.introSkip,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colors.text3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              Expanded(
                child: Center(
                  // 아트는 고정 크기라 작은 화면(SE 등)에서 넘친다.
                  // 남은 높이에 맞춰 줄이되 키우지는 않는다.
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: PopIn(
                      key: ValueKey('art-$_step'),
                      child: IntroArtwork(kind: slide.art),
                    ),
                  ),
                ),
              ),
              RiseIn(
                key: ValueKey('copy-$_step'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Badge(label: slide.badge),
                    const SizedBox(height: 14),
                    Text(
                      slide.title,
                      style: textTheme.headlineMedium?.copyWith(
                        fontSize: 33,
                        fontWeight: FontWeight.w800,
                        height: 1.12,
                        letterSpacing: -1.1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: Text(
                        slide.body,
                        style: textTheme.bodyMedium?.copyWith(
                          fontSize: 15.5,
                          height: 1.55,
                          color: colors.text2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              _StepBar(current: _step, total: slides.length),
              const SizedBox(height: 18),
              FilledButton(
                onPressed: () => isLast
                    ? _finish()
                    : setState(() => _step += 1),
                child: Text(isLast ? l10n.introStart : l10n.introNext),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: colors.accentSoft,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: colors.accent,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// 현재 장이 넓어지는 막대 — 점보다 남은 분량이 잘 읽힌다.
class _StepBar extends StatelessWidget {
  const _StepBar({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      children: [
        for (var i = 0; i < total; i++) ...[
          if (i > 0) const SizedBox(width: 6),
          Expanded(
            flex: i == current ? 24 : 10,
            child: AnimatedContainer(
              duration: AppMotion.bubble,
              height: 5,
              decoration: BoxDecoration(
                color: i == current ? colors.accent : colors.surface3,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
