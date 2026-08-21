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
                    // 시안은 명시적인 '편집' 버튼을 둔다 — 카드 전체가 눌리는 것보다
                    // 무엇이 바뀌는지 분명하다.
                    TextButton.icon(
                      onPressed: () => context.push(AppRoutes.profileNickname),
                      icon: const Icon(Icons.edit_outlined, size: 15),
                      label: Text(l10n.profileEdit),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              const _EntitlementRow(),
              const _UpsellCard(),
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
                  _PlanBadge(isPro: isPro),
                  const SizedBox(height: 6),
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

class _PlanBadge extends StatelessWidget {
  const _PlanBadge({required this.isPro});

  final bool isPro;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: isPro ? colors.accentSoft : colors.surface2,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        isPro ? l10n.profilePlanPro : l10n.profilePlanFree,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: isPro ? colors.accent : colors.text2,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// 구독 유도 카드 (시안).
///
/// **무료 사용자에게만 보여준다.** 이미 구독한 사람에게 구독을 권하는 건 소음이고,
/// 계정 화면을 열 때마다 그걸 보면 결제한 게 무색해진다.
class _UpsellCard extends ConsumerWidget {
  const _UpsellCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entitlement = ref
        .watch(entitlementProvider)
        .maybeWhen(
          data: (value) => value,
          orElse: () => const Entitlement.unknown(),
        );

    if (entitlement.isPro) return const SizedBox.shrink();

    final l10n = AppL10n.of(context);
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Pressable(
        onTap: () => context.push(AppRoutes.paywall),
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [colors.accent, colors.accent2],
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: colors.onAccent.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  l10n.profilePlanPro,
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.onAccent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 11),
              Text(
                l10n.profileUpsellTitle,
                style: textTheme.titleLarge?.copyWith(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                  color: colors.onAccent,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              for (final benefit in [
                l10n.profileUpsellBenefit1,
                l10n.profileUpsellBenefit2,
                l10n.profileUpsellBenefit3,
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: Row(
                    children: [
                      Icon(Icons.check, size: 15, color: colors.onAccent),
                      const SizedBox(width: 8),
                      Text(
                        benefit,
                        style: textTheme.bodySmall?.copyWith(
                          color: colors.onAccent.withValues(alpha: 0.92),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 9),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => context.push(AppRoutes.paywall),
                  style: FilledButton.styleFrom(
                    backgroundColor: colors.onAccent,
                    foregroundColor: colors.accent2,
                  ),
                  child: Text(l10n.profileUpsellCta),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
