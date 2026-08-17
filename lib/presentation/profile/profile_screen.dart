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
import '../common/app_error_view.dart';
import '../common/ui.dart';
import '../providers/user_providers.dart';

/// 마이 탭 — 계정 정보·약관·로그아웃. (설정 전체 화면 S60은 P1)
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppL10n.of(context);
    final profile = ref.watch(myProfileProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabProfile)),
      body: SafeArea(
        bottom: false,
        child: profile.when(
          loading: () => const Center(child: AppSpinner(size: 28)),
          error: (error, _) => AppErrorView(
            error: error,
            onRetry: () => ref.invalidate(myProfileProvider),
          ),
          data: (data) => ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.lg,
            ),
            children: [
              PacerCard(
                radius: 20,
                onTap: () => context.push(AppRoutes.profileNickname),
                child: Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: AppColors.accentSoft,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          data.nickname.characters.firstOrNull ?? '?',
                          style: const TextStyle(
                            color: AppColors.accent,
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.nickname,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            data.email ?? l10n.profileEditNickname,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: AppColors.text3,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              PacerCard(
                radius: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.homeQuotaTitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      '${data.usage.baseQuestionUsed}/${data.usage.limit}',
                      style: const TextStyle(
                        color: AppColors.text,
                        fontWeight: FontWeight.w700,
                        fontFeatures: kNumberFeatures,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              PacerCard(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                radius: 20,
                child: Column(
                  children: [
                    PacerListRow(
                      icon: Icons.description_outlined,
                      title: l10n.legalTerms,
                      subtitle: l10n.legalTitle,
                      onTap: () => context.push(
                        AppRoutes.legal(LegalDocumentType.terms.value),
                      ),
                    ),
                    PacerListRow(
                      icon: Icons.privacy_tip_outlined,
                      title: l10n.legalPrivacy,
                      subtitle: l10n.legalTitle,
                      showDivider: false,
                      onTap: () => context.push(
                        AppRoutes.legal(LegalDocumentType.privacy.value),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              OutlinedButton(
                onPressed: () =>
                    ref.read(authNotifierProvider.notifier).signOut(),
                child: Text(l10n.homeSignOut),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
