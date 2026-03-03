import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/services/mood/daily_checkin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            l10n.homeWelcome,
            style: Theme
                .of(context)
                .textTheme
                .bodyLarge,
          ),
          const SizedBox(height: 16),
          const _DailyCheckInCard(),
        ],
      ),
    );
  }
}

class _DailyCheckInCard extends StatelessWidget {
  const _DailyCheckInCard();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DailyCheckInController>();
    final l10n = S.of(context);
    final colorScheme = Theme
        .of(context)
        .colorScheme;

    return Obx(() {
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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (done && score != null) ...[
                Row(
                  children: [
                    Text(
                      _MoodPicker.emojiForScore(score),
                      style: const TextStyle(fontSize: 28),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.dailyCheckInDoneSubtitle(score),
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                        color: _MoodPicker.colorForScore(score.toDouble()),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ] else
                Text(
                  done ? l10n.dailyCheckInDone : l10n.dailyCheckInPending,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium,
                ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: done
                    ? OutlinedButton(
                  onPressed: () => _showCheckInSheet(context),
                  child: Text(l10n.dailyCheckInUpdateButton),
                )
                    : ElevatedButton(
                  onPressed: () => _showCheckInSheet(context),
                  child: Text(l10n.dailyCheckInButton),
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _CheckInBottomSheet(parentMessenger: messenger),
    );
  }
}

class _CheckInBottomSheet extends StatefulWidget {
  const _CheckInBottomSheet({required this.parentMessenger});

  final ScaffoldMessengerState parentMessenger;

  @override
  State<_CheckInBottomSheet> createState() => _CheckInBottomSheetState();
}

class _CheckInBottomSheetState extends State<_CheckInBottomSheet> {
  double _moodScore = 5;
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final controller = Get.find<DailyCheckInController>();
    if (controller.todayScore.value != null) {
      _moodScore = controller.todayScore.value!.toDouble();
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final controller = Get.find<DailyCheckInController>();

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery
            .of(context)
            .viewInsets
            .bottom + 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .colorScheme
                    .outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            l10n.dailyCheckInTitle,
            style: Theme
                .of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 24),

          // Mood picker
          _MoodPicker(
            score: _moodScore,
            onChanged: (v) => setState(() => _moodScore = v),
          ),
          const SizedBox(height: 16),

          // Notes
          Text(
            l10n.notesLabel,
            style: Theme
                .of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _notesController,
            maxLength: 500,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: l10n.notesHint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Health permission inline prompt
          Obx(() {
            if (controller.hasHealthPermission.value) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.watch_rounded,
                      size: 16,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Health data will be included',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                  ],
                ),
              );
            }
            // Prompt to grant health access
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.watch_rounded, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      l10n.healthPermissionBody,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () async {
                      await controller.requestHealthPermission();
                    },
                    child: Text(l10n.healthPermissionGrant),
                  ),
                ],
              ),
            );
          }),

          // Submit / cancel
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.cancelLabel),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Obx(() {
                  final submitting = controller.isSubmitting.value;
                  return ElevatedButton(
                    onPressed: submitting ? null : () => _submit(context),
                    child: submitting
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : Text(l10n.submitLabel),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    final l10n = S.of(context);
    final controller = Get.find<DailyCheckInController>();
    final notes = _notesController.text.trim();

    final ok = await controller.submit(
      moodScore: _moodScore.round(),
      notes: notes.isEmpty ? null : notes,
    );

    if (!context.mounted) return;

    Navigator.of(context).pop();
    widget.parentMessenger.showSnackBar(
      SnackBar(
        content: Text(ok ? l10n.checkInSuccess : l10n.checkInError),
        backgroundColor:
        ok ? AppColors.success : Theme
            .of(context)
            .colorScheme
            .error,
      ),
    );
  }
}

// ── Mood picker ───────────────────────────────────────────────────────────────

class _MoodPicker extends StatelessWidget {
  const _MoodPicker({required this.score, required this.onChanged});

  final double score;
  final ValueChanged<double> onChanged;

  static const _emojis = [
    '😢', '😟', '😞', '😕', '😔', '😐', '🙂', '😊', '😄', '😁', '🤩',
  ];

  static String emojiForScore(int score) =>
      _emojis[score.clamp(0, 10)];

  static const _gradientColors = [
    Color(0xFFE53E3E),
    Color(0xFFED8936),
    Color(0xFFECC94B),
    Color(0xFF9AE6B4),
    Color(0xFF38A169),
  ];

  static Color colorForScore(double score) {
    final t = (score / 10.0).clamp(0.0, 1.0);
    if (t <= 0.5) {
      return Color.lerp(
        const Color(0xFFE53E3E),
        const Color(0xFFECC94B),
        t * 2,
      )!;
    }
    return Color.lerp(
      const Color(0xFFECC94B),
      const Color(0xFF38A169),
      (t - 0.5) * 2,
    )!;
  }

  @override
  Widget build(BuildContext context) {
    final color = colorForScore(score);
    final emoji = _emojis[score.round().clamp(0, 10)];
    // Surface color used to dim the inactive (right) portion of the track
    final dimColor =
    Theme
        .of(context)
        .colorScheme
        .surface
        .withValues(alpha: 0.7);

    // Flutter's Slider adds 24dp of internal padding on each side
    const sliderPadding = 24.0;

    return Column(
      children: [
        // ── Emoji display card ──
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: color.withValues(alpha: 0.35), width: 1.5),
          ),
          child: Column(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 56)),
              const SizedBox(height: 6),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
                child: Text('${score.round()} / 10'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // ── Slider with gradient track ──
        LayoutBuilder(
          builder: (ctx, constraints) {
            final trackWidth = constraints.maxWidth - sliderPadding * 2;
            final fraction = (score / 10.0).clamp(0.0, 1.0);
            final activeWidth = (trackWidth * fraction).clamp(0.0, trackWidth);
            final inactiveWidth = (trackWidth - activeWidth).clamp(
                0.0, trackWidth);

            return Stack(
              alignment: Alignment.center,
              children: [
                // Full gradient bar — extends 16px past each track end so
                // edge dots aren't clipped and thumb looks centered at 0/10
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: sliderPadding - 16,
                  ),
                  child: Container(
                    height: 14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      gradient: const LinearGradient(
                        colors: _gradientColors,
                      ),
                    ),
                  ),
                ),

                // Dim overlay on the inactive (right) portion
                if (fraction < 1.0)
                  Positioned(
                    right: sliderPadding - 16,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(7),
                      ),
                      child: Container(
                        width: inactiveWidth + 16,
                        height: 14,
                        color: dimColor,
                      ),
                    ),
                  ),

                // Tick dots at each stop position
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: sliderPadding,
                  ),
                  child: CustomPaint(
                    size: Size(
                      constraints.maxWidth - sliderPadding * 2,
                      14,
                    ),
                    painter: _TickDotsPainter(
                      count: 11,
                      activeUpTo: fraction,
                    ),
                  ),
                ),

                // The actual Slider — transparent track so gradient shows through
                SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 14,
                    activeTrackColor: Colors.transparent,
                    inactiveTrackColor: Colors.transparent,
                    overlayColor: color.withValues(alpha: 0.18),
                    thumbShape: _ColoredThumbShape(color: color),
                    tickMarkShape: SliderTickMarkShape.noTickMark,
                  ),
                  child: Slider(
                    value: score,
                    min: 0,
                    max: 10,
                    divisions: 10,
                    onChanged: onChanged,
                  ),
                ),
              ],
            );
          },
        ),

        // End labels
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('😢', style: TextStyle(fontSize: 18)),
              Text('😐', style: TextStyle(fontSize: 18)),
              Text('🤩', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ],
    );
  }
}

