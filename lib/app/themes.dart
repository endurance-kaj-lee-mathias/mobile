import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Brand
  static const mossGreen = Color(0xFF5F7F6E);
  static const paleSage = Color(0xFFB7C9C1);
  static const dustyBlue = Color(0xFF8FA3B0);
  static const softCharcoal = Color(0xFF3A3A3A);

  // Light mode
  static const lightBackground = Color(0xFFFAF9F6);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightTextPrimary = softCharcoal;
  static const lightTextSecondary = Color(0xFF6B7B74);
  static const lightDivider = Color(0xFFE2E6E3);

  // Dark mode
  static const darkBackground = Color(0xFF121917);
  static const darkSurface = Color(0xFF1D2A24);
  static const darkTextPrimary = Color(0xFFE6ECE9);
  static const darkTextSecondary = Color(0xFF9FB6AC);
  static const darkDivider = Color(0xFF2B3A33);

  // Status
  static const success = Color(0xFF5F8F75);
  static const info = Color(0xFF6F8FA3);
  static const warning = Color(0xFFD6B26E);
  static const error = Color(0xFF8C4A4A);
}

class AppStyles {
  static const buttonRadius = 12.0;
  static const buttonPadding = EdgeInsets.symmetric(
    vertical: 14,
    horizontal: 24,
  );
}

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      fontFamily: GoogleFonts.nunito().fontFamily,

      colorScheme: const ColorScheme.light(
        primary: AppColors.mossGreen,
        secondary: AppColors.paleSage,
        surface: AppColors.lightSurface,
        error: AppColors.error,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        titleTextStyle: GoogleFonts.nunito(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.lightTextPrimary,
        ),
      ),

      textTheme: TextTheme(
        bodyLarge: GoogleFonts.nunito(color: AppColors.lightTextPrimary),
        bodyMedium: GoogleFonts.nunito(color: AppColors.lightTextSecondary),
      ),

      dividerColor: AppColors.lightDivider,

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mossGreen,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppStyles.buttonRadius),
          ),
          padding: AppStyles.buttonPadding,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.mossGreen, // text color
          side: const BorderSide(color: AppColors.mossGreen, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppStyles.buttonRadius),
          ),
          padding: AppStyles.buttonPadding,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.mossGreen,
          textStyle: GoogleFonts.nunito(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      fontFamily: GoogleFonts.nunito().fontFamily,

      colorScheme: const ColorScheme.dark(
        primary: AppColors.mossGreen,
        secondary: AppColors.paleSage,
        surface: AppColors.darkSurface,
        error: AppColors.error,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        titleTextStyle: GoogleFonts.nunito(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTextPrimary,
        ),
      ),

      textTheme: TextTheme(
        bodyLarge: GoogleFonts.nunito(color: AppColors.darkTextPrimary),
        bodyMedium: GoogleFonts.nunito(color: AppColors.darkTextSecondary),
      ),

      dividerColor: AppColors.darkDivider,

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.mossGreen,
          side: const BorderSide(color: AppColors.mossGreen, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppStyles.buttonRadius),
          ),
          padding: AppStyles.buttonPadding,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.mossGreen,
          textStyle: GoogleFonts.nunito(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
