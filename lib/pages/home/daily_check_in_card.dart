import 'package:endurance_mobile_app/components/hero_icon.dart';
import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/bordered_card.dart';
import 'package:endurance_mobile_app/components/emoji_image.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/pages/home/check_in_bottom_sheet.dart';
import 'package:endurance_mobile_app/pages/home/mood_picker.dart';
import 'package:endurance_mobile_app/services/mood/daily_checkin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Card shown on the home screen for the daily mood check-in.
/// Multiple check-ins per day are allowed; the card always shows the button.
class DailyCheckInCard extends StatelessWidget {
  const DailyCheckInCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DailyCheckInController>();
    final l10n = S.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Obx(() {
      final loading = controller.isLoading.value;
      controller.clockTick.value;
      final done = controller.hasDoneToday;
      final last = controller.lastTodayEntry;
      final avg = controller.avgTodayScore;
      final count = controller.todayEntries.length;

      return BorderedCard(
        borderColor: done ? AppColors.success : colorScheme.outlineVariant,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (loading)
                    SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colorScheme.outline,
                      ),
                    )
                  else if (done)
                    const HeroIcon(HeroIcons.checkCircle, size: 22, color: AppColors.success)
                  else
                    HeroIcon(HeroIcons.ellipsisCircle, size: 22, color: colorScheme.outline),                  const SizedBox(width: 8),
                  Text(
                    l10n.dailyCheckInTitle,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              if (!loading && done && last != null) ...[
                Row(
                  children: [
                    EmojiImage(MoodPicker.emojiForScore(last.moodScore), size: 24),
                    const SizedBox(width: 6),
                    Text(
                      l10n.checkInScoreLabel(last.moodScore),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: MoodPicker.colorForScore(last.moodScore.toDouble()),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (last.createdAt != null) ...[
                      Text(
                        '  ·  ',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.4),
                        ),
                      ),
                      Text(
                        _formatTimeAgo(context, last.createdAt!),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ],
                ),
                if (count > 1 && avg != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    l10n.checkInAvgToday(_formatAvg(avg)),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.55),
                    ),
                  ),
                ],
              ] else if (!loading)
                Text(
                  l10n.dailyCheckInPending,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: loading ? null : () => _showCheckInSheet(context),
                  child: Text(
                    done ? l10n.checkInAddButton : l10n.dailyCheckInButton,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _showCheckInSheet(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => CheckInBottomSheet(parentMessenger: messenger),
    );
  }

  static String _formatTimeAgo(BuildContext context, DateTime createdAt) {
    final l10n = S.of(context);
    final diff = DateTime.now().difference(createdAt);
    if (diff.inHours >= 1) return l10n.checkInTimeAgoHours(diff.inHours);
    return l10n.checkInTimeAgoMinutes(diff.inMinutes.clamp(1, 59));
  }

  static String _formatAvg(double avg) {
    if (avg == avg.roundToDouble()) return avg.round().toString();
    return avg.toStringAsFixed(1);
  }
}
