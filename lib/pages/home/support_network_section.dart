import 'package:endurance_mobile_app/components/hero_icon.dart';
import 'package:endurance_mobile_app/app/router.dart';
import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/section_header.dart';
import 'package:endurance_mobile_app/components/user_avatar.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/services/network/member_model.dart';
import 'package:endurance_mobile_app/services/network/network_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SupportNetworkSection extends StatelessWidget {
  const SupportNetworkSection({super.key});

  static const _maxVisible = 10;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final controller = Get.find<NetworkController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(label: l10n.supportNetworkSectionTitle),
        const SizedBox(height: 12),
        Obx(() {
          final members = controller.members;
          final visible = members.take(_maxVisible).toList();
          final overflow = members.length - _maxVisible;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...visible.map((m) => _MemberAvatar(member: m)),
                _ViewAllAvatar(
                  overflow: overflow > 0 ? overflow : null,
                  onTap: () => context.goNamed(AppRoutes.network),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class _MemberAvatar extends StatelessWidget {
  final MemberModel member;

  const _MemberAvatar({required this.member});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final name = member.displayName.isNotEmpty
        ? member.displayName
        : member.username;

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          UserAvatar(
            imageUrl: member.image,
            firstName: member.firstName,
            radius: 28,
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 56,
            child: Text(
              name,
              style: textTheme.bodyMedium?.copyWith(fontSize: 11),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _ViewAllAvatar extends StatelessWidget {
  final int? overflow;
  final VoidCallback onTap;

  const _ViewAllAvatar({required this.overflow, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.paleSage.withValues(alpha: 0.4),
            child: overflow != null
                ? Text(
                    '+$overflow',
                    style: const TextStyle(
                      color: AppColors.mossGreen,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  )
                : const HeroIcon(
                    HeroIcons.userGroupOutline,
                    color: AppColors.mossGreen,
                    size: 26,
                  ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 56,
            child: Text(
              S.of(context).supportNetworkMore,
              style: textTheme.bodyMedium?.copyWith(fontSize: 11),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
