import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand Colors
  static const Color primary = Color(0xFF6366F1);      // Indigo
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4F46E5);

  static const Color secondary = Color(0xFF06B6D4);    // Cyan
  static const Color secondaryLight = Color(0xFF22D3EE);
  static const Color secondaryDark = Color(0xFF0891B2);

  static const Color accent = Color(0xFFF59E0B);       // Amber
  static const Color accentLight = Color(0xFFFBBF24);
  static const Color accentDark = Color(0xFFD97706);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF34D399);
  static const Color successDark = Color(0xFF059669);

  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);

  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFF60A5FA);
  static const Color infoDark = Color(0xFF2563EB);

  // Dark Theme Surfaces
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkCard = Color(0xFF1E293B);
  static const Color darkElevated = Color(0xFF334155);
  static const Color darkBorder = Color(0xFF334155);

  // Light Theme Surfaces
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightElevated = Color(0xFFF1F5F9);
  static const Color lightBorder = Color(0xFFE2E8F0);

  // Text Colors - Dark Theme
  static const Color darkTextPrimary = Color(0xFFF1F5F9);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkTextTertiary = Color(0xFF64748B);
  static const Color darkTextDisabled = Color(0xFF475569);

  // Text Colors - Light Theme
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightTextTertiary = Color(0xFF94A3B8);
  static const Color lightTextDisabled = Color(0xFFCBD5E1);

  // Chapter Colors
  static const Color chapterSigns = Color(0xFF6366F1);
  static const Color chapterMarkings = Color(0xFF8B5CF6);
  static const Color chapterTrafficRules = Color(0xFF06B6D4);
  static const Color chapterParking = Color(0xFF10B981);
  static const Color chapterSpeed = Color(0xFFF59E0B);
  static const Color chapterRightOfWay = Color(0xFFEF4444);
  static const Color chapterExpressway = Color(0xFF3B82F6);
  static const Color chapterVehicle = Color(0xFF14B8A6);
  static const Color chapterSafety = Color(0xFFF97316);

  // Difficulty Colors
  static const Color difficultyEasy = Color(0xFF10B981);
  static const Color difficultyMedium = Color(0xFFF59E0B);
  static const Color difficultyHard = Color(0xFFEF4444);

  // Achievement Colors
  static const Color goldAchievement = Color(0xFFFFD700);
  static const Color silverAchievement = Color(0xFFC0C0C0);
  static const Color bronzeAchievement = Color(0xFFCD7F32);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient errorGradient = LinearGradient(
    colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient aiGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
