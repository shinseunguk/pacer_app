import 'package:flutter/material.dart';
import '../../common/app_spinner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/job_category.dart';
import '../../../l10n/app_localizations.dart';
import '../../common/app_error_view.dart';
import '../../providers/interview_providers.dart';
import 'interview_setup_notifier.dart';

/// S11a — 대분류 → 세부 직무 선택. 목록에 없으면 직접 입력.
class JobCategoryScreen extends ConsumerWidget {
  const JobCategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppL10n.of(context);
    final categories = ref.watch(jobCategoriesProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.jobTitle)),
      body: SafeArea(
        child: categories.when(
          loading: () => const Center(child: AppSpinner(size: 28)),
          error: (error, _) => AppErrorView(
            error: error,
            onRetry: () => ref.invalidate(jobCategoriesProvider),
          ),
          data: (data) => _CategoryList(categories: data),
        ),
      ),
    );
  }
}

class _CategoryList extends ConsumerWidget {
  const _CategoryList({required this.categories});

  final List<JobCategory> categories;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppL10n.of(context);

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      children: [
        for (final category in categories)
          ExpansionTile(
            title: Text(category.name),
            childrenPadding: const EdgeInsets.only(left: AppSpacing.md),
            children: [
              for (final role in category.roles)
                ListTile(
                  title: Text(role.name),
                  trailing: const Icon(Icons.chevron_right, size: 18),
                  onTap: () {
                    ref
                        .read(interviewSetupProvider.notifier)
                        .selectJobRole(id: role.id, name: role.name);
                    context.pop();
                  },
                ),
            ],
          ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: _CustomRoleField(label: l10n.jobCustomLabel),
        ),
      ],
    );
  }
}

class _CustomRoleField extends ConsumerStatefulWidget {
  const _CustomRoleField({required this.label});

  final String label;

  @override
  ConsumerState<_CustomRoleField> createState() => _CustomRoleFieldState();
}

class _CustomRoleFieldState extends ConsumerState<_CustomRoleField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: l10n.jobCustomHint),
          onSubmitted: (_) => _apply(),
        ),
        const SizedBox(height: AppSpacing.sm),
        OutlinedButton(onPressed: _apply, child: Text(l10n.jobCustomApply)),
      ],
    );
  }

  void _apply() {
    final role = _controller.text.trim();
    if (role.isEmpty) return;

    ref.read(interviewSetupProvider.notifier).setCustomRole(role);
    context.pop();
  }
}
