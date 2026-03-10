import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/emoji_image.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/pages/home/mood_picker.dart';
import 'package:endurance_mobile_app/services/mood/daily_checkin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MoodTrendCard extends StatelessWidget {
  const MoodTrendCard({super.key});

  static const _weekDayLetters = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DailyCheckInController>();
    final l10n = S.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.moodTrendSectionTitle,
          style: textTheme.labelMedium?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.5),
            letterSpacing: 1.2,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: colorScheme.outlineVariant, width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.show_chart_rounded,
                      size: 20,
                      color: AppColors.mossGreen,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.moodOverviewTitle,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Obx(() {
                      if (controller.isLoadingHistory.value) {
                        return SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                            color: colorScheme.outline,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                  ],
                ),
                const SizedBox(height: 20),
                Obx(() {
                  final entries = controller.weekEntries;
                  final today = DateTime.now();
                  final todayDate = DateTime(today.year, today.month, today.day);
                  final fmt = DateFormat('yyyy-MM-dd');

                  // Build a lookup from date string to entry.
                  final byDate = {for (final e in entries) e.date: e};

                  // 7 slots: index 0 = 6 days ago, index 6 = today.
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(7, (i) {
                      final day = todayDate.subtract(Duration(days: 6 - i));
                      final entry = byDate[fmt.format(day)];
                      return _DayBar(
                        label: _weekDayLetters[day.weekday - 1],
                        score: entry?.moodScore,
                        isToday: i == 6,
                      );
                    }),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DayBar extends StatelessWidget {
  final String label;
  final int? score;
  final bool isToday;

  const _DayBar({
    required this.label,
    required this.score,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    const maxHeight = 56.0;
    const minHeight = 8.0;

    final barHeight = score != null
        ? minHeight + (maxHeight - minHeight) * (score! / 10.0)
        : minHeight;
    final barColor = score != null
        ? MoodPicker.colorForScore(score!.toDouble())
        : colorScheme.outlineVariant;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (score != null)
          EmojiImage(MoodPicker.emojiForScore(score!), size: 14)
        else
          const SizedBox(height: 20),
        const SizedBox(height: 4),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 28,
          height: barHeight,
          decoration: BoxDecoration(
            color: barColor.withValues(alpha: isToday ? 1.0 : 0.75),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: textTheme.bodyMedium?.copyWith(
            fontSize: 11,
            fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
            color: isToday
                ? colorScheme.onSurface
                : colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          score != null ? '$score' : '–',
          style: textTheme.bodyMedium?.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: score != null
                ? MoodPicker.colorForScore(score!.toDouble())
                    .withValues(alpha: isToday ? 1.0 : 0.8)
                : colorScheme.onSurface.withValues(alpha: 0.25),
          ),
        ),
      ],
    );
  }
}
