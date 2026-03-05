import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/services/user/user_model.dart';
import 'package:flutter/material.dart';

/// A circular avatar for a [UserModel].
/// Shows the profile image when available, otherwise falls back to the user's
/// initial on the brand [AppColors.paleSage] background.
class UserAvatar extends StatelessWidget {
  final UserModel? user;
  final double radius;

  const UserAvatar({super.key, required this.user, this.radius = 28});

  String get _initial => user != null && user!.firstName.isNotEmpty
      ? user!.firstName[0].toUpperCase()
      : '?';

  double get _fontSize => radius * 0.7;

  @override
  Widget build(BuildContext context) {
    final imageUrl = user?.image;

    if (imageUrl != null) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.paleSage,
        child: ClipOval(
          child: Image.network(
            imageUrl,
            width: radius * 2,
            height: radius * 2,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                _Fallback(initial: _initial, fontSize: _fontSize),
          ),
        ),
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.paleSage,
      child: _Fallback(initial: _initial, fontSize: _fontSize),
    );
  }
}

class _Fallback extends StatelessWidget {
  final String initial;
  final double fontSize;

  const _Fallback({required this.initial, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      initial,
      style: TextStyle(
        color: AppColors.mossGreen,
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
