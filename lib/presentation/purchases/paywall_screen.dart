import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/error/failure.dart';
import '../../core/router/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../common/app_spinner.dart';
import '../common/failure_message.dart';
import '../common/motion.dart';
import '../common/pacer_mark.dart';
import 'entitlement_notifier.dart';

/// S50 페이월.
///
/// 무료 2회를 다 쓴 지점, 잠긴 프리셋을 누른 지점, 402 응답에서 열린다.
/// 문구는 "제한"이 아니라 "체험"으로 쓴다 — 같은 사실이지만 뺏기는 느낌과
/// 받는 느낌의 차이가 전환을 가른다 (이슈 #21 문구 원칙).
class PaywallScreen extends ConsumerStatefulWidget {
  const PaywallScreen({super.key});

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  bool _isBusy = false;

  Future<void> _purchase() async {
    setState(() => _isBusy = true);
    try {
      await ref.read(entitlementProvider.notifier).purchase();
      if (!mounted) return;
      _closeWith(AppL10n.of(context).paywallDone);
    } on PurchaseCancelled {
      // 사용자가 결제 창을 닫은 것뿐이다 — 오류로 표시하지 않는다.
    } catch (error) {
      if (!mounted) return;
      _showMessage(failureMessage(error));
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  Future<void> _restore() async {
    setState(() => _isBusy = true);
    try {
      final restored = await ref.read(entitlementProvider.notifier).restore();
      if (!mounted) return;

      final l10n = AppL10n.of(context);
      if (restored) {
        _closeWith(l10n.paywallRestoreDone);
        return;
      }
      _showMessage(l10n.paywallRestoreEmpty);
    } catch (error) {
      if (!mounted) return;
      _showMessage(failureMessage(error));
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  void _closeWith(String message) {
    _showMessage(message);
    if (context.canPop()) context.pop(true);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.paywallTitle),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.canPop() ? context.pop(false) : null,
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.xl,
          ),
          children: [
            RiseIn(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PacerMark(size: 40),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    l10n.paywallHeadline,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.paywallSubhead,
                    style: textTheme.bodyMedium?.copyWith(color: colors.text2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            _Benefit(
              order: 1,
              icon: Icons.all_inclusive,
              title: l10n.paywallBenefitUnlimited,
              note: l10n.paywallBenefitUnlimitedNote,
            ),
            _Benefit(
              order: 2,
              icon: Icons.tune,
              title: l10n.paywallBenefitLength,
              note: l10n.paywallBenefitLengthNote,
            ),
            _Benefit(
              order: 3,
              icon: Icons.insights,
              title: l10n.paywallBenefitReport,
              note: l10n.paywallBenefitReportNote,
            ),
            const SizedBox(height: AppSpacing.xl),
            FilledButton(
              onPressed: _isBusy ? null : _purchase,
              child: _isBusy
                  ? const AppSpinner(size: 20)
                  : Text('${l10n.paywallCta} · ${l10n.paywallPrice}'),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              onPressed: _isBusy ? null : _restore,
              child: Text(l10n.paywallRestore),
            ),
            const SizedBox(height: AppSpacing.lg),
            const _SubscriptionTerms(),
          ],
        ),
      ),
    );
  }
}

class _Benefit extends StatelessWidget {
  const _Benefit({
    required this.order,
    required this.icon,
    required this.title,
    required this.note,
  });

  final int order;
  final IconData icon;
  final String title;
  final String note;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return RiseIn(
      order: order,
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: colors.accentSoft,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Icon(icon, size: 19, color: colors.accent),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    note,
                    style: textTheme.bodySmall?.copyWith(color: colors.text2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 자동 갱신 조건·해지 방법 고지. **애플 가이드라인 3.1.2 필수 항목**이라
/// 접거나 생략하지 않고 구매 버튼과 같은 화면에 그대로 둔다.
class _SubscriptionTerms extends StatelessWidget {
  const _SubscriptionTerms();

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    final bodyStyle = textTheme.bodySmall?.copyWith(color: colors.text2);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radius),
        border: Border.all(color: colors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.paywallTermsTitle,
            style: textTheme.labelLarge?.copyWith(color: colors.text),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.paywallTermsRenewal, style: bodyStyle),
          const SizedBox(height: AppSpacing.xs),
          Text(l10n.paywallTermsCancel, style: bodyStyle),
          const SizedBox(height: AppSpacing.sm),
          Text(l10n.paywallTermsLinks, style: bodyStyle),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              TextButton(
                onPressed: () => context.push(AppRoutes.legal('terms')),
                child: Text(l10n.paywallTerms),
              ),
              TextButton(
                onPressed: () => context.push(AppRoutes.legal('privacy')),
                child: Text(l10n.paywallPrivacy),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
