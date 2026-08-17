/// Daily base-question quota (KST midnight reset, follow-ups excluded).
class UsageSummary {
  const UsageSummary({
    required this.date,
    required this.baseQuestionUsed,
    required this.limit,
    required this.remaining,
  });

  final String date;
  final int baseQuestionUsed;
  final int limit;
  final int remaining;
}
