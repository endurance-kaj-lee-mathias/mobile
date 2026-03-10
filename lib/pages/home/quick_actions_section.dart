import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/hero_icon.dart';
import 'package:endurance_mobile_app/components/section_header.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(label: l10n.quickActionsSectionTitle),
        const SizedBox(height: 12),
        IntrinsicHeight(
          child: Row(
            children: [
              _ActionTile(
                icon: Icons.phone_in_talk_rounded,
                heroIcon: null,
                label: l10n.quickActionsCrisisLine,
                color: AppColors.warning,
              ),
              const SizedBox(width: 10),
              _ActionTile(
                icon: null,
                heroIcon: HeroIcons.chatOutline,
                label: l10n.quickActionsMessageBuddy,
                color: AppColors.mossGreen,
              ),
              const SizedBox(width: 10),
              _ActionTile(
                icon: null,
                heroIcon: HeroIcons.userGroupOutline,
                label: l10n.quickActionsFindTherapist,
                color: AppColors.dustyBlue,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData? icon;
  final String? heroIcon;
  final String label;
  final Color color;

  const _ActionTile({
    required this.icon,
    required this.heroIcon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: color.withValues(alpha: 0.35), width: 1.5),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: heroIcon != null
                        ? HeroIcon(heroIcon!, size: 22, color: color)
                        : Icon(icon, size: 22, color: color),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
