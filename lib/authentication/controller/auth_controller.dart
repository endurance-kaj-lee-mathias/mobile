import 'dart:convert';

import 'package:endurance_mobile_app/authentication/models/token_model.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxBool isAuthenticated = false.obs;
  final Rxn<TokenModel> token = Rxn<TokenModel>();
  final RxList<String> userRoles = <String>[].obs;

  bool get isVeteran => userRoles.contains('veteran');

  final FlutterAppAuth _appAuth = FlutterAppAuth();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _issuer = 'https://10.0.2.2:8443/realms/endurance';
  static const String _clientId = 'mobile';
  static const String _redirectUri = 'be.kdg.endurance://oauthredirect';

  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyIdToken = 'id_token';

  String? get authorizationHeader {
    final t = token.value;
    if (t == null) return null;
    return 'Bearer ${t.accessToken}';
  }

  @override
  void onInit() {
    super.onInit();
    _restoreSession();
  }

  Future<void> _restoreSession() async {
    try {
      final storedRefreshToken = await _storage.read(key: _keyRefreshToken);
      if (storedRefreshToken == null) return;

      final result = await _appAuth.token(
        TokenRequest(
          _clientId,
          _redirectUri,
          issuer: _issuer,
          refreshToken: storedRefreshToken,
          scopes: ['openid', 'profile', 'email'],
        ),
      );

      if (result.accessToken != null) {
        token.value = TokenModel(
          accessToken: result.accessToken!,
          refreshToken: result.refreshToken ?? storedRefreshToken,
          idToken: result.idToken,
          accessTokenExpirationDateTime: result.accessTokenExpirationDateTime,
        );
        await _storage.write(
            key: _keyRefreshToken, value: token.value!.refreshToken);
        if (token.value!.idToken != null) {
          await _storage.write(key: _keyIdToken, value: token.value!.idToken);
        }
        _extractRoles(result.accessToken!);
        isAuthenticated.value = true;
      } else {
        await _clearStorage();
      }
    } catch (_) {
      await _clearStorage();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login() async {
    try {
      isLoading.value = true;

      final result = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          _clientId,
          _redirectUri,
          issuer: _issuer,
          scopes: ['openid', 'profile', 'email'],
        ),
      );

      if (result.accessToken != null) {
        token.value = TokenModel(
          accessToken: result.accessToken!,
          refreshToken: result.refreshToken,
          idToken: result.idToken,
          accessTokenExpirationDateTime: result.accessTokenExpirationDateTime,
        );
        await _storage.write(key: _keyRefreshToken, value: result.refreshToken);
        if (result.idToken != null) {
          await _storage.write(key: _keyIdToken, value: result.idToken);
        }
        _extractRoles(result.accessToken!);
        isAuthenticated.value = true;
      } else {
        isAuthenticated.value = false;
      }
    } catch (e) {
      print('login error: $e');
      isAuthenticated.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;
      final idToken = token.value?.idToken;
      token.value = null;
      userRoles.clear();
      isAuthenticated.value = false;
      await _clearStorage();

      await _appAuth.endSession(
        EndSessionRequest(
          idTokenHint: idToken,
          postLogoutRedirectUrl: _redirectUri,
          issuer: _issuer,
        ),
      );
    } catch (e) {
      print('Logout error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _clearStorage() async {
    await _storage.delete(key: _keyRefreshToken);
    await _storage.delete(key: _keyIdToken);
  }

  void _extractRoles(String accessToken) {
    try {
      final parts = accessToken.split('.');
      if (parts.length != 3) return;
      var payload = parts[1];
      switch (payload.length % 4) {
        case 2:
          payload += '==';
        case 3:
          payload += '=';
      }
      final data = jsonDecode(utf8.decode(base64Url.decode(payload))) as Map<
          String,
          dynamic>;
      final roles = ((data['realm_access'] as Map<String,
          dynamic>?)?['roles'] as List<dynamic>?)
          ?.cast<String>() ??
          [];
      userRoles.assignAll(roles);
    } catch (_) {
      userRoles.clear();
    }
  }
}
