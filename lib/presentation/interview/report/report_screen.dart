import 'package:flutter/material.dart';
import '../../common/app_spinner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/entitlement.dart';
import '../../../domain/entities/interview_report.dart';
import '../../../l10n/app_localizations.dart';
import '../../common/app_error_view.dart';
import '../../common/motion.dart';
import '../../providers/interview_providers.dart';
import 'widgets/radar_chart.dart';
import 'widgets/report_feedback.dart';
import 'widgets/score_ring.dart';
import '../../providers/user_providers.dart';
import '../../common/pressable.dart';
import '../../purchases/entitlement_notifier.dart';

/// S30 — 최종 리포트. complete는 멱등이라 재진입해도 같은 결과가 나온다.
class ReportScreen extends ConsumerWidget {
  const ReportScreen({required this.sessionId, super.key});

  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppL10n.of(context);
    final report = ref.watch(interviewReportProvider(sessionId));

    return Scaffold(
      appBar: AppBar(title: Text(l10n.reportTitle)),
      body: SafeArea(
        child: report.when(
          loading: () => const Center(child: AppSpinner(size: 28)),
          error: (error, _) => AppErrorView(
            error: error,
            onRetry: () => ref.invalidate(interviewReportProvider(sessionId)),
          ),
          data: (data) => _ReportBody(sessionId: sessionId, report: data),
        ),
      ),
    );
  }
}

class _ReportBody extends ConsumerWidget {
  const _ReportBody({required this.sessionId, required this.report});

  final String sessionId;
  final InterviewReport report;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppL10n.of(context);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        // 판정과 점수는 리포트의 결론이라 살짝 튀며 들어온다 (시안 pop).
        PopIn(child: _ResultHeader(report: report)),
        const SizedBox(height: AppSpacing.lg),
        RiseIn(
          order: 2,
          child: Text(
            l10n.reportReasonTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        RiseIn(
          order: 3,
          child: Text(
            report.passReason,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        if (report.showScore) ...[
          const SizedBox(height: AppSpacing.lg),
          RiseIn(
            order: 4,
            child: Text(
              l10n.reportCriteriaTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          if (RadarChart.canRender(report.scores.length))
            RiseIn(
              order: 5,
              child: Center(
                child: RadarChart(
                  entries: [
                    for (final score in report.scores)
                      RadarEntry(
                        label: _criterionLabel(l10n, score.criterion),
                        score: score.score,
                      ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.md),
          for (final (index, score) in report.scores.indexed)
            RiseIn(
              order: 6 + index,
              child: _CriterionRow(
                score: score,
                label: _criterionLabel(l10n, score.criterion),
              ),
            ),
        ],
        const SizedBox(height: AppSpacing.xl),
        // 평가 품질(핵심 가설)을 검증할 유일한 지표라 리포트 본문 바로 뒤에 둔다.
        ReportFeedbackCard(
          sessionId: sessionId,
          initial: ref
              .watch(interviewDetailProvider(sessionId))
              .valueOrNull
              ?.feedback,
        ),
        // 만족도를 남긴 직후가 전환이 가장 잘 되는 지점이다 (이슈 #21).
        const _UpsellCard(),
        const SizedBox(height: AppSpacing.lg),
        OutlinedButton(
          onPressed: () => context.push(AppRoutes.transcript(sessionId)),
          child: Text(l10n.reportTranscript),
        ),
        const SizedBox(height: AppSpacing.sm),
        FilledButton(
          onPressed: () {
            // 리포트를 확인하고 홈으로 돌아가면 한도·히스토리를 새로 읽는다.
            ref.invalidate(myProfileProvider);
            ref.invalidate(interviewHistoryProvider);
            ref.invalidate(entitlementProvider);
            context.go(AppRoutes.home);
          },
          child: Text(l10n.reportHome),
        ),
      ],
    );
  }

  String _criterionLabel(AppL10n l10n, String criterion) {
    return switch (criterion) {
      'logic' => l10n.criterionLogic,
      'job_fit' => l10n.criterionJobFit,
      'structure' => l10n.criterionStructure,
      'keyword' => l10n.criterionKeyword,
      _ => criterion,
    };
  }
}

class _PassBadge extends StatelessWidget {
  const _PassBadge({required this.isPass});

  final bool isPass;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final color = isPass ? context.colors.success : context.colors.pressure;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        // 카드 안에 놓이므로 surface2로 한 단계 띄운다.
        color: context.colors.surface2,
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(AppSpacing.radius),
      ),
      child: Text(
        isPass ? l10n.reportPass : l10n.reportFail,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color),
      ),
    );
  }
}

/// 결론 블록 — 합불 뱃지와 종합 점수를 한 카드에 묶는다.
///
/// 점수를 꺼둔 면접(showScore=false)에서도 **합불과 근거는 그대로 제공된다**.
/// 이때 링을 빈 자리로 남기지 않고 뱃지를 중앙으로 올려 카드가 허전해지지 않게 한다.
class _ResultHeader extends StatelessWidget {
  const _ResultHeader({required this.report});

  final InterviewReport report;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: colors.line),
      ),
      child: Column(
        children: [
          if (report.showScore) ...[
            ScoreRing(score: report.overallScore),
            const SizedBox(height: AppSpacing.lg),
          ],
          _PassBadge(isPass: report.isPass),
          if (!report.showScore) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.reportScoreHidden,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: colors.text2),
            ),
          ],
        ],
      ),
    );
  }
}

