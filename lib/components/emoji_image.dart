import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Renders a single emoji as a bundled Twemoji SVG asset.
///
/// Assets must exist at `assets/emoji/<codepoint>.svg`.
/// Download them from: https://cdn.jsdelivr.net/gh/twitter/twemoji@14.0.2/assets/svg/
class EmojiImage extends StatelessWidget {
  const EmojiImage(this.emoji, {super.key, required this.size});

  final String emoji;
  final double size;

  String get _assetPath {
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
