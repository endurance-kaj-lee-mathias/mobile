import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String label;
  final EdgeInsetsGeometry padding;

  const SectionHeader({
    super.key,
    required this.label,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final text = Text(
      label,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
        letterSpacing: 1.2,
        fontWeight: FontWeight.w700,
      ),
    );
    if (padding == EdgeInsets.zero) return text;
    return Padding(padding: padding, child: text);
  }
}
