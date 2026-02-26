import 'package:endurance_mobile_app/services/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:endurance_mobile_app/l10n/app_localizations.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 56),
                    Text(
                      l10n.appTitle,
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.tagline,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      l10n.welcomeDescription,
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 40),
                    _FeatureTile(
                      icon: Icons.shield_outlined,
                      title: l10n.featurePrivacyTitle,
                      description: l10n.featurePrivacyDesc,
                    ),
                    const SizedBox(height: 20),
                    _FeatureTile(
                      icon: Icons.favorite_border,
                      title: l10n.featureMentalHealthTitle,
                      description: l10n.featureMentalHealthDesc,
                    ),
                    const SizedBox(height: 20),
                    _FeatureTile(
                      icon: Icons.people_outline,
                      title: l10n.featureConnectedTitle,
                      description: l10n.featureConnectedDesc,
                    ),
                    const SizedBox(height: 20),
                    _FeatureTile(
                      icon: Icons.lock_outline,
                      title: l10n.featureSharingTitle,
                      description: l10n.featureSharingDesc,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            // Button pinned to the bottom, outside the scroll area.
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
              child: Obx(
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
                        : Text(l10n.getStarted),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 28, color: theme.colorScheme.primary),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(description, style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}

