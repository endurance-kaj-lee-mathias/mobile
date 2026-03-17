import 'package:endurance_mobile_app/app/router.dart';
import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/hero_icon.dart';
import 'package:endurance_mobile_app/components/section_header.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                heroIcon: HeroIcons.phone,
                label: l10n.quickActionsCrisisLine,
                color: AppColors.warning,
                onTap: null, // crisis line not yet implemented
              ),
              const SizedBox(width: 10),
              _ActionTile(
                heroIcon: HeroIcons.chatOutline,
                label: l10n.quickActionsMessageBuddy,
                color: AppColors.mossGreen,
                onTap: () => context.goNamed(AppRoutes.chats),
              ),
              const SizedBox(width: 10),
              _ActionTile(
                heroIcon: HeroIcons.calendarDays,
                label: l10n.quickActionsBookSession,
                color: AppColors.dustyBlue,
                onTap: () => context.goNamed(AppRoutes.agenda),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  final String heroIcon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _ActionTile({
    required this.heroIcon,
    required this.label,
    required this.color,
    required this.onTap,
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
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: onTap != null ? 0.12 : 0.06),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: HeroIcon(
                      heroIcon,
                      size: 22,
                      color: color.withValues(alpha: onTap != null ? 1.0 : 0.4),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                    color: onTap != null
                        ? null
                        : Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.35),
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
