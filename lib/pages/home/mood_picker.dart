import 'package:flutter/material.dart';

/// Emoji + gradient slider for selecting a mood score from 0 to 10.
class MoodPicker extends StatelessWidget {
  const MoodPicker({super.key, required this.score, required this.onChanged});

  final double score;
  final ValueChanged<double> onChanged;

  static const _emojis = [
    '😢',
    '😟',
    '😞',
    '😕',
    '😔',
    '😐',
    '🙂',
    '😊',
    '😄',
    '😁',
    '🤩',
  ];

  static String emojiForScore(int score) => _emojis[score.clamp(0, 10)];

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
    final dimColor = Theme.of(
      context,
    ).colorScheme.surface.withValues(alpha: 0.7);

    // Flutter's Slider adds 24 dp of internal padding on each side.
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
              color: color.withValues(alpha: 0.35),
              width: 1.5,
            ),
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

        // ── Gradient slider track ──
        LayoutBuilder(
          builder: (ctx, constraints) {
            final trackWidth = constraints.maxWidth - sliderPadding * 2;
            final fraction = (score / 10.0).clamp(0.0, 1.0);
            final activeWidth = (trackWidth * fraction).clamp(0.0, trackWidth);
            final inactiveWidth = (trackWidth - activeWidth).clamp(
              0.0,
              trackWidth,
            );

            return Stack(
              alignment: Alignment.center,
              children: [
                // Gradient bar — extends 16 px past each track end so edge
                // dots sit inside the rounded corners and the thumb looks
                // centred at 0/10.
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sliderPadding - 16),
                  child: Container(
                    height: 14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      gradient: const LinearGradient(colors: _gradientColors),
                    ),
                  ),
                ),

                // Dim overlay — covers the inactive (right) portion
                // including the 16 px extension beyond the track end.
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

                // Tick dots drawn at each of the 11 stop positions.
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: sliderPadding,
                  ),
                  child: CustomPaint(
                    size: Size(constraints.maxWidth - sliderPadding * 2, 14),
                    painter: _TickDotsPainter(count: 11, activeUpTo: fraction),
                  ),
                ),

                // Transparent-track Slider sits on top.
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

        // ── End labels ──
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

// ── Private helpers ───────────────────────────────────────────────────────────

class _ColoredThumbShape extends SliderComponentShape {
  const _ColoredThumbShape({required this.color});

  final Color color;
  static const double _radius = 16;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      const Size.fromRadius(_radius);

  @override
  void paint(
    PaintingContext context,
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

    // Soft colour glow
    canvas.drawCircle(
      center,
      _radius + 3,
      Paint()
        ..color = color.withValues(alpha: 0.25)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );

    // White ring
    canvas.drawCircle(center, _radius, Paint()..color = Colors.white);

    // Coloured fill (leaves a 3 px white border)
    canvas.drawCircle(center, _radius - 3, Paint()..color = color);
  }
}

class _TickDotsPainter extends CustomPainter {
  const _TickDotsPainter({required this.count, required this.activeUpTo});

  /// Number of tick positions (11 for 0..10).
  final int count;

  /// Fraction 0.0–1.0 indicating where the active portion ends.
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
