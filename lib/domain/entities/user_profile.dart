import 'usage_summary.dart';

class UserProfile {
  const UserProfile({
    required this.id,
    required this.nickname,
    required this.email,
    required this.isPro,
    required this.usage,
  });

  final String id;
  final String nickname;
  final String? email;
  final bool isPro;
  final UsageSummary usage;
}
