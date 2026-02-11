import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ButtonVariant { primary, secondary, danger }

enum ButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final backgroundColor = _getBackgroundColor(colorScheme);
    final foregroundColor = _getForegroundColor(colorScheme);

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: _getPadding(),
        textStyle: _getTextStyle(foregroundColor, textTheme),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: variant == ButtonVariant.primary ? 6 : 0,
      ),
      child: isLoading
          ? SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
        ),
      )
          : Text(
        text,
        style: _getTextStyle(foregroundColor, textTheme),
      ),
    );
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(vertical: 8, horizontal: 16);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(vertical: 14, horizontal: 24);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(vertical: 20, horizontal: 32);
    }
  }

  Color _getBackgroundColor(ColorScheme colorScheme) {
    switch (variant) {
      case ButtonVariant.primary:
        return colorScheme.primary;
      case ButtonVariant.secondary:
        return colorScheme.secondary;
      case ButtonVariant.danger:
        return colorScheme.error;
    }
  }

  Color _getForegroundColor(ColorScheme colorScheme) {
    switch (variant) {
      case ButtonVariant.primary:
        return colorScheme.onPrimary;
      case ButtonVariant.secondary:
        return colorScheme.onPrimary;
      case ButtonVariant.danger:
        return colorScheme.onError;
    }
  }

  TextStyle _getTextStyle(Color color, TextTheme textTheme) {
    return textTheme.labelLarge?.copyWith(color: color) ?? TextStyle(color: color);
  }
}
