import 'package:flutter/material.dart';
import 'package:endurance_mobile_app/l10n/app_localizations.dart';

/// Shown on startup while [AuthController.isInitializing] is true.
/// The router automatically redirects away once the session restore completes.
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.appTitle,
              style: Theme.of(
                context,
              ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.tagline,
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
