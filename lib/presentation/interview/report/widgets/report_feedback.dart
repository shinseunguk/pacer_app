import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../domain/entities/interview_report.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../common/app_spinner.dart';
import '../../../common/failure_message.dart';
import '../../../common/pressable.dart';
import '../../../common/ui.dart';
import '../../../providers/interview_providers.dart';

/// 리포트 만족도 — MVP 성공 기준 §6 "리포트 👍 비율"의 수집 지점.
///
/// 실패해도 리포트 열람 자체는 막지 않는다(부가 기능이므로).
class ReportFeedbackCard extends ConsumerStatefulWidget {
  const ReportFeedbackCard({required this.sessionId, this.initial, super.key});

  final String sessionId;

  /// 이전에 남긴 평가 (재진입 시 복원)
  final SessionFeedback? initial;

  @override
  ConsumerState<ReportFeedbackCard> createState() => _ReportFeedbackCardState();
}

class _ReportFeedbackCardState extends ConsumerState<ReportFeedbackCard> {
  final _commentController = TextEditingController();

  FeedbackRating? _rating;
  bool _isSending = false;

  /// 👎를 고르면 이유를 물어본다. 👍는 바로 저장하고 끝낸다.
  bool _showReason = false;

  @override
  void initState() {
    super.initState();
    _rating = widget.initial?.rating;
    _commentController.text = widget.initial?.comment ?? '';
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppL10n.of(context);
    final answered = _rating != null && !_showReason;

    return PacerCard(
      radius: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            answered ? l10n.reportFeedbackThanks : l10n.reportFeedbackQuestion,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _RatingButton(
                  icon: Icons.thumb_up_outlined,
                  label: l10n.reportFeedbackUp,
                  selected: _rating == FeedbackRating.up,
                  tone: context.colors.success,
                  onTap: _isSending ? null : () => _select(FeedbackRating.up),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _RatingButton(
                  icon: Icons.thumb_down_outlined,
                  label: l10n.reportFeedbackDown,
                  selected: _rating == FeedbackRating.down,
                  tone: context.colors.warm,
                  onTap: _isSending ? null : () => _select(FeedbackRating.down),
                ),
              ),
            ],
          ),
          if (_showReason) ...[
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _commentController,
              maxLines: 3,
              maxLength: 500,
              decoration: InputDecoration(
                hintText: l10n.reportFeedbackReasonHint,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            FilledButton(
              onPressed: _isSending ? null : _submit,
              child: _isSending
                  ? const AppSpinner(size: 20)
                  : Text(l10n.reportFeedbackSend),
            ),
          ],
        ],
      ),
    );
  }

  void _select(FeedbackRating rating) {
    hapticTap();
    setState(() {
      _rating = rating;
      // 아쉬웠던 이유는 품질 개선의 단서라 한 번 더 물어본다.
      _showReason = rating == FeedbackRating.down;
    });

    if (rating == FeedbackRating.up) _submit();
  }

  Future<void> _submit() async {
    final rating = _rating;
    if (rating == null) return;

    setState(() => _isSending = true);

    try {
      await ref.read(submitReportFeedbackProvider)(
        widget.sessionId,
        rating: rating,
        comment: rating == FeedbackRating.down ? _commentController.text : null,
      );
      if (!mounted) return;
      setState(() => _showReason = false);
    } on Object catch (error) {
      if (!mounted) return;

      // 실패하면 선택을 되돌려 다시 시도할 수 있게 한다.
      setState(() => _rating = widget.initial?.rating);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(failureMessage(error))));
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }
}

class _RatingButton extends StatelessWidget {
  const _RatingButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.tone,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final Color tone;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected
              ? tone.withValues(alpha: 0.16)
              : context.colors.surface2,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          border: Border.all(color: selected ? tone : context.colors.line),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 17, color: selected ? tone : context.colors.text2),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: selected ? tone : context.colors.text2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
