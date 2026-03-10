import 'package:endurance_mobile_app/components/hero_icon.dart';
import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String? heroIconPath;
  final IconData? icon;
  final String title;
  final String body;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    this.heroIconPath,
    this.icon,
    required this.title,
    required this.body,
    this.actionLabel,
    this.onAction,
  }) : assert(heroIconPath != null || icon != null, 'Provide heroIconPath or icon');

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            heroIconPath != null
                ? HeroIcon(heroIconPath!, size: 64, color: color)
                : Icon(icon!, size: 64, color: color),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              body,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
