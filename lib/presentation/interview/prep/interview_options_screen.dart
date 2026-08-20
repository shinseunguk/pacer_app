import 'package:flutter/material.dart';
import '../../common/app_spinner.dart';
import '../../common/pressable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/entitlement.dart';
import '../../../domain/entities/interview_setup.dart';
import '../../../l10n/app_localizations.dart';
import '../../common/failure_message.dart';
import '../../providers/interview_providers.dart';
import '../../providers/user_providers.dart';
import '../../purchases/entitlement_notifier.dart';
import 'interview_setup_notifier.dart';
import 'widgets/preset_picker.dart';

/// S13 — 유형·난이도·질문 수·점수 표시 후 면접 시작.
class InterviewOptionsScreen extends ConsumerStatefulWidget {
  const InterviewOptionsScreen({super.key});

  @override
  ConsumerState<InterviewOptionsScreen> createState() =>
      _InterviewOptionsScreenState();
}

class _InterviewOptionsScreenState
    extends ConsumerState<InterviewOptionsScreen> {
  bool _isStarting = false;

  @override
  void initState() {
    super.initState();
    // 기본값은 '실전'(10문항)인데 무료는 5문항까지만 고를 수 있다. 그대로 두면
    // 잠긴 프리셋이 선택된 채로 뜨고, 시작을 누르면 402를 맞는다.
    WidgetsBinding.instance.addPostFrameCallback((_) => _normalizeToPlan());
  }

  /// 고를 수 없는 길이가 선택돼 있으면 고를 수 있는 값으로 내린다.
  void _normalizeToPlan() {
    if (!mounted) return;

    final entitlement = ref.read(entitlementProvider).valueOrNull;
    if (entitlement == null) return;

    final setup = ref.read(interviewSetupProvider);
    if (entitlement.canUseQuestionCount(setup.questionCount)) return;

    ref.read(interviewSetupProvider.notifier).setQuestionCount(
      kFreeQuestionCount,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final setup = ref.watch(interviewSetupProvider);
    final notifier = ref.read(interviewSetupProvider.notifier);
    // 못 읽었으면 무료로 가정한다 — pro로 가정하면 잠금이 풀린 화면을 잠깐 보여준다.
    // 이용권이 늦게 도착해도 잠긴 값이 선택된 채로 남지 않게 한다.
    ref.listen(entitlementProvider, (_, _) => _normalizeToPlan());

    final entitlement = ref
        .watch(entitlementProvider)
        .maybeWhen(
          data: (value) => value,
          orElse: () => const Entitlement.unknown(),
        );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.setupTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            _SectionLabel(l10n.setupType),
            SegmentedButton<InterviewType>(
              segments: [
                ButtonSegment(
                  value: InterviewType.general,
                  label: Text(l10n.setupTypeGeneral),
                ),
                ButtonSegment(
                  value: InterviewType.pressure,
                  label: Text(l10n.setupTypePressure),
                ),
              ],
              selected: {setup.interviewType},
              onSelectionChanged: (value) =>
                  notifier.setInterviewType(value.first),
            ),
            const SizedBox(height: AppSpacing.lg),
            _SectionLabel(l10n.setupDifficulty),
            SegmentedButton<InterviewDifficulty>(
              segments: [
                ButtonSegment(
                  value: InterviewDifficulty.low,
                  label: Text(l10n.setupDifficultyLow),
                ),
                ButtonSegment(
                  value: InterviewDifficulty.mid,
                  label: Text(l10n.setupDifficultyMid),
                ),
                ButtonSegment(
                  value: InterviewDifficulty.high,
                  label: Text(l10n.setupDifficultyHigh),
                ),
              ],
              selected: {setup.difficulty},
              onSelectionChanged: (value) =>
                  notifier.setDifficulty(value.first),
            ),
            const SizedBox(height: AppSpacing.lg),
            _SectionLabel(l10n.setupLength),
            PresetPicker(
              selected: InterviewPreset.fromQuestionCount(setup.questionCount),
              onSelected: (preset) =>
                  notifier.setQuestionCount(preset.questionCount),
              lockedPresets: _lockedPresets(entitlement),
              onLockedTap: (_) => _showPresetLocked(),
            ),
            const SizedBox(height: AppSpacing.sm),
            SwitchListTile.adaptive(
              value: setup.showScore,
              onChanged: notifier.setShowScore,
              title: Text(l10n.setupShowScore),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: AppSpacing.xl),
            FilledButton(
              onPressed: _isStarting ? null : () => _start(setup, entitlement),
              child: _isStarting
                  ? const AppSpinner(size: 20)
                  : Text(l10n.setupStart),
            ),
          ],
        ),
      ),
    );
  }

  Set<InterviewPreset> _lockedPresets(Entitlement entitlement) {
    if (entitlement.isPro) return const {};

    return InterviewPreset.values
        .where((preset) => !entitlement.canUseQuestionCount(preset.questionCount))
        .toSet();
  }

  Future<void> _showPresetLocked() async {
    final l10n = AppL10n.of(context);
    final goToPaywall = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.presetLockedTitle),
        content: Text(l10n.presetLockedBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.paywallCta),
          ),
        ],
      ),
    );

    if (goToPaywall != true || !mounted) return;
    await _openPaywall();
  }

  /// 페이월에서 구독하고 돌아오면 잠금이 바로 풀려야 한다.
  Future<void> _openPaywall() async {
    await context.push<bool>(AppRoutes.paywall);
    if (!mounted) return;
    await ref.read(entitlementProvider.notifier).refresh();
  }

  /// 무료가 하나 남았을 때만 예고한다. 매번 띄우면 잔소리가 되고,
  /// 다 쓴 뒤에 알리면 늦다.
  Future<bool> _confirmLastFree(Entitlement entitlement) async {
    if (!entitlement.isLastFreeInterview) return true;

    final l10n = AppL10n.of(context);
    final proceed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.lastFreeTitle),
        content: Text(l10n.lastFreeBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.lastFreeStart),
          ),
        ],
      ),
    );
    return proceed ?? false;
  }

  Future<void> _start(InterviewSetup setup, Entitlement entitlement) async {
    hapticTap();

    if (!await _confirmLastFree(entitlement)) return;
    if (!mounted) return;

    setState(() => _isStarting = true);

    try {
      final created = await ref.read(createInterviewProvider)(setup);
      if (!mounted) return;

      // 남은 한도 뱃지는 질문을 소비했으니 다시 읽는다.
      ref.invalidate(myProfileProvider);
      await ref.read(entitlementProvider.notifier).refresh();
      if (!mounted) return;

      ref.read(interviewSetupProvider.notifier).reset();
      context.go(AppRoutes.interviewSession(created.sessionId));
    } on PaymentRequiredFailure {
      // 402는 오류가 아니라 페이월로 가야 할 신호다.
      if (!mounted) return;
      await _openPaywall();
    } on Object catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(failureMessage(error))));
    } finally {
      if (mounted) setState(() => _isStarting = false);
    }
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
