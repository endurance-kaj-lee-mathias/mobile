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

abstract final class HeroIcons {
  static const String homeSolid      = 'assets/icons/solid/home.svg';
  static const String chatSolid      = 'assets/icons/solid/chat-bubble-left-right.svg';
  static const String userGroupSolid = 'assets/icons/solid/user-group.svg';

  // Navigation / auth
  static const String homeOutline    = 'assets/icons/outline/home.svg';
  static const String chatOutline    = 'assets/icons/outline/chat-bubble-left-right.svg';
  static const String userGroupOutline = 'assets/icons/outline/user-group.svg';
  static const String logoutOutline  = 'assets/icons/outline/arrow-right-on-rectangle.svg';
  static const String lockOutline    = 'assets/icons/outline/lock-closed.svg';
  static const String noSymbolOutline = 'assets/icons/outline/no-symbol.svg';

  // Profile / account
  static const String shieldOutline  = 'assets/icons/outline/shield-check.svg';
  static const String pencil         = 'assets/icons/outline/pencil.svg';
  static const String trash          = 'assets/icons/outline/trash.svg';
  static const String envelope       = 'assets/icons/outline/envelope.svg';
  static const String phone          = 'assets/icons/outline/phone.svg';
  static const String mapPin         = 'assets/icons/outline/map-pin.svg';
  static const String clipboardDocument = 'assets/icons/outline/clipboard-document.svg';

  // Network / people
  static const String userPlus       = 'assets/icons/outline/user-plus.svg';
  static const String userMinus      = 'assets/icons/outline/user-minus.svg';
  static const String atSymbol       = 'assets/icons/outline/at-symbol.svg';
  static const String chatBubbleLeft = 'assets/icons/outline/chat-bubble-left.svg';

  // Home / check-in
  static const String clock          = 'assets/icons/outline/clock.svg';
  static const String checkCircle    = 'assets/icons/outline/check-circle.svg';
  static const String calendarDays   = 'assets/icons/outline/calendar-days.svg';
  static const String chartLine      = 'assets/icons/outline/presentation-chart-line.svg';
  static const String chevronRight   = 'assets/icons/outline/chevron-right.svg';
  static const String heartOutline   = 'assets/icons/outline/heart.svg';
  static const String signal         = 'assets/icons/outline/signal.svg';
  static const String ellipsisCircle = 'assets/icons/outline/ellipsis-horizontal-circle.svg';
}
