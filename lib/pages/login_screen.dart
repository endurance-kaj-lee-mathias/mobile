import 'package:endurance_mobile_app/authentication/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keycloak Login')),
      body: Center(
        child: Obx(() {
          if (authController.isAuthenticated.value) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('You are logged in!'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: authController.logout,
                  child: const Text('Logout'),
                ),
              ],
            );
          } else {
            return ElevatedButton(
              onPressed: authController.login,
              child: const Text('Login with Keycloak'),
            );
          }
        }),
      ),
    );
  }
}
