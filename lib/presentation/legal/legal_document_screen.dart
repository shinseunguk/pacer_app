import 'package:flutter/material.dart';
import '../common/app_spinner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../domain/entities/legal_document.dart';
import '../../l10n/app_localizations.dart';
import '../common/app_error_view.dart';
import '../providers/legal_providers.dart';

/// 약관·개인정보 처리방침 열람 (온보딩 동의 화면에서 진입).
class LegalDocumentScreen extends ConsumerWidget {
  const LegalDocumentScreen({required this.type, super.key});

  final LegalDocumentType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppL10n.of(context);
    final document = ref.watch(legalDocumentProvider(type));

    return Scaffold(
      appBar: AppBar(
        title: Text(document.valueOrNull?.title ?? l10n.legalTitle),
      ),
      body: SafeArea(
        child: document.when(
          loading: () => const Center(child: AppSpinner(size: 28)),
          error: (error, _) => AppErrorView(
            error: error,
            onRetry: () => ref.invalidate(legalDocumentProvider(type)),
          ),
          data: (data) => ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              Text(
                l10n.legalVersion(data.version, data.effectiveDate),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: AppSpacing.lg),
              for (final section in data.sections) ...[
                Text(
                  section.heading,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  section.body,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
