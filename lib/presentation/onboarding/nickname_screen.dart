import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/validation/nickname_rule.dart';
import '../../l10n/app_localizations.dart';
import '../common/app_spinner.dart';
import '../common/pressable.dart';
import 'nickname_check_notifier.dart';
import 'onboarding_notifier.dart';

/// S02 — 닉네임. 규칙(한글·영문·숫자·이모지 2~12자)을 입력 중에 알려주고,
/// 서버에 중복까지 미리 확인한다.
class NicknameScreen extends ConsumerStatefulWidget {
  const NicknameScreen({super.key});

  @override
  ConsumerState<NicknameScreen> createState() => _NicknameScreenState();
}

class _NicknameScreenState extends ConsumerState<NicknameScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: ref.read(onboardingDraftProvider).nickname,
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
    final check = ref.watch(nicknameCheckProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.onboardingNicknameTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.onboardingNicknameDescription,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: AppSpacing.lg),
              TextField(
                controller: _controller,
                autofocus: true,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: l10n.onboardingNicknameHint,
                  suffixIcon: _StatusIcon(status: check.status),
                ),
                onChanged: (value) {
                  ref.read(nicknameCheckProvider.notifier).onChanged(value);
                  setState(() {}); // 글자 수 표시 갱신
                },
                onSubmitted: (_) => _submit(check),
              ),
              const SizedBox(height: AppSpacing.sm),
              _HelperRow(
                message: check.message ?? l10n.onboardingNicknameRule,
                isError: check.isError,
                length: nicknameLength(_controller.text),
              ),
              const Spacer(),
              FilledButton(
                onPressed: check.canSubmit ? () => _submit(check) : null,
                child: Text(l10n.commonNext),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit(NicknameCheckState check) {
    if (!check.canSubmit) return;

    hapticTap();
    ref
        .read(onboardingDraftProvider.notifier)
        .setNickname(normalizeNickname(_controller.text));
    context.push(AppRoutes.onboardingConsent);
  }
}

/// 입력칸 오른쪽의 상태 표시 — 확인 중/사용 가능/중복.
class _StatusIcon extends StatelessWidget {
  const _StatusIcon({required this.status});

  final NicknameStatus status;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      NicknameStatus.checking => const Padding(
        padding: EdgeInsets.all(14),
        child: AppSpinner(size: 18),
      ),
      NicknameStatus.available => Icon(
        Icons.check_circle,
        color: context.colors.success,
        size: 20,
      ),
      NicknameStatus.taken || NicknameStatus.invalid => Icon(
        Icons.error_outline,
        color: context.colors.pressure,
        size: 20,
      ),
      _ => const SizedBox.shrink(),
    };
  }
}

/// 안내 문구 + 글자 수.
class _HelperRow extends StatelessWidget {
  const _HelperRow({
    required this.message,
    required this.isError,
    required this.length,
  });

  final String message;
  final bool isError;
  final int length;

  @override
  Widget build(BuildContext context) {
    final overLimit = length > nicknameMaxLength;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            message,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: isError ? context.colors.pressure : context.colors.text3,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          '$length/$nicknameMaxLength',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: overLimit ? context.colors.pressure : context.colors.text3,
            fontFeatures: kNumberFeatures,
          ),
        ),
      ],
    );
  }
}
