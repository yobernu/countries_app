import 'package:flutter/material.dart';

/// Centralised color palette for the app.  Access these constants
/// wherever colours are needed instead of hard‑coding values.
class AppColors {
  AppColors._(); // avoid instantiation

  // Primary brand colour (used as seed for Material3 colour scheme).
  static const Color primary = Color(0xFF111416);

  // Light theme colors
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = primary;
  static const Color lightTextSecondary = Color(0xFF607589);
  static const Color lightTextHint = Color(0xFF6B7582);
  static const Color lightBackgroundLight = Color(0xFFF2F2F4);
  static const Color lightBorder = Color(0xFFDBE0E5);
  static const Color lightBorderDark = Color(0xFF61758A);

  // Dark theme colors
  static const Color darkBackground = Color(0xFF000000);
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  static const Color darkTextHint = Color(0xFF808080);
  static const Color darkBackgroundLight = Color(0xFF2A2A2A);
  static const Color darkBorder = Color(0xFF404040);
  static const Color darkBorderDark = Color(0xFF606060);

  // Accent/highlight colours (theme-independent)
  static const Color favorite = Color(0xFFE11D48);

  // Convenience getters based on theme
  static Color getBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBackground
        : lightBackground;
  }

  static Color getSurface(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkSurface
        : lightSurface;
  }

  static Color getTextPrimary(BuildContext context, [FontWeight weight = FontWeight.normal]) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextPrimary
        : lightTextPrimary;
  }

  static Color getTextSecondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextSecondary
        : lightTextSecondary;
  }

  static Color getTextHint(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextHint
        : lightTextHint;
  }

  static Color getBackgroundLight(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBackgroundLight
        : lightBackgroundLight;
  }

  static Color getBorder(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBorder
        : lightBorder;
  }

  static Color getBorderDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBorderDark
        : lightBorderDark;
  }

  // Legacy aliases for backward compatibility
  static const Color background = lightBackground;
  static const Color surface = lightSurface;
  static const Color textPrimary = lightTextPrimary;
  static const Color textSecondary = lightTextSecondary;
  static const Color textHint = lightTextHint;
  static const Color backgroundLight = lightBackgroundLight;
  static const Color border = lightBorder;
  static const Color borderDark = lightBorderDark;
  static const Color white = lightBackground;
  static const Color black = primary;
}
