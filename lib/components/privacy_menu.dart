import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/hero_icon.dart';
import 'package:endurance_mobile_app/components/user_avatar.dart';
import 'package:endurance_mobile_app/services/network/member_model.dart';
import 'package:flutter/material.dart';

class PrivacyMenu extends StatelessWidget {
  final MemberModel member;
  final VoidCallback onPrivacyPressed;
  final VoidCallback onRemovePressed;

  const PrivacyMenu({
    super.key,
    required this.member,
    required this.onPrivacyPressed,
    required this.onRemovePressed,
  });

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                UserAvatar(
                  imageUrl: member.image,
                  firstName: member.firstName,
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member.displayName,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '@${member.username}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const HeroIcon(HeroIcons.shieldOutline, size: 24),
              title: const Text('Privacy settings'),
              subtitle: const Text('Control what this person can see'),
              contentPadding: EdgeInsets.zero,
              onTap: () {
                Navigator.pop(ctx);
                onPrivacyPressed();
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const HeroIcon(HeroIcons.userMinus,
                  size: 24, color: AppColors.error),
              title: const Text(
                'Remove',
                style: TextStyle(color: AppColors.error),
              ),
              subtitle: const Text(
                'Remove from your network',
                style: TextStyle(color: AppColors.error),
              ),
              contentPadding: EdgeInsets.zero,
              onTap: () {
                Navigator.pop(ctx);
                onRemovePressed();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const HeroIcon(HeroIcons.ellipsisCircle),
      color: AppColors.mossGreen,
      onPressed: () => _showMenu(context),
    );
  }
}
