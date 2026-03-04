import 'package:flutter/material.dart';

/// Centralised color palette for the app.  Access these constants
/// wherever colours are needed instead of hard‑coding values.
class AppColors {
  AppColors._(); // avoid instantiation

  // Primary brand colour (used as seed for Material3 colour scheme).
  static const Color primary = Color(0xFF111416);

  // Backgrounds and surfaces.
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);

  // Text colours
  static const Color textPrimary = primary;
  static const Color textSecondary = Color(0xFF607589);
  static const Color textHint = Color(0xFF6B7582); // lighter grey used for hints
  static const Color backgroundLight = Color(0xFFF2F2F4);

  // Borders / dividers / grey tone.
  static const Color border = Color(0xFFDBE0E5);
  static const Color borderDark = Color(0xFF61758A);

  // Accent/highlight colours
  static const Color favorite = Color(0xFFE11D48);

  // A convenience alias. Many widgets used `Color.fromRGBO(255,255,255,1)`.
  static const Color white = background;
  static const Color black = primary;
}
