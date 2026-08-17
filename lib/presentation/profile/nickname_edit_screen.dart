import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/validation/nickname_rule.dart';
import '../../l10n/app_localizations.dart';
import '../common/app_spinner.dart';
import '../common/failure_message.dart';
import '../common/pressable.dart';
import '../onboarding/nickname_check_notifier.dart';
import '../providers/app_providers.dart';
import '../providers/user_providers.dart';

/// 닉네임 수정 — 온보딩(S02)과 같은 규칙·중복 확인을 쓴다.
class NicknameEditScreen extends ConsumerStatefulWidget {
  const NicknameEditScreen({super.key});

  @override
  ConsumerState<NicknameEditScreen> createState() => _NicknameEditScreenState();
}

class _NicknameEditScreenState extends ConsumerState<NicknameEditScreen> {
  final _controller = TextEditingController();
  bool _isSaving = false;
  bool _initialized = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final profile = ref.watch(myProfileProvider);
    final check = ref.watch(nicknameCheckProvider);

    // 현재 닉네임을 한 번만 채운다(이후 사용자의 입력을 덮지 않도록).
    final current = profile.valueOrNull?.nickname;
    if (!_initialized && current != null) {
      _controller.text = current;
      _initialized = true;
    }

    // 값을 바꾸지 않았으면 저장할 것이 없다.
    final unchanged = normalizeNickname(_controller.text) == current;
    final canSave = !_isSaving && !unchanged && check.canSubmit;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileEditNickname)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                  setState(() {});
                },
                onSubmitted: (_) => canSave ? _save() : null,
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      check.message ?? l10n.onboardingNicknameRule,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: check.isError
                            ? context.colors.pressure
                            : context.colors.text3,
                      ),
                    ),
                  ),
                  Text(
                    '${nicknameLength(_controller.text)}/$nicknameMaxLength',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontFeatures: kNumberFeatures,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              FilledButton(
                onPressed: canSave ? _save : null,
                child: _isSaving
                    ? const AppSpinner(size: 20)
                    : Text(l10n.commonSave),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    hapticTap();
    setState(() => _isSaving = true);

    try {
      await ref.read(updateNicknameProvider)(_controller.text);
      if (!mounted) return;

      // 홈 인사·마이 화면이 새 닉네임을 읽도록 다시 불러온다.
      ref.invalidate(myProfileProvider);
      context.pop();
    } on Object catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(failureMessage(error))));
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}

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
