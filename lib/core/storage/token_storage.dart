import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Token pair persisted between launches.
class StoredTokens {
  const StoredTokens({required this.accessToken, required this.refreshToken});

  final String accessToken;
  final String refreshToken;
}

/// Tokens are sensitive, so they live in the keychain/keystore only —
/// never in shared_preferences (앱 가이드: 민감정보는 secure storage).
class TokenStorage {
  TokenStorage(this._storage);

  final FlutterSecureStorage _storage;

  static const _accessKey = 'pacer.access_token';
  static const _refreshKey = 'pacer.refresh_token';

  Future<StoredTokens?> read() async {
    final access = await _storage.read(key: _accessKey);
    final refresh = await _storage.read(key: _refreshKey);
    if (access == null || refresh == null) return null;

    return StoredTokens(accessToken: access, refreshToken: refresh);
  }

  Future<void> save(StoredTokens tokens) async {
    await _storage.write(key: _accessKey, value: tokens.accessToken);
    await _storage.write(key: _refreshKey, value: tokens.refreshToken);
  }

  Future<void> clear() async {
    await _storage.delete(key: _accessKey);
    await _storage.delete(key: _refreshKey);
  }
}
