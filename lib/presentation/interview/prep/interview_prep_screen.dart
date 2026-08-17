import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/interview_setup.dart';
import '../../../l10n/app_localizations.dart';
import 'interview_setup_notifier.dart';

/// S11 — 공고 입력(붙여넣기) 또는 직무로 시작. URL 파싱은 P1.
class InterviewPrepScreen extends ConsumerStatefulWidget {
  const InterviewPrepScreen({super.key});

  @override
  ConsumerState<InterviewPrepScreen> createState() =>
      _InterviewPrepScreenState();
}

class _InterviewPrepScreenState extends ConsumerState<InterviewPrepScreen> {
  late final TextEditingController _postingController;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _postingController = TextEditingController(
      text: ref.read(interviewSetupProvider).jobPostingText,
    );
  }

  @override
  void dispose() {
    _postingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final setup = ref.watch(interviewSetupProvider);
    final notifier = ref.read(interviewSetupProvider.notifier);
    final isPaste = setup.jobSource == JobSource.paste;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.prepTitle)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SegmentedButton<JobSource>(
                segments: [
                  ButtonSegment(
                    value: JobSource.paste,
                    label: Text(l10n.prepSourcePaste),
                  ),
                  ButtonSegment(
                    value: JobSource.template,
                    label: Text(l10n.prepSourceTemplate),
                  ),
                ],
                selected: {setup.jobSource},
                onSelectionChanged: (selection) {
                  setState(() => _errorText = null);
                  notifier.setJobSource(selection.first);
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              if (isPaste)
                Expanded(
                  child: TextField(
                    controller: _postingController,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      labelText: l10n.prepPostingLabel,
                      hintText: l10n.prepPostingHint,
                      errorText: _errorText,
                      alignLabelWithHint: true,
                    ),
                    onChanged: (value) {
                      notifier.setJobPostingText(value);
                      if (_errorText != null) {
                        setState(() => _errorText = null);
                      }
                    },
                  ),
                )
              else
                Expanded(
                  child: _JobPicker(setup: setup, errorText: _errorText),
                ),
              const SizedBox(height: AppSpacing.md),
              FilledButton(
                onPressed: () => _next(l10n, setup),
                child: Text(l10n.commonNext),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _next(AppL10n l10n, InterviewSetup setup) {
    if (setup.jobSource == JobSource.paste &&
        _postingController.text.trim().isEmpty) {
      setState(() => _errorText = l10n.prepPostingEmpty);
      return;
    }
    if (setup.jobSource == JobSource.template && !setup.isReady) {
      setState(() => _errorText = l10n.prepSelectJobEmpty);
      return;
    }

    context.push(AppRoutes.interviewApplicant);
  }
}

class _JobPicker extends StatelessWidget {
  const _JobPicker({required this.setup, this.errorText});

  final InterviewSetup setup;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final selected = setup.jobRoleName ?? setup.customRole;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedButton.icon(
          onPressed: () => context.push(AppRoutes.interviewJobCategory),
          icon: const Icon(Icons.work_outline),
          label: Text(l10n.prepSelectJob),
        ),
        const SizedBox(height: AppSpacing.md),
        if (selected != null && selected.isNotEmpty)
          Text(
            l10n.prepSelectedJob(selected),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child: Text(
              errorText!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }
}
