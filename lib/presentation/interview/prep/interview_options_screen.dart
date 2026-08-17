import 'package:flutter/material.dart';
import '../../common/app_spinner.dart';
import '../../common/pressable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/entities/interview_setup.dart';
import '../../../l10n/app_localizations.dart';
import '../../common/failure_message.dart';
import '../../providers/interview_providers.dart';
import '../../providers/user_providers.dart';
import 'interview_setup_notifier.dart';

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
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final setup = ref.watch(interviewSetupProvider);
    final notifier = ref.read(interviewSetupProvider.notifier);

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
            _SectionLabel(l10n.setupQuestionCount),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: setup.questionCount.toDouble(),
                    min: kMinQuestionCount.toDouble(),
                    max: kMaxQuestionCount.toDouble(),
                    divisions: kMaxQuestionCount - kMinQuestionCount,
                    label: '${setup.questionCount}',
                    onChanged: (value) =>
                        notifier.setQuestionCount(value.round()),
                  ),
                ),
                Text(l10n.setupQuestionCountValue(setup.questionCount)),
              ],
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
              onPressed: _isStarting ? null : () => _start(setup),
              child: _isStarting
                  ? const AppSpinner(size: 20)
                  : Text(l10n.setupStart),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _start(InterviewSetup setup) async {
    hapticTap();
    setState(() => _isStarting = true);

    try {
      final created = await ref.read(createInterviewProvider)(setup);
      if (!mounted) return;

      // 남은 한도 뱃지는 질문을 소비했으니 다시 읽는다.
      ref.invalidate(myProfileProvider);
      ref.read(interviewSetupProvider.notifier).reset();
      context.go(AppRoutes.interviewSession(created.sessionId));
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
