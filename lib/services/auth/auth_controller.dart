import 'package:endurance_mobile_app/config/app_config.dart';
import 'package:endurance_mobile_app/services/auth/token_model.dart';
import 'package:endurance_mobile_app/services/auth/auth_storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:get/get.dart';

/// Manages authentication state for the entire app.
///
/// Lifecycle:
///   1. [onInit] runs [_restoreSession] — tries to silently log the user back
///      in using a stored refresh token. [isInitializing] is true until done.
///   2. [login] opens the Keycloak browser flow and exchanges the code for tokens.
///   3. [logout] ends the Keycloak session and clears all stored state.
///
/// Consumers should check [isAuthenticated] and [isVeteran] for routing.
/// Use [authorizationHeader] to attach a Bearer token to backend requests.
class AuthController extends GetxController {
  // ── State ──────────────────────────────────────────────────────────────────

  /// True while the app is checking for a stored session on startup.
  /// The splash screen is shown until this becomes false.
  final RxBool isInitializing = true.obs;

  /// True while a login or logout operation is in progress.
  final RxBool isLoading = false.obs;

  final RxBool isAuthenticated = false.obs;
  final Rxn<TokenModel> token = Rxn<TokenModel>();
  final RxList<String> userRoles = <String>[].obs;

  // ── Derived state ──────────────────────────────────────────────────────────

  bool get isVeteran => userRoles.contains('veteran');

  /// Ready-to-use Authorization header value for backend HTTP requests.
  String? get authorizationHeader {
    final t = token.value;
    if (t == null) return null;
    return 'Bearer ${t.accessToken}';
  }

  // ── Private dependencies ───────────────────────────────────────────────────

  final _appAuth = FlutterAppAuth();
  final _storage = AuthStorageService();

  static const _issuer = AppConfig.keycloakIssuer;
  static const _clientId = AppConfig.keycloakClientId;
  static const _redirectUri = AppConfig.keycloakRedirectUri;

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  @override
  void onInit() {
    super.onInit();
    _restoreSession();
  }

  // ── Public actions ─────────────────────────────────────────────────────────

  /// Opens the Keycloak login page in a browser. On success the user is
  /// authenticated and the router automatically navigates to the home screen.
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
        await _applyTokenResult(
          accessToken: result.accessToken!,
          refreshToken: result.refreshToken,
          idToken: result.idToken,
          expiry: result.accessTokenExpirationDateTime,
        );
      }
    } catch (e) {
      debugPrint('Login error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Ends the Keycloak session and clears all local auth state.
  Future<void> logout() async {
    try {
      isLoading.value = true;
      final idToken = token.value?.idToken;

      _clearState();
      await _storage.clearTokens();

      await _appAuth.endSession(
        EndSessionRequest(
          idTokenHint: idToken,
          postLogoutRedirectUrl: _redirectUri,
          issuer: _issuer,
        ),
      );
    } catch (e) {
      debugPrint('Logout error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ── Private helpers ────────────────────────────────────────────────────────

  /// Called once on startup. Uses the stored refresh token to silently obtain
  /// a fresh access token, restoring the previous session without a browser.
  Future<void> _restoreSession() async {
    try {
      final refreshToken = await _storage.getRefreshToken();
      if (refreshToken == null) return;

      final result = await _appAuth.token(
        TokenRequest(
          _clientId,
          _redirectUri,
          issuer: _issuer,
          refreshToken: refreshToken,
          scopes: ['openid', 'profile', 'email'],
        ),
      );

      if (result.accessToken != null) {
        await _applyTokenResult(
          accessToken: result.accessToken!,
          refreshToken: result.refreshToken ?? refreshToken,
          idToken: result.idToken,
          expiry: result.accessTokenExpirationDateTime,
        );
      } else {
        await _storage.clearTokens();
      }
    } catch (_) {
      await _storage.clearTokens();
    } finally {
      isInitializing.value = false;
    }
  }

  /// Stores tokens, extracts roles and marks the user as authenticated.
  Future<void> _applyTokenResult({
    required String accessToken,
    required String? refreshToken,
    required String? idToken,
    required DateTime? expiry,
  }) async {
    token.value = TokenModel(
      accessToken: accessToken,
      refreshToken: refreshToken,
      idToken: idToken,
      accessTokenExpirationDateTime: expiry,
    );
    await _storage.saveTokens(refreshToken: refreshToken, idToken: idToken);
    userRoles.assignAll(token.value!.realmRoles);
    isAuthenticated.value = true;
  }

  void _clearState() {
    token.value = null;
    userRoles.clear();
    isAuthenticated.value = false;
  }
}
