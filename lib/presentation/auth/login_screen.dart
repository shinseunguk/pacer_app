import 'package:flutter/material.dart';
import '../common/pressable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/error/failure.dart';
import '../../core/router/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/legal_document.dart';
import '../../domain/entities/social_provider.dart';
import '../../l10n/app_localizations.dart';
import '../common/failure_message.dart';
import '../common/pacer_mark.dart';
import 'auth_notifier.dart';
import 'widgets/social_sign_in_button.dart';

/// S01 — 소셜 로그인. 시안(screen_auth.jsx)의 구성을 따른다.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  SocialProvider? _pending;

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final authState = ref.watch(authNotifierProvider);
    final isBusy = authState.isLoading;

    ref.listen(authNotifierProvider, (_, next) {
      if (next.isLoading) return;
      if (mounted) setState(() => _pending = null);

      final error = next.error;
      if (error == null) return;
      // 사용자가 로그인 창을 닫은 것은 알릴 일이 아니다.
      if (error is SignInCancelled) return;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(failureMessage(error))));
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const PacerWordmark(),
                      const SizedBox(height: 10),
                      Text(
                        l10n.appTagline,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: context.colors.text2,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 270),
                        child: Text(
                          l10n.loginSubcopy,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: context.colors.text3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 0, 22, 26),
              child: Column(
                children: [
                  SocialSignInButton.kakao(
                    label: l10n.loginKakao,
                    isLoading: _pending == SocialProvider.kakao,
                    onPressed: isBusy
                        ? null
                        : () => _signIn(SocialProvider.kakao),
                  ),
                  const SizedBox(height: 10),
                  SocialSignInButton.apple(
                    label: l10n.loginApple,
                    isLoading: _pending == SocialProvider.apple,
                    onPressed: isBusy
                        ? null
                        : () => _signIn(SocialProvider.apple),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _LegalNotice(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signIn(SocialProvider provider) {
    hapticTap();
    setState(() => _pending = provider);
    ref.read(authNotifierProvider.notifier).signIn(provider);
  }
}

/// 약관·처리방침 고지 — 시안과 달리 밑줄 텍스트를 실제 링크로 연결한다.
class _LegalNotice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final style = Theme.of(context).textTheme.labelSmall?.copyWith(
      color: context.colors.text3,
      fontWeight: FontWeight.w500,
      height: 1.6,
    );

    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _LegalLink(label: l10n.legalTerms, type: LegalDocumentType.terms),
            Text(' · ', style: style),
            _LegalLink(
              label: l10n.legalPrivacy,
              type: LegalDocumentType.privacy,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(l10n.loginNoticeTerms, textAlign: TextAlign.center, style: style),
        Text(l10n.loginNoticeAi, textAlign: TextAlign.center, style: style),
      ],
    );
  }
}

class _LegalLink extends StatelessWidget {
  const _LegalLink({required this.label, required this.type});

  final String label;
  final LegalDocumentType type;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.legal(type.value)),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: context.colors.text2,
          decoration: TextDecoration.underline,
          decorationColor: context.colors.text3,
        ),
      ),
    );
  }
}
