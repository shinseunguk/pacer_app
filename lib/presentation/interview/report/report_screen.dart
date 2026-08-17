import 'package:flutter/material.dart';
import '../../common/app_spinner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/interview_report.dart';
import '../../../l10n/app_localizations.dart';
import '../../common/app_error_view.dart';
import '../../providers/interview_providers.dart';
import 'widgets/report_feedback.dart';
import '../../providers/user_providers.dart';

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
        _PassBadge(isPass: report.isPass),
        const SizedBox(height: AppSpacing.lg),
        if (report.showScore)
          _OverallScore(score: report.overallScore)
        else
          Text(
            l10n.reportScoreHidden,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          l10n.reportReasonTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(report.passReason, style: Theme.of(context).textTheme.bodyMedium),
        if (report.showScore) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.reportCriteriaTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final score in report.scores)
            _CriterionRow(
              score: score,
              label: _criterionLabel(l10n, score.criterion),
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
    final color = isPass ? AppColors.success : AppColors.pressure;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface2,
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
            color: AppColors.accent,
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
              backgroundColor: AppColors.surface2,
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
