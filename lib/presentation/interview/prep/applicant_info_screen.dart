import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import 'interview_setup_notifier.dart';

/// S12 — 경력·자기소개(선택). 이력서 업로드는 이후 단계.
class ApplicantInfoScreen extends ConsumerStatefulWidget {
  const ApplicantInfoScreen({super.key});

  @override
  ConsumerState<ApplicantInfoScreen> createState() =>
      _ApplicantInfoScreenState();
}

class _ApplicantInfoScreenState extends ConsumerState<ApplicantInfoScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: ref.read(interviewSetupProvider).applicantInfo,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.applicantTitle),
        actions: [TextButton(onPressed: _next, child: Text(l10n.commonSkip))],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.applicantDescription,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: l10n.applicantHint,
                    alignLabelWithHint: true,
                  ),
                  onChanged: ref
                      .read(interviewSetupProvider.notifier)
                      .setApplicantInfo,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              FilledButton(onPressed: _next, child: Text(l10n.commonNext)),
            ],
          ),
        ),
      ),
    );
  }

  void _next() => context.push(AppRoutes.interviewOptions);
}
