import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/legal_document.dart';
import '../../l10n/app_localizations.dart';
import '../auth/auth_notifier.dart';
import '../common/app_spinner.dart';
import '../common/failure_message.dart';
import '../common/ui.dart';

/// S60 설정 — 계정·약관·로그아웃·회원 탈퇴.
///
/// 탈퇴는 개인정보 처리방침 §6에서 약속한 삭제 요청 경로이자
/// App Store 가이드라인 5.1.1(v)의 계정 삭제 요건이라 반드시 노출한다.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppL10n.of(context);
    final authState = ref.watch(authNotifierProvider);

    ref.listen(authNotifierProvider, (_, next) {
      final error = next.error;
      if (error == null) return;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(failureMessage(error))));
    });

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.lg,
              ),
              children: [
                SectionLabel(label: l10n.settingsAccount),
                PacerCard(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  radius: 20,
                  child: PacerListRow(
                    icon: Icons.person_outline,
                    title: l10n.profileEditNickname,
                    subtitle: l10n.onboardingNicknameRule,
                    showDivider: false,
                    onTap: () => context.push(AppRoutes.profileNickname),
                  ),
                ),
                SectionLabel(label: l10n.settingsLegal),
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
                const SizedBox(height: AppSpacing.xl),
                OutlinedButton(
                  onPressed: authState.isLoading
                      ? null
                      : () => _confirmSignOut(context, ref),
                  child: Text(l10n.homeSignOut),
                ),
                const SizedBox(height: AppSpacing.sm),
                TextButton(
                  onPressed: authState.isLoading
                      ? null
                      : () => _confirmWithdraw(context, ref),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.pressure,
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: Text(l10n.settingsWithdraw),
                ),
              ],
            ),
            if (authState.isLoading)
              const ColoredBox(
                color: Color(0x99000000),
                child: Center(child: AppSpinner(size: 28)),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmSignOut(BuildContext context, WidgetRef ref) async {
    final l10n = AppL10n.of(context);
    final confirmed = await _confirm(
      context,
      title: l10n.settingsLogoutConfirmTitle,
      body: l10n.settingsLogoutConfirmBody,
      confirmLabel: l10n.homeSignOut,
    );
    if (!confirmed) return;

    await ref.read(authNotifierProvider.notifier).signOut();
  }

  /// 되돌릴 수 없는 동작이라 무엇이 지워지는지 명시하고 한 번 더 확인받는다.
  Future<void> _confirmWithdraw(BuildContext context, WidgetRef ref) async {
    final l10n = AppL10n.of(context);
    final confirmed = await _confirm(
      context,
      title: l10n.settingsWithdrawConfirmTitle,
      body: l10n.settingsWithdrawConfirmBody,
      confirmLabel: l10n.settingsWithdrawConfirm,
      destructive: true,
    );
    if (!confirmed) return;

    await ref.read(authNotifierProvider.notifier).withdraw();
  }
}

/// OS 기본 스타일을 따르는 확인 대화상자.
Future<bool> _confirm(
  BuildContext context, {
  required String title,
  required String body,
  required String confirmLabel,
  bool destructive = false,
}) async {
  final l10n = AppL10n.of(context);

  final result = await showAdaptiveDialog<bool>(
    context: context,
    builder: (context) => AlertDialog.adaptive(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.commonCancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: destructive
              ? TextButton.styleFrom(foregroundColor: AppColors.pressure)
              : null,
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return result ?? false;
}
