import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/services/user/user_model.dart';
import 'package:flutter/material.dart';

/// A circular avatar that shows a profile image when available, otherwise
/// falls back to the user's initial on the brand [AppColors.paleSage] background.
///
/// Use [UserAvatar.fromUser] for a [UserModel], or the default constructor
/// for raw fields (e.g. from [MemberModel]).
class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final String firstName;
  final double radius;

  const UserAvatar({
    super.key,
    required this.imageUrl,
    required this.firstName,
    this.radius = 28,
  });

  factory UserAvatar.fromUser(UserModel? user, {double radius = 28}) {
    return UserAvatar(
      imageUrl: user?.image,
      firstName: user?.firstName ?? '',
      radius: radius,
    );
  }

  String get _initial =>
      firstName.isNotEmpty ? firstName[0].toUpperCase() : '?';

  double get _fontSize => radius * 0.7;

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.paleSage,
        child: ClipOval(
          child: Image.network(
            imageUrl!,
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