class _CriterionRow extends StatelessWidget {
  const _CriterionRow({required this.score, required this.label});

  final CriterionScore score;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              // 가중치가 큰 항목일수록 종합 점수를 많이 흔든다. 어느 항목을
              // 먼저 고쳐야 하는지 판단하려면 점수만으로는 부족하다.
              _WeightBar(weight: score.weight),
              const SizedBox(width: AppSpacing.sm),
              Text(
                '${score.score}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontFeatures: kNumberFeatures,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.xs),
            child: LinearProgressIndicator(
              value: score.score / 100,
              backgroundColor: context.colors.surface2,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}

/// 무료 체험을 다 쓴 사용자에게만 보이는 전환 카드.
///
/// 아직 무료가 남았거나 이미 Pro면 아무것도 그리지 않는다 — 리포트를 보러 온
/// 사람에게 매번 구독을 들이밀면 리포트 자체의 신뢰가 깎인다.
class _UpsellCard extends ConsumerWidget {
  const _UpsellCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entitlement = ref
        .watch(entitlementProvider)
        .maybeWhen(
          data: (value) => value,
          orElse: () => const Entitlement.unknown(),
        );

    if (!entitlement.hasExhaustedFreeInterviews) {
      return const SizedBox.shrink();
    }

    final l10n = AppL10n.of(context);
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Pressable(
        onTap: () => context.push(AppRoutes.paywall),
        borderRadius: BorderRadius.circular(AppSpacing.radius),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: colors.accentSoft,
            borderRadius: BorderRadius.circular(AppSpacing.radius),
            border: Border.all(color: colors.accentLine),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.reportUpsellTitle,
                      style: textTheme.bodySmall?.copyWith(color: colors.text2),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.reportUpsellBody,
                      style: textTheme.titleSmall?.copyWith(
                        color: colors.accent,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      l10n.reportUpsellPrice,
                      style: textTheme.labelSmall?.copyWith(
                        color: colors.text2,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: colors.accent),
            ],
          ),
        ),
      ),
    );
  }
}

/// 가중치 미니바 — 항목이 종합 점수에서 차지하는 비중.
class _WeightBar extends StatelessWidget {
  const _WeightBar({required this.weight});

  /// 0.0 ~ 1.0
  final double weight;

  /// 가중치는 보통 0.2~0.4 사이라 100% 기준으로 그리면 차이가 안 보인다.
  /// 항목 간 상대 비교가 목적이므로 절반을 가득 찬 것으로 본다.
  static const _fullScale = 0.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final ratio = (weight / _fullScale).clamp(0.0, 1.0);

    return Tooltip(
      message: '가중치 ${(weight * 100).round()}%',
      child: Container(
        width: 34,
        height: 5,
        decoration: BoxDecoration(
          color: colors.surface2,
          borderRadius: BorderRadius.circular(3),
        ),
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: ratio,
          child: Container(
            decoration: BoxDecoration(
              color: colors.text3,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
      ),
    );
  }
}
