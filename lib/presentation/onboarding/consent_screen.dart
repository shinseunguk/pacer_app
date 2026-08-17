import 'package:flutter/material.dart';
import '../common/app_spinner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/legal_document.dart';
import '../../l10n/app_localizations.dart';
import '../auth/auth_notifier.dart';
import '../common/failure_message.dart';
import 'onboarding_notifier.dart';

/// S03 — required consents (terms / privacy / LLM processing).
class ConsentScreen extends ConsumerWidget {
  const ConsentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppL10n.of(context);
    final draft = ref.watch(onboardingDraftProvider);
    final notifier = ref.read(onboardingDraftProvider.notifier);
    final agreements = draft.agreements;
    final authState = ref.watch(authNotifierProvider);

    ref.listen(authNotifierProvider, (_, next) {
      final error = next.error;
      if (error == null) return;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(failureMessage(error))));
    });

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.consentTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              CheckboxListTile.adaptive(
                value: agreements.allAccepted,
                onChanged: (value) => notifier.toggleAll(value ?? false),
                title: Text(
                  l10n.consentAll,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                contentPadding: EdgeInsets.zero,
              ),
              const Divider(),
              CheckboxListTile.adaptive(
                value: agreements.terms,
                onChanged: (value) => notifier.toggleTerms(value ?? false),
                title: Text(l10n.consentTerms),
                secondary: const _ViewDocumentButton(
                  type: LegalDocumentType.terms,
                ),
                contentPadding: EdgeInsets.zero,
              ),
              CheckboxListTile.adaptive(
                value: agreements.privacy,
                onChanged: (value) => notifier.togglePrivacy(value ?? false),
                title: Text(l10n.consentPrivacy),
                secondary: const _ViewDocumentButton(
                  type: LegalDocumentType.privacy,
                ),
                contentPadding: EdgeInsets.zero,
              ),
              CheckboxListTile.adaptive(
                value: agreements.llmConsent,
                onChanged: (value) => notifier.toggleLlmConsent(value ?? false),
                title: Text(l10n.consentLlm),
                subtitle: Text(
                  l10n.consentLlmDescription,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                // AI 처리 위탁·국외이전 고지는 처리방침에 담겨 있다.
                secondary: const _ViewDocumentButton(
                  type: LegalDocumentType.privacy,
                ),
                contentPadding: EdgeInsets.zero,
              ),
              CheckboxListTile.adaptive(
                value: agreements.marketing,
                onChanged: (value) => notifier.toggleMarketing(value ?? false),
                title: Text(l10n.consentMarketing),
                contentPadding: EdgeInsets.zero,
              ),
              const Spacer(),
              if (!agreements.allRequiredAccepted)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Text(
                    l10n.consentRequired,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: context.colors.pressure,
                    ),
                  ),
                ),
              FilledButton(
                onPressed:
                    agreements.allRequiredAccepted && !authState.isLoading
                    ? () => ref
                          .read(authNotifierProvider.notifier)
                          .completeOnboarding(
                            nickname: draft.nickname,
                            agreements: agreements,
                          )
                    : null,
                child: authState.isLoading
                    ? const AppSpinner(size: 20)
                    : Text(l10n.commonStart),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 동의 항목 옆 "보기" — 약관 원문 화면으로 이동한다.
class _ViewDocumentButton extends StatelessWidget {
  const _ViewDocumentButton({required this.type});

  final LegalDocumentType type;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);

    return TextButton(
      onPressed: () => context.push(AppRoutes.legal(type.value)),
      child: Text(l10n.legalView),
    );
  }
}
