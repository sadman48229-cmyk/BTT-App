import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle _base({
    double size = 14,
    FontWeight weight = FontWeight.w400,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // Display
  static TextStyle displayLarge = _base(size: 40, weight: FontWeight.w800, height: 1.1, letterSpacing: -1);
  static TextStyle displayMedium = _base(size: 32, weight: FontWeight.w800, height: 1.15, letterSpacing: -0.5);
  static TextStyle displaySmall = _base(size: 26, weight: FontWeight.w700, height: 1.2);

  // Headlines
  static TextStyle headlineLarge = _base(size: 24, weight: FontWeight.w700, height: 1.25);
  static TextStyle headlineMedium = _base(size: 20, weight: FontWeight.w700, height: 1.3);
  static TextStyle headlineSmall = _base(size: 18, weight: FontWeight.w600, height: 1.35);

  // Titles
  static TextStyle titleLarge = _base(size: 16, weight: FontWeight.w600, height: 1.4);
  static TextStyle titleMedium = _base(size: 14, weight: FontWeight.w600, height: 1.4);
  static TextStyle titleSmall = _base(size: 12, weight: FontWeight.w600, height: 1.4);

  // Body
  static TextStyle bodyLarge = _base(size: 16, weight: FontWeight.w400, height: 1.6);
  static TextStyle bodyMedium = _base(size: 14, weight: FontWeight.w400, height: 1.6);
  static TextStyle bodySmall = _base(size: 12, weight: FontWeight.w400, height: 1.6);

  // Labels
  static TextStyle labelLarge = _base(size: 14, weight: FontWeight.w500, letterSpacing: 0.1);
  static TextStyle labelMedium = _base(size: 12, weight: FontWeight.w500, letterSpacing: 0.1);
  static TextStyle labelSmall = _base(size: 10, weight: FontWeight.w500, letterSpacing: 0.5);

  // Special
  static TextStyle button = _base(size: 15, weight: FontWeight.w600, letterSpacing: 0.3);
  static TextStyle caption = _base(size: 11, weight: FontWeight.w400, height: 1.4);
  static TextStyle overline = _base(size: 10, weight: FontWeight.w600, letterSpacing: 1.5);

  // Colored variants
  static TextStyle primaryLabel = _base(
    size: 14,
    weight: FontWeight.w600,
    color: AppColors.primary,
  );

  static TextStyle successText = _base(
    size: 14,
    weight: FontWeight.w500,
    color: AppColors.success,
  );

  static TextStyle errorText = _base(
    size: 14,
    weight: FontWeight.w500,
    color: AppColors.error,
  );
}
