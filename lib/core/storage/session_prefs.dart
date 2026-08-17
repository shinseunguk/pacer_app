import 'package:shared_preferences/shared_preferences.dart';

/// Non-sensitive session flags (tokens live in [TokenStorage] instead).
///
/// `GET /users/me` does not expose whether onboarding finished, so the flag
/// from the login response is cached here for relaunches.
class SessionPrefs {
  const SessionPrefs(this._prefs);

  final SharedPreferences _prefs;

  static const _onboardingKey = 'pacer.onboarding_completed';

  bool get onboardingCompleted => _prefs.getBool(_onboardingKey) ?? false;

  Future<void> setOnboardingCompleted(bool value) =>
      _prefs.setBool(_onboardingKey, value);

  Future<void> clear() => _prefs.remove(_onboardingKey);
}
