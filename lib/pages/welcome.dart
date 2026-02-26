import 'package:endurance_mobile_app/services/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Landing page shown to unauthenticated users.
/// Presents a brief app description and a "Get Started" button that opens
/// the Keycloak login flow.
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                'Endurance',
                style: Theme.of(
                  context,
                ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Track your training, monitor your progress and stay on top of your endurance journey.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    // Disable the button while the login flow is in progress.
                    onPressed: auth.isLoading.value ? null : auth.login,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: auth.isLoading.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Get Started'),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

