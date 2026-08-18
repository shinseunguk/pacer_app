import 'package:flutter/material.dart';
import '../common/app_spinner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/router/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/interview_session.dart';
import '../../domain/entities/user_profile.dart';
import '../../l10n/app_localizations.dart';
import '../common/app_error_view.dart';
import '../common/motion.dart';
import '../common/pressable.dart';
import '../common/ui.dart';
import '../providers/interview_providers.dart';
import '../providers/user_providers.dart';

/// S10 — 홈/허브. 시안(screen_home.jsx)의 구성: 인사 헤더 · 스트릭/한도 카드 ·
/// 그라데이션 히어로 CTA · 최근 면접.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  /// 홈에서 미리 보여줄 최근 면접 수.
  static const _recentCount = 2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppL10n.of(context);
    final profile = ref.watch(myProfileProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: profile.when(
          loading: () => const Center(child: AppSpinner(size: 28)),
          error: (error, _) => AppErrorView(
            error: error,
            onRetry: () => ref.invalidate(myProfileProvider),
          ),
          data: (data) => RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(myProfileProvider);
              ref.invalidate(interviewHistoryProvider);
            },
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.lg,
              ),
              // 섹션을 위에서부터 차례로 띄운다 (시안 rise).
              children: [
                RiseIn(child: _Greeting(nickname: data.nickname)),
                const SizedBox(height: AppSpacing.md),
                RiseIn(order: 1, child: _StatusStrip(profile: data)),
                const SizedBox(height: AppSpacing.md),
                const RiseIn(order: 2, child: _HeroCta()),
                RiseIn(
                  order: 3,
                  child: SectionLabel(
                    label: l10n.homeSectionRecent,
                    actionLabel: l10n.homeSeeAll,
                    onAction: () => context.go(AppRoutes.history),
                  ),
                ),
                const RiseIn(
                  order: 4,
                  child: _RecentInterviews(limit: _recentCount),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Greeting extends StatelessWidget {
  const _Greeting({required this.nickname});

  final String nickname;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm, bottom: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.homeGreeting(nickname),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 6),
          Text(l10n.homeSubcopy, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

/// 스트릭 + 오늘 사용량 스트립.
class _StatusStrip extends ConsumerWidget {
  const _StatusStrip({required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppL10n.of(context);
    final streak = ref.watch(practiceStreakProvider);
    final usage = profile.usage;

    // 두 카드 높이를 맞추려면 stretch가 필요하고, 리스트 안에서는 높이가 무한이라
    // IntrinsicHeight로 한 번 재어 준다.
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 10,
            child: PacerCard(
              padding: const EdgeInsets.all(13),
              radius: 16,
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: context.colors.warmSoft,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Icon(
                      Icons.local_fire_department,
                      size: 21,
                      color: context.colors.warm,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: StatValue(
                      value: l10n.homeStreakDays(streak),
                      label: l10n.homeStreak,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 13,
            child: PacerCard(
              padding: const EdgeInsets.all(13),
              radius: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        l10n.homeQuotaTitle,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text.rich(
                        TextSpan(
                          text: '${usage.baseQuestionUsed}',
                          children: [
                            TextSpan(
                              text: '/${usage.limit}',
                              style: TextStyle(color: context.colors.text3),
                            ),
                          ],
                        ),
                        style: TextStyle(
                          color: context.colors.text,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          fontFeatures: kNumberFeatures,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  PacerProgressBar(
                    value: usage.baseQuestionUsed,
                    max: usage.limit,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.homeQuotaNote,
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 그라데이션 히어로 CTA — 시안의 핵심 진입점.
class _HeroCta extends StatelessWidget {
  const _HeroCta();

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);

    return Pressable(
      // 큰 블록이라 과하게 줄이면 어색하다.
      pressedScale: 0.985,
      onTap: () => context.push(AppRoutes.interviewPrep),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          gradient: context.colors.heroGradient,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          boxShadow: [
            BoxShadow(
              color: context.colors.accentLine,
              blurRadius: 38,
              offset: const Offset(0, 18),
              spreadRadius: -16,
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            const Positioned(
              right: -60,
              top: -60,
              child: _Ring(size: 160, opacity: 0.18),
            ),
            const Positioned(right: 4, top: 4, child: _Ring(size: 88)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: context.colors.onAccent.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    l10n.homeHeroBadge,
                    style: TextStyle(
                      color: context.colors.onAccent,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.homeHeroTitle,
                  style: TextStyle(
                    color: context.colors.onAccent,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.75,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 230,
                  child: Text(
                    l10n.homeHeroSubtitle,
                    style: TextStyle(
                      color: context.colors.onAccent.withValues(alpha: 0.82),
                      fontSize: 13.5,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      l10n.homeHeroAction,
                      style: TextStyle(
                        color: context.colors.onAccent,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      Icons.arrow_forward,
                      size: 18,
                      color: context.colors.onAccent,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Ring extends StatelessWidget {
  const _Ring({required this.size, this.opacity = 0.22});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: context.colors.onAccent.withValues(alpha: opacity),
          width: 2,
        ),
      ),
    );
  }
}

class _RecentInterviews extends ConsumerWidget {
  const _RecentInterviews({required this.limit});

  final int limit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppL10n.of(context);
    final history = ref.watch(interviewHistoryProvider);

    return history.when(
      loading: () => const PacerCard(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: AppSpinner(size: 28),
          ),
        ),
      ),
      error: (error, _) => AppErrorView(
        error: error,
        onRetry: () => ref.invalidate(interviewHistoryProvider),
      ),
      data: (page) {
        if (page.items.isEmpty) {
          return PacerCard(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Center(
              child: Text(
                l10n.homeEmptyHistory,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          );
        }

        final items = page.items.take(limit).toList();
        return PacerCard(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          radius: 20,
          child: Column(
            children: [
              for (final (index, item) in items.indexed)
                _HistoryRow(summary: item, isLast: index == items.length - 1),
            ],
          ),
        );
      },
    );
  }
}

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({required this.summary, required this.isLast});

  final InterviewSummary summary;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final type = summary.interviewType == 'pressure'
        ? l10n.setupTypePressure
        : l10n.setupTypeGeneral;
    final date = DateFormat('M월 d일').format(summary.createdAt.toLocal());

    return PacerListRow(
      icon: Icons.work_outline,
      title: summary.role ?? l10n.historyNoRole,
      subtitle: '$type 면접 · $date',
      showDivider: !isLast,
      onTap: () => _open(context),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 6),
        child: Text(
          summary.score?.toString() ?? l10n.historyInProgress,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            fontFeatures: kNumberFeatures,
            color: summary.passResult == 'pass'
                ? context.colors.success
                : context.colors.text2,
          ),
        ),
      ),
    );
  }

  /// 아직 끝나지 않은 면접은 이어서 진행하고, 끝난 면접만 대화 전문으로 간다.
  void _open(BuildContext context) {
    context.push(
      summary.isCompleted
          ? AppRoutes.transcript(summary.id)
          : AppRoutes.interviewSession(summary.id),
    );
  }
}
