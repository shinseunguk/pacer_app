import 'package:shared_preferences/shared_preferences.dart';

/// Non-sensitive session flags (tokens live in [TokenStorage] instead).
///
/// `GET /users/me` does not expose whether onboarding finished, so the flag
/// from the login response is cached here for relaunches.
class SessionPrefs {
  const SessionPrefs(this._prefs);

  final SharedPreferences _prefs;

  static const _onboardingKey = 'pacer.onboarding_completed';
  static const _introKey = 'pacer.intro_seen';

  bool get onboardingCompleted => _prefs.getBool(_onboardingKey) ?? false;

  Future<void> setOnboardingCompleted(bool value) =>
      _prefs.setBool(_onboardingKey, value);

  /// 인트로(S00a)를 본 적이 있는가.
  ///
  /// 로그아웃해도 지우지 않는다 — 서비스 소개는 계정이 아니라 **기기**에 한 번만
  /// 보여주면 된다. 다시 로그인할 때마다 소개를 또 보는 건 잔소리다.
  bool get introSeen => _prefs.getBool(_introKey) ?? false;

  Future<void> setIntroSeen() => _prefs.setBool(_introKey, true);

  Future<void> clear() => _prefs.remove(_onboardingKey);
}
