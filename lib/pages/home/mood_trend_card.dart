import 'package:endurance_mobile_app/components/hero_icon.dart';
import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/bordered_card.dart';
import 'package:endurance_mobile_app/components/emoji_image.dart';
import 'package:endurance_mobile_app/components/section_header.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/pages/home/mood_picker.dart';
import 'package:endurance_mobile_app/services/mood/daily_checkin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MoodTrendCard extends StatelessWidget {
  const MoodTrendCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DailyCheckInController>();
    final l10n = S.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(label: l10n.moodTrendSectionTitle),
        const SizedBox(height: 12),
        BorderedCard(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const HeroIcon(
                      HeroIcons.chartLine,
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
                      if (controller.isLoading.value) {
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

                  final byDate = <String, List<int>>{};
                  for (final e in entries) {
                    byDate.putIfAbsent(e.date, () => []).add(e.moodScore);
                  }

                  final locale = Localizations.localeOf(context).toString();
                  final dayFmt = DateFormat('EEEEE', locale);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(7, (i) {
                      final day = todayDate.subtract(Duration(days: 6 - i));
                      final scores = byDate[fmt.format(day)];
                      final avg = scores != null && scores.isNotEmpty
                          ? scores.fold<int>(0, (a, b) => a + b) /
                              scores.length
                          : null;
                      return _DayBar(
                        label: dayFmt.format(day),
                        avgScore: avg,
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
  final double? avgScore;
  final bool isToday;

  const _DayBar({
    required this.label,
    required this.avgScore,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    const maxHeight = 56.0;
    const minHeight = 8.0;

    final barHeight = avgScore != null
        ? minHeight + (maxHeight - minHeight) * (avgScore! / 10.0)
        : minHeight;
    final scoreInt = avgScore?.round();
    final barColor = scoreInt != null
        ? MoodPicker.colorForScore(avgScore!)
        : colorScheme.outlineVariant;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (scoreInt != null)
          EmojiImage(MoodPicker.emojiForScore(scoreInt), size: 14)
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
          avgScore != null ? _formatAvg(avgScore!) : '–',
          style: textTheme.bodyMedium?.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: scoreInt != null
                ? MoodPicker.colorForScore(avgScore!)
                    .withValues(alpha: isToday ? 1.0 : 0.8)
                : colorScheme.onSurface.withValues(alpha: 0.25),
          ),
        ),
      ],
    );
  }

  static String _formatAvg(double avg) {
    if (avg == avg.roundToDouble()) return avg.round().toString();
    return avg.toStringAsFixed(1);
  }
}
