import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/growth_summary.dart';
import '../../../domain/entities/interview_report.dart';
import '../../../l10n/app_localizations.dart';
import '../../common/app_spinner.dart';
import '../../common/ui.dart';
import 'growth_chart.dart';
import '../../interview/report/widgets/radar_chart.dart';
import '../../providers/interview_providers.dart';

/// S42 — 성장 추이·역량.
///
/// 시안이 내세우는 "뛸수록 빨라지는 페이스"를 보여주는 유일한 화면이다.
/// 챗봇으로는 못 하는 것(누적된 내 약점)이 여기 있다.
class GrowthSection extends ConsumerStatefulWidget {
  const GrowthSection({required this.summary, super.key});

  final GrowthSummary summary;

  @override
  ConsumerState<GrowthSection> createState() => _GrowthSectionState();
}

enum _Tab { trend, skill }

class _GrowthSectionState extends ConsumerState<GrowthSection> {
  _Tab _tab = _Tab.trend;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final summary = widget.summary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SegmentedButton<_Tab>(
          segments: [
            ButtonSegment(value: _Tab.trend, label: Text(l10n.historyTabTrend)),
            ButtonSegment(value: _Tab.skill, label: Text(l10n.historyTabSkill)),
          ],
          selected: {_tab},
          showSelectedIcon: false,
          onSelectionChanged: (value) => setState(() => _tab = value.first),
        ),
        const SizedBox(height: AppSpacing.md),
        if (_tab == _Tab.trend)
          _TrendCard(summary: summary)
        else
          _SkillCard(sessionId: summary.points.last.sessionId),
      ],
    );
  }
}

class _TrendCard extends StatelessWidget {
  const _TrendCard({required this.summary});

  final GrowthSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    final delta = summary.latestDelta;

    return PacerCard(
      radius: 22,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.historyTrendTitle,
            style: textTheme.bodySmall?.copyWith(
              color: colors.text3,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 3),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${summary.latestScore}',
                style: textTheme.headlineMedium?.copyWith(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  height: 1,
                  fontFeatures: kNumberFeatures,
                ),
              ),
              if (delta != null) ...[
                const SizedBox(width: 8),
                _DeltaPill(delta: delta),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          GrowthChart(points: summary.points),
          const SizedBox(height: AppSpacing.md),
          Divider(color: colors.line, height: 1),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _Stat(
                value: '${summary.averageScore}',
                label: l10n.historyAverage,
                color: colors.accent,
              ),
              _Stat(
                value: scoreGrade(summary.bestScore),
                label: l10n.historyBestGrade,
                color: colors.success,
              ),
              _Stat(
                value: l10n.historyPassCountValue(summary.passCount),
                label: l10n.historyPassCount,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 증감 배지. 오르면 초록, 떨어지면 경고색 — 숫자만으로는 방향이 안 읽힌다.
class _DeltaPill extends StatelessWidget {
  const _DeltaPill({required this.delta});

  final int delta;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final colors = context.colors;
    final isUp = delta >= 0;
    final color = isUp ? colors.success : colors.warm;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: isUp ? colors.successSoft : colors.warmSoft,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isUp ? Icons.arrow_upward : Icons.arrow_downward,
            size: 12,
            color: color,
          ),
          const SizedBox(width: 3),
          Text(
            l10n.historyTrendDelta('${delta.abs()}'),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label, this.color});

  final String value;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          value,
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: color,
            fontFeatures: kNumberFeatures,
          ),
        ),
        const SizedBox(height: 2),
        Text(label, style: textTheme.labelSmall),
      ],
    );
  }
}

/// 최근 면접의 항목별 점수 + 약점 진단.
class _SkillCard extends ConsumerWidget {
  const _SkillCard({required this.sessionId});

  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppL10n.of(context);
    final detail = ref.watch(interviewDetailProvider(sessionId));

    return PacerCard(
      radius: 22,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.historySkillTitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: context.colors.text3,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          detail.when(
            loading: () => const SizedBox(
              height: 180,
              child: Center(child: AppSpinner(size: 24)),
            ),
            error: (_, _) => SizedBox(
              height: 120,
              child: Center(
                child: Text(
                  l10n.commonLoadFailed,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
            data: (data) {
              final report = data.report;
              if (report == null || report.scores.isEmpty) {
                return SizedBox(
                  height: 120,
                  child: Center(
                    child: Text(
                      l10n.reportScoreHidden,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                );
              }
              return _SkillBody(scores: report.scores);
            },
          ),
        ],
      ),
    );
  }
}

class _SkillBody extends StatelessWidget {
  const _SkillBody({required this.scores});

  final List<CriterionScore> scores;

  /// 가중치가 높을수록 종합 점수를 많이 흔든다 — 같은 점수라면 그쪽을 먼저 고친다.
  CriterionScore get _weakest => scores.reduce(
    (a, b) => a.score * (1 + a.weight) <= b.score * (1 + b.weight) ? a : b,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (RadarChart.canRender(scores.length))
              RadarChart(
                size: 172,
                entries: [
                  for (final score in scores)
                    RadarEntry(
                      label: criterionLabel(l10n, score.criterion),
                      score: score.score,
                    ),
                ],
              ),
            Expanded(
              child: Column(
                children: [
                  for (final score in scores)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            criterionLabel(l10n, score.criterion),
                            style: textTheme.bodySmall?.copyWith(
                              color: colors.text2,
                            ),
                          ),
                          Text(
                            '${score.score}',
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontFeatures: kNumberFeatures,
                              color: _toneOf(score.score, colors),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Divider(color: colors.line, height: 1),
        const SizedBox(height: AppSpacing.md),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.adjust, size: 17, color: colors.warm),
            const SizedBox(width: 9),
            Expanded(
              child: Text(
                l10n.historyWeakest(
                  criterionLabel(l10n, _weakest.criterion),
                  _weakest.score,
                ),
                style: textTheme.bodySmall?.copyWith(
                  color: colors.text2,
                  height: 1.55,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _toneOf(int score, AppColors colors) => switch (score) {
    >= 85 => colors.success,
    >= 70 => colors.accent,
    _ => colors.warm,
  };
}

/// 리포트 화면과 같은 라벨을 쓴다 — 두 화면이 다른 이름을 쓰면 안 된다.
String criterionLabel(AppL10n l10n, String criterion) => switch (criterion) {
  'logic' => l10n.criterionLogic,
  'job_fit' => l10n.criterionJobFit,
  'structure' => l10n.criterionStructure,
  'keyword' => l10n.criterionKeyword,
  _ => criterion,
};
