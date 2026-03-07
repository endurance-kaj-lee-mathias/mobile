import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/emoji_image.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/pages/home/mood_picker.dart';
import 'package:flutter/material.dart';

class MoodTrendCard extends StatelessWidget {
  const MoodTrendCard({super.key});

  // Mock mood scores for Mon–Sun. null = not yet logged.
  static const _days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  static const _scores = [6, 7, 5, 8, 7, 9, null];

  @override
  Widget build(BuildContext context) {
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
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(_days.length, (i) {
                    final score = _scores[i];
                    return _DayBar(
                      label: _days[i],
                      score: score,
                      isToday: i == _days.length - 1,
                    );
                  }),
                ),
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
            color: isToday && score == null
                ? colorScheme.outlineVariant
                : barColor.withValues(alpha: isToday ? 1.0 : 0.75),
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
      ],
    );
  }
}
