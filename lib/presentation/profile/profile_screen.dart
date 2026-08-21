import 'package:flutter/material.dart';
import '../common/app_spinner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/entitlement.dart';
import '../../l10n/app_localizations.dart';
import '../common/app_error_view.dart';
import '../common/pressable.dart';
import '../common/ui.dart';
import '../purchases/entitlement_notifier.dart';
import '../providers/user_providers.dart';

/// 마이 탭 — 계정 정보·약관·로그아웃. (설정 전체 화면 S60은 P1)
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppL10n.of(context);
    final profile = ref.watch(myProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tabProfile),
        actions: [
          IconButton(
            tooltip: l10n.settingsTitle,
            onPressed: () => context.push(AppRoutes.settings),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
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
                        color: context.colors.accentSoft,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          data.nickname.characters.firstOrNull ?? '?',
                          style: TextStyle(
                            color: context.colors.accent,
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
                    Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: context.colors.text3,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              const _EntitlementRow(),
            ],
          ),
        ),
      ),
    );
  }
}

/// 마이 화면의 이용권 줄.
///
/// 여기 있던 "오늘 기본 질문 N/20"은 과금 모델을 바꾸기 전(하루 질문 한도)의
/// 잔재였다. 아무것도 막지 않으면서 세기만 해서 `24/20` 같은 숫자가 그대로 보였다.
/// 계정 화면에서 알아야 할 건 "내가 무슨 이용권인가"다.
class _EntitlementRow extends ConsumerWidget {
  const _EntitlementRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppL10n.of(context);
    final colors = context.colors;
    final entitlement = ref
        .watch(entitlementProvider)
        .maybeWhen(
          data: (value) => value,
          orElse: () => const Entitlement.unknown(),
        );

    final isPro = entitlement.isPro;
    final expiresAt = entitlement.expiresAt;

    final detail = isPro
        ? (entitlement.autoRenewing && expiresAt != null
              ? l10n.homeProRenewal(_formatDate(expiresAt))
              : l10n.homeProNoRenewal)
        : (entitlement.hasExhaustedFreeInterviews
              ? l10n.homeFreeExhausted
              : l10n.profileEntitlementFree(entitlement.freeInterviewsRemaining));

    return Pressable(
      // 무료면 눌러서 바로 구독으로 갈 수 있어야 한다. Pro는 갈 곳이 없다.
      onTap: isPro ? null : () => context.push(AppRoutes.paywall),
      borderRadius: BorderRadius.circular(20),
      child: PacerCard(
        radius: 20,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.profileEntitlement,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isPro ? l10n.homeProTitle : detail,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isPro ? colors.accent : colors.text,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (isPro)
                    Text(
                      detail,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                ],
              ),
            ),
            if (!isPro)
              Icon(Icons.chevron_right, size: 18, color: colors.text3),
          ],
        ),
      ),
    );
  }
}

String _formatDate(DateTime date) {
  final local = date.toLocal();
  return '${local.month}월 ${local.day}일';
}
