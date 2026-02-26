import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Renders a Hero Icon SVG asset, mimicking the [Icon] widget API.
class HeroIcon extends StatelessWidget {
  const HeroIcon(this.assetPath, {super.key, this.size = 24.0, this.color});

  final String assetPath;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? IconTheme.of(context).color;
    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      colorFilter: effectiveColor != null
          ? ColorFilter.mode(effectiveColor, BlendMode.srcIn)
          : null,
    );
  }
}

/// Asset path constants for all Hero Icons used in this app.
///
/// Drop the matching SVG files from https://heroicons.com into the paths below:
///   assets/icons/outline/  → outline (24px) variants
///   assets/icons/solid/    → solid (24px) variants
abstract final class HeroIcons {
  // Navigation
  static const String homeOutline = 'assets/icons/outline/home.svg';
  static const String homeSolid = 'assets/icons/solid/home.svg';
  static const String chatOutline =
      'assets/icons/outline/chat-bubble-left-right.svg';
  static const String chatSolid =
      'assets/icons/solid/chat-bubble-left-right.svg';

  // Welcome page features
  static const String shieldOutline = 'assets/icons/outline/shield-check.svg';
  static const String heartOutline = 'assets/icons/outline/heart.svg';
  static const String userGroupOutline = 'assets/icons/outline/user-group.svg';
  static const String lockOutline = 'assets/icons/outline/lock-closed.svg';

  // Unauthorized page
  static const String noSymbolOutline = 'assets/icons/outline/no-symbol.svg';

  // Profile page
  static const String logoutOutline =
      'assets/icons/outline/arrow-right-on-rectangle.svg';
}
