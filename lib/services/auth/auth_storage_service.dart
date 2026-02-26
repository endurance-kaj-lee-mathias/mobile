import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Handles persistent storage of OAuth tokens using the device's secure
/// keystore (Android Keystore / iOS Keychain).
class AuthStorageService {
  static const _keyRefreshToken = 'refresh_token';
  static const _keyIdToken = 'id_token';

  final _storage = const FlutterSecureStorage();

  /// Returns the stored refresh token, or null if none exists.
  Future<String?> getRefreshToken() => _storage.read(key: _keyRefreshToken);

  /// Returns the stored ID token, or null if none exists.
  Future<String?> getIdToken() => _storage.read(key: _keyIdToken);

  /// Persists the refresh and ID tokens after a successful login.
  Future<void> saveTokens({
    required String? refreshToken,
    String? idToken,
  }) async {
    if (refreshToken != null) {
      await _storage.write(key: _keyRefreshToken, value: refreshToken);
    }
    if (idToken != null) {
      await _storage.write(key: _keyIdToken, value: idToken);
    }
  }

  /// Removes all stored tokens. Called on logout or when a refresh fails.
  Future<void> clearTokens() async {
    await _storage.delete(key: _keyRefreshToken);
    await _storage.delete(key: _keyIdToken);
  }
}
