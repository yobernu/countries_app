import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Font family names used throughout the application.
///
/// `Plus Jakarta Sans` is loaded dynamically via google_fonts, while
/// `Inconsolata` is bundled as an asset (see pubspec.yaml).
class AppFonts {
  AppFonts._();

  static const String primary = 'Plus Jakarta Sans';
  static const String monospace = 'Inconsolata';
}

/// Shared text styles using the chosen font(s) and colour palette.
///
/// Widgets should either consume these directly or rely on the
/// [ThemeData.textTheme] defined in [AppTheme].  Overriding the
/// font family in individual widgets is no longer necessary.
class AppTextStyles {
  AppTextStyles._();

  static final TextStyle title = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    // color omitted so the current [Theme] controls text color (supports dark mode)
    height: 1.5,
  );

  static final TextStyle subtitle = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    height: 1.5,
  );

  static final TextStyle body = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    height: 1.5,
  );

  /// Fixed-width style for code snippets or similar.
  static final TextStyle code = GoogleFonts.inconsolata(
    fontSize: 13,
    height: 1.4,
  );

}
