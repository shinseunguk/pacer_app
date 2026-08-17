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
import '../providers/interview_providers.dart';

/// S40 — 지난 면접 목록.
class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppL10n.of(context);
    final history = ref.watch(interviewHistoryProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.historyTitle)),
      body: SafeArea(
        child: history.when(
          loading: () => const Center(child: AppSpinner(size: 28)),
          error: (error, _) => AppErrorView(
            error: error,
            onRetry: () => ref.invalidate(interviewHistoryProvider),
          ),
          data: (page) {
            if (page.items.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Text(
                    l10n.historyEmpty,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(interviewHistoryProvider),
              child: ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: page.items.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) =>
                    _HistoryTile(summary: page.items[index]),
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
        title: Text(summary.role ?? type),
        subtitle: Text(
          '$type · $date',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Text(
          summary.score?.toString() ?? l10n.historyInProgress,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: summary.score == null ? AppColors.text2 : AppColors.accent,
          ),
        ),
        onTap: () => context.push(AppRoutes.transcript(summary.id)),
      ),
    );
  }
}
