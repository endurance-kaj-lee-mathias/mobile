import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Renders a single emoji as a bundled Twemoji SVG asset.
///
/// Named assets are looked up via [_namedAssets]. Any emoji not in the map
/// falls back to the standard codepoint filename convention used by Twemoji
/// (`assets/emoji/<hex-codepoint>.svg`).
class EmojiImage extends StatelessWidget {
  const EmojiImage(this.emoji, {super.key, required this.size});

  final String emoji;
  final double size;

  // Maps each app emoji to its human-readable asset filename.
  static const Map<String, String> _namedAssets = {
    '😢': 'crying-face',
    '😟': 'worried-face',
    '😞': 'disappointed-face',
    '😕': 'confused-face',
    '😔': 'pensive-face',
    '😐': 'neutral-face',
    '🙂': 'slightly-smiling-face',
    '😊': 'smiling-face',
    '😄': 'grinning-face',
    '😁': 'beaming-face',
    '🤩': 'star-struck',
  };

  String get _assetPath {
    final named = _namedAssets[emoji];
    if (named != null) return 'assets/emoji/$named.svg';
    // Fallback: use the Unicode codepoint hex (standard Twemoji filename).
    final codepoint = emoji.runes.first.toRadixString(16).toLowerCase();
    return 'assets/emoji/$codepoint.svg';
  }

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      _assetPath,
      width: size,
      height: size,
    );
  }
}
