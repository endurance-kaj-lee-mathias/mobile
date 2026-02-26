import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isAuthenticated = false.obs;

  final FlutterAppAuth appAuth = FlutterAppAuth();

  final String issuer = 'https://10.0.2.2:8443/realms/endurance';
  final String clientId = 'endurance-app';
  final String redirectUri = 'be.kdg.endurance://oauthredirect';

  Future<void> login() async {
    try {
      isLoading.value = true;

      final result = await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          clientId,
          redirectUri,
          issuer: issuer,
          scopes: ['openid', 'profile', 'email', 'offline_access'],
        ),
      );

      if (result != null && result.accessToken != null) {
        print('Login successful!');
        print('Access Token: ${result.accessToken}');
        isAuthenticated.value = true;
      } else {
        print('Login failed: No token received');
        isAuthenticated.value = false;
      }
    } catch (e) {
      print("login error: $e");
      isAuthenticated.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;

      await appAuth.endSession(
        EndSessionRequest(postLogoutRedirectUrl: redirectUri, issuer: issuer),
      );

      print("Logout successful");
      isAuthenticated.value = false;
    } catch (e) {
      print("Logout failed: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
