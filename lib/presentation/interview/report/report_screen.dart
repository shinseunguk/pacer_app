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
import 'widgets/report_feedback.dart';
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
        PopIn(child: _PassBadge(isPass: report.isPass)),
        const SizedBox(height: AppSpacing.lg),
        if (report.showScore)
          PopIn(order: 1, child: _OverallScore(score: report.overallScore))
        else
          Text(
            l10n.reportScoreHidden,
            style: Theme.of(context).textTheme.bodySmall,
          ),
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
          const SizedBox(height: AppSpacing.sm),
          for (final (index, score) in report.scores.indexed)
            RiseIn(
              order: 5 + index,
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

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: context.colors.surface2,
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(AppSpacing.radius),
        ),
        child: Text(
          isPass ? l10n.reportPass : l10n.reportFail,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: color),
        ),
      ),
    );
  }
}

class _OverallScore extends StatelessWidget {
  const _OverallScore({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$score',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: 56,
            color: context.colors.accent,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Text(' / 100', style: Theme.of(context).textTheme.bodySmall),
        ),
      ],
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: Theme.of(context).textTheme.bodyMedium),
              Text(
                '${score.score}  ·  ${(score.weight * 100).round()}%',
                style: Theme.of(context).textTheme.bodySmall,
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
