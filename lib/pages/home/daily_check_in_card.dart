import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/emoji_image.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/pages/home/check_in_bottom_sheet.dart';
import 'package:endurance_mobile_app/pages/home/mood_picker.dart';
import 'package:endurance_mobile_app/services/mood/daily_checkin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Card shown on the home screen indicating whether today's check-in is done.
class DailyCheckInCard extends StatelessWidget {
  const DailyCheckInCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DailyCheckInController>();
    final l10n = S.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Obx(() {
      final loading = controller.isLoadingStatus.value;
      final done = controller.hasDoneToday.value;
      final score = controller.todayScore.value;

      return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: done ? AppColors.success : colorScheme.outlineVariant,
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            // When the button is hidden (done or loading) use the same 20dp
            // as the top so the card feels balanced.  When the button is
            // visible the button's own bottom padding provides enough room.
            (!done || loading) ? 20 : 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row with status icon and title
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
                  else
                    Icon(
                      done
                          ? Icons.check_circle_rounded
                          : Icons.radio_button_unchecked_rounded,
                      color: done ? AppColors.success : colorScheme.outline,
                      size: 22,
                    ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.dailyCheckInTitle,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Status / score display
              if (done && score != null) ...[
                Row(
                  children: [
                    EmojiImage(
                      MoodPicker.emojiForScore(score),
                      size: 28,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.dailyCheckInDoneSubtitle(score),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: MoodPicker.colorForScore(score.toDouble()),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ] else
                Text(
                  done ? l10n.dailyCheckInDone : l10n.dailyCheckInPending,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

              // Action button — only shown when the check-in hasn't been done yet.
              if (!done && !loading) ...[
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _showCheckInSheet(context),
                    child: Text(l10n.dailyCheckInButton),
                  ),
                ),
              ],
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
}