class _ColoredThumbShape extends SliderComponentShape {
  const _ColoredThumbShape({required this.color});

  final Color color;
  static const double _radius = 16;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      const Size.fromRadius(_radius);

  @override
  void paint(PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final canvas = context.canvas;

    // Outer glow / shadow
    canvas.drawCircle(
      center,
      _radius + 3,
      Paint()
        ..color = color.withValues(alpha: 0.25)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );

    // White ring
    canvas.drawCircle(center, _radius, Paint()
      ..color = Colors.white);

    // Colored fill (leaves a 3px white border)
    canvas.drawCircle(center, _radius - 3, Paint()
      ..color = color);
  }
}

class _TickDotsPainter extends CustomPainter {
  const _TickDotsPainter({required this.count, required this.activeUpTo});

  /// Number of tick positions (11 for 0..10).
  final int count;

  /// Fraction 0.0–1.0 indicating how far the active portion extends.
  final double activeUpTo;

  @override
  void paint(Canvas canvas, Size size) {
    const dotRadius = 2.5;
    final centerY = size.height / 2;

    for (int i = 0; i < count; i++) {
      final x = size.width * i / (count - 1);
      final isActive = (i / (count - 1)) <= activeUpTo;

      canvas.drawCircle(
        Offset(x, centerY),
        dotRadius,
        Paint()
          ..color = isActive
              ? Colors.white.withValues(alpha: 0.95)
              : Colors.white.withValues(alpha: 0.7),
      );
    }
  }

  @override
  bool shouldRepaint(_TickDotsPainter old) => old.activeUpTo != activeUpTo;
}

