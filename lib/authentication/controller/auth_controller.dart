import 'package:endurance_mobile_app/authentication/models/token_model.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isAuthenticated = false.obs;
  final Rxn<TokenModel> token = Rxn<TokenModel>();

  final FlutterAppAuth _appAuth = FlutterAppAuth();

  static const String _issuer = 'https://10.0.2.2:8443/realms/endurance';
  static const String _clientId = 'endurance-app';
  static const String _redirectUri = 'be.kdg.endurance://oauthredirect';

  /// Use this header value for backend HTTP requests.
  String? get authorizationHeader {
    final t = token.value;
    if (t == null) return null;
    return 'Bearer ${t.accessToken}';
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
      isAuthenticated.value = false;

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
}
