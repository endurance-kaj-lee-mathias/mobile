import 'package:flutter/material.dart';

class BorderedCard extends StatelessWidget {
  final Widget child;
  final double radius;
  final Color? borderColor;
  final double borderWidth;

  const BorderedCard({
    super.key,
    required this.child,
    this.radius = 16,
    this.borderColor,
    this.borderWidth = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(
          color: borderColor ?? Theme.of(context).colorScheme.outlineVariant,
          width: borderWidth,
        ),
      ),
      child: child,
    );
  }
}
