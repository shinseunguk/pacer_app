import 'package:flutter/material.dart';
import '../common/app_spinner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/router/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/interview_session.dart';
import '../../l10n/app_localizations.dart';
import '../common/app_error_view.dart';
import '../../domain/entities/growth_summary.dart';
import '../common/ui.dart';
import '../providers/interview_providers.dart';
import 'widgets/growth_section.dart';

/// S40 — 지난 면접 목록.
class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppL10n.of(context);
    final history = ref.watch(interviewHistoryProvider);
    final streak = ref.watch(practiceStreakProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.historyGrowthTitle),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(22),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppSpacing.md,
                bottom: AppSpacing.sm,
              ),
              child: Text(
                l10n.historyGrowthSubtitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: history.when(
          loading: () => const Center(child: AppSpinner(size: 28)),
          error: (error, _) => AppErrorView(
            error: error,
            onRetry: () => ref.invalidate(interviewHistoryProvider),
          ),
          data: (page) {
            final summary = GrowthSummary.from(page.items);

            // 추이를 말하려면 비교 대상이 있어야 한다. 1회로는 성장이 성립하지 않는다.
            if (!summary.hasTrend) {
              return _GrowthEmpty(
                hasAnyInterview: page.items.isNotEmpty,
                items: page.items,
              );
            }

            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(interviewHistoryProvider),
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.md),
                children: [
                  _EngagementRow(summary: summary, streak: streak),
                  const SizedBox(height: AppSpacing.md),
                  GrowthSection(summary: summary),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    l10n.historyListLabel,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  for (final item in page.items) ...[
                    _HistoryTile(summary: item),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.summary});

  final InterviewSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final date = DateFormat('yyyy.MM.dd').format(summary.createdAt.toLocal());
    final type = summary.interviewType == 'pressure'
        ? l10n.setupTypePressure
        : l10n.setupTypeGeneral;

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        title: Text(summary.role ?? l10n.historyNoRole),
        subtitle: Text(
          '$type · $date',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Text(
          summary.score?.toString() ?? l10n.historyInProgress,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: summary.score == null
                ? context.colors.text2
                : context.colors.accent,
          ),
        ),
        onTap: () => _open(context),
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

/// 참여 지표 — 연속 연습·총 면접. 점수와 달리 "얼마나 꾸준했나"를 말한다.
class _EngagementRow extends StatelessWidget {
  const _EngagementRow({required this.summary, required this.streak});

  final GrowthSummary summary;
  final int streak;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final colors = context.colors;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _MetricCard(
              icon: Icons.local_fire_department,
              iconColor: colors.warm,
              iconBackground: colors.warmSoft,
              value: l10n.historyStreakDays(streak),
              label: l10n.historyStreak,
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: _MetricCard(
              icon: Icons.list_alt,
              iconColor: colors.accent,
              iconBackground: colors.accentSoft,
              value: l10n.historyTotalCount(summary.totalInterviews),
              label: l10n.historyTotal,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return PacerCard(
      radius: 16,
      padding: const EdgeInsets.all(13),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 19, color: iconColor),
          ),
          const SizedBox(width: 9),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    height: 1,
                    fontFeatures: kNumberFeatures,
                  ),
                ),
                const SizedBox(height: 2),
                Text(label, style: textTheme.labelSmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 완주 2회 미만 — 추이를 그릴 수 없다.
///
/// 기록이 아예 없는 경우와 1회뿐인 경우를 나누지 않는다. 둘 다 "더 해야 보인다"는
/// 같은 안내가 필요하고, 그 아래 목록이 있으면 지금까지 한 것도 보인다.
class _GrowthEmpty extends StatelessWidget {
  const _GrowthEmpty({required this.hasAnyInterview, required this.items});

  final bool hasAnyInterview;
  final List<InterviewSummary> items;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        const SizedBox(height: AppSpacing.xl),
        Center(
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: colors.surface2,
              borderRadius: BorderRadius.circular(23),
            ),
            child: Icon(Icons.show_chart, size: 33, color: colors.text3),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          l10n.historyGrowthEmptyTitle,
          textAlign: TextAlign.center,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.historyGrowthEmptyBody,
          textAlign: TextAlign.center,
          style: textTheme.bodySmall?.copyWith(color: colors.text3, height: 1.6),
        ),
        const SizedBox(height: 22),
        Center(
          child: FilledButton(
            onPressed: () => context.push(AppRoutes.interviewPrep),
            child: Text(l10n.historyGrowthEmptyCta),
          ),
        ),
        if (hasAnyInterview) ...[
          const SizedBox(height: AppSpacing.xl),
          Text(l10n.historyListLabel, style: textTheme.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          for (final item in items) ...[
            _HistoryTile(summary: item),
            const SizedBox(height: AppSpacing.sm),
          ],
        ],
      ],
    );
  }
}
