import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

/// Holds theme data for the application.  Currently only a light theme is
/// defined but additional variants (dark, high contrast) could be added later.
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        background: AppColors.background,
        surface: AppColors.surface,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.background,
      useMaterial3: true,
      textTheme: GoogleFonts.plusJakartaSansTextTheme().apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    );

    // further customisation can be layered on base if desired
    return base.copyWith(
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: AppTextStyles.body.copyWith(color: AppColors.textHint),
        filled: true,
        fillColor: AppColors.backgroundLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      iconTheme: IconThemeData(color: AppColors.darkBackground),
      // example: override elevated button style etc
    );
  }

  static ThemeData get dark {
    final base = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        background: AppColors.darkBackground,
        surface: AppColors.darkSurface,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: AppColors.darkBackground,
      useMaterial3: true,
      textTheme: GoogleFonts.plusJakartaSansTextTheme().apply(
        bodyColor: AppColors.darkTextPrimary,
        displayColor: AppColors.darkTextPrimary,
      ),
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    );

    return base.copyWith(
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: AppTextStyles.body.copyWith(color: AppColors.darkTextHint),
        filled: true,
        fillColor: AppColors.darkBackgroundLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      iconTheme: IconThemeData(color: AppColors.darkTextSecondary),
    );
  }
}
