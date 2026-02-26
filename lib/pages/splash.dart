import 'package:flutter/material.dart';

/// Shown on startup while [AuthController.isInitializing] is true.
/// The router automatically redirects away once the session restore completes.
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Endurance',
              style: Theme.of(
                context,
              ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Services Beyond Service',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(letterSpacing: 0.5),
            ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
