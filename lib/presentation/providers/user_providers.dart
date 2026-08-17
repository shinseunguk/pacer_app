import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user_profile.dart';
import 'app_providers.dart';

/// `GET /users/me` — greeting + remaining quota on the home screen.
final myProfileProvider = FutureProvider.autoDispose<UserProfile>((ref) {
  return ref.watch(getMyProfileProvider)();
});
