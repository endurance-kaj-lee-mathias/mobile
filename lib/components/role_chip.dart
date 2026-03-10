import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/services/network/member_model.dart';
import 'package:flutter/material.dart';

class RoleChip extends StatelessWidget {
  final MemberRole role;

  const RoleChip({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    if (role == MemberRole.unknown) return const SizedBox.shrink();

    final l10n = S.of(context);
    final label = switch (role) {
      MemberRole.support => l10n.networkRoleSupport,
      MemberRole.therapist => l10n.networkRoleTherapist,
      MemberRole.veteran => l10n.networkRoleVeteran,
      MemberRole.unknown => '',
    };
    final color = switch (role) {
      MemberRole.support => AppColors.mossGreen,
      MemberRole.therapist => AppColors.dustyBlue,
      MemberRole.veteran => AppColors.warning,
      MemberRole.unknown => AppColors.softCharcoal,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
