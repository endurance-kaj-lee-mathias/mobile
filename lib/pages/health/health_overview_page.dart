import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/bordered_card.dart';
import 'package:endurance_mobile_app/components/emoji_image.dart';
import 'package:endurance_mobile_app/components/hero_icon.dart';
import 'package:endurance_mobile_app/components/section_header.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/pages/home/mood_picker.dart';
import 'package:endurance_mobile_app/services/health/health_overview_controller.dart';
import 'package:endurance_mobile_app/services/mood/mood_entry_model.dart';
import 'package:endurance_mobile_app/services/stress/stress_score_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HealthOverviewPage extends StatefulWidget {
  const HealthOverviewPage({super.key});

  @override
  State<HealthOverviewPage> createState() => _HealthOverviewPageState();
}

class _HealthOverviewPageState extends State<HealthOverviewPage> {
  late final HealthOverviewController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = Get.find<HealthOverviewController>();
    _ctrl.load();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.healthOverviewTitle), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _MoodSection(ctrl: _ctrl),
            const SizedBox(height: 32),
            _InsightsSection(ctrl: _ctrl),
          ],
        ),
      ),
    );
  }
}

class _MoodSection extends StatelessWidget {
  const _MoodSection({required this.ctrl});
  final HealthOverviewController ctrl;

  Future<void> _confirmDeleteEntry(BuildContext context, String entryId) async {
    final l10n = S.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(l10n.healthEntryDeleteTitle,
            style: const TextStyle(fontWeight: FontWeight.w700)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancelLabel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.healthEntryDeleteConfirm,
                style: const TextStyle(
                    color: AppColors.error, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      final ok = await ctrl.deleteEntry(entryId);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(ok ? l10n.healthMoodDeletedSuccess : l10n.healthDeleteError),
          backgroundColor: ok ? null : AppColors.error,
        ));
      }
    }
  }

  Future<void> _confirmDeleteAll(BuildContext context) async {
    final l10n = S.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(l10n.healthDeleteAllMoodTitle,
            style: const TextStyle(fontWeight: FontWeight.w700)),
        content: Text(l10n.healthDeleteAllMoodBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancelLabel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.healthDeleteAllMoodConfirm,
                style: const TextStyle(
                    color: AppColors.error, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      final ok = await ctrl.deleteAllMood();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(ok ? l10n.healthMoodAllDeletedSuccess : l10n.healthDeleteError),
          backgroundColor: ok ? null : AppColors.error,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(label: l10n.healthMoodSectionTitle),
          const SizedBox(height: 12),
          if (ctrl.isLoadingMood.value)
            const Center(child: CircularProgressIndicator())
          else if (ctrl.moodEntries.isEmpty)
            _EmptyCard(message: l10n.healthNoMoodEntries)
          else
            BorderedCard(
              child: Column(
                children: ctrl.moodEntries
                    .map((e) => _MoodEntryTile(
                          entry: e,
                          onDelete: () => _confirmDeleteEntry(context, e.id),
                        ))
                    .toList(),
              ),
            ),
          if (ctrl.hasMoreMoodEntries || ctrl.isLoadingMoreMood.value) ...[
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ctrl.isLoadingMoreMood.value
                  ? const Center(child: CircularProgressIndicator())
                  : OutlinedButton(
                      onPressed: ctrl.loadMoreMoodEntries,
                      child: const Text('Load older entries'),
                    ),
            ),
          ],
          const SizedBox(height: 8),
          _DeleteAllButton(
            label: l10n.healthDeleteAllMoodButton,
            onTap: () => _confirmDeleteAll(context),
          ),
        ],
      );
    });
  }
}

class _InsightsSection extends StatelessWidget {
  const _InsightsSection({required this.ctrl});
  final HealthOverviewController ctrl;

  Future<void> _confirmDeleteAll(BuildContext context) async {
    final l10n = S.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(l10n.healthDeleteStressTitle,
            style: const TextStyle(fontWeight: FontWeight.w700)),
        content: Text(l10n.healthDeleteStressBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancelLabel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.healthDeleteStressConfirm,
                style: const TextStyle(
                    color: AppColors.error, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      final ok = await ctrl.deleteAllStress();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(ok ? l10n.healthStressDeletedSuccess : l10n.healthDeleteError),
          backgroundColor: ok ? null : AppColors.error,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(label: l10n.healthInsightsSectionTitle),
          const SizedBox(height: 12),
          if (ctrl.isLoadingScores.value)
            const Center(child: CircularProgressIndicator())
          else if (ctrl.stressScores.isEmpty)
            _EmptyCard(
              message: l10n.healthNoInsights,
              body: l10n.healthNoInsightsBody,
            )
          else
            BorderedCard(
              child: Column(
                children: ctrl.stressScores
                    .map((s) => _StressScoreTile(score: s))
                    .toList(),
              ),
            ),
          const SizedBox(height: 8),
          _DeleteAllButton(
            label: l10n.healthDeleteStressButton,
            onTap: () => _confirmDeleteAll(context),
            color: AppColors.error,
          ),
        ],
      );
    });
  }
}

class _MoodEntryTile extends StatelessWidget {
  const _MoodEntryTile({required this.entry, required this.onDelete});
  final MoodEntryModel entry;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final subtitle = entry.notes != null && entry.notes!.isNotEmpty
        ? '${entry.date}\n${entry.notes}'
        : entry.date;
    return ListTile(
      leading: EmojiImage(MoodPicker.emojiForScore(entry.moodScore), size: 32),
      title: Text(
        '${entry.moodScore}/10',
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: Text(subtitle),
      trailing: IconButton(
        icon: const HeroIcon(HeroIcons.trash, size: 20, color: AppColors.error),
        onPressed: onDelete,
      ),
    );
  }
}

class _StressScoreTile extends StatelessWidget {
  const _StressScoreTile({required this.score});
  final StressScoreModel score;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return ListTile(
      title: Text(l10n.healthStressScoreLabel(score.score.toStringAsFixed(2))),
      subtitle: Text(l10n.healthStressComputedAt(
          DateFormat.yMMMd().format(score.computedAt.toLocal()))),
      trailing: _CategoryChip(category: score.category),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.category});
  final String category;

  String _label(S l10n) => switch (category) {
        'low' => l10n.healthCategoryLow,
        'moderate' => l10n.healthCategoryModerate,
        'high' => l10n.healthCategoryHigh,
        'very_high' => l10n.healthCategoryVeryHigh,
        _ => category,
      };

  Color _color() => switch (category) {
        'low' => AppColors.mossGreen,
        'moderate' => AppColors.warning,
        'high' => Colors.orange,
        'very_high' => AppColors.error,
        _ => Colors.grey,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final color = _color();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _label(l10n),
        style: TextStyle(
            color: color, fontWeight: FontWeight.w700, fontSize: 12),
      ),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.message, this.body});
  final String message;
  final String? body;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return BorderedCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message,
                style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface.withValues(alpha: 0.6))),
            if (body != null) ...[
              const SizedBox(height: 6),
              Text(body!,
                  style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.5))),
            ],
          ],
        ),
      ),
    );
  }
}

class _DeleteAllButton extends StatelessWidget {
  const _DeleteAllButton({
    required this.label,
    required this.onTap,
    this.color,
  });
  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Theme.of(context).colorScheme.onSurface;
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: effectiveColor,
          side: BorderSide(color: effectiveColor.withValues(alpha: 0.5)),
        ),
        child: Text(label),
      ),
    );
  }
}
