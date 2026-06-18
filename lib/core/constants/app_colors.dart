import 'package:flutter/material.dart';

class AppColors {
  // Existing Colors
  static const Color kGold = Color(0xFFF7C353);
  static const Color kGoldDark = Color(0xFFD4A017);
  static const Color kBgPrimary = Color(0xFF0D0D0D);
  static const Color kBgCard = Color(0xFF1A1A1A);
  static const Color kBgCardLight = Color(0xFF242424);
  static const Color kTextPrimary = Color(0xFFFFFFFF);
  static const Color kTextSecondary = Color(0xFF9E9E9E);

  // Added Missing Colors
  static const Color primary = Color(0xFFF7C353);
  static const Color primaryDark = Color(0xFFD4A017);
  
  static const Color background = Color(0xFF0D0D0D);
  static const Color backgroundDarkest = Color(0xFF000000);
  
  static const Color surfaceElevated = Color(0xFF1A1A1A);
  static const Color surfaceLight = Color(0xFF242424);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9E9E9E);
  static const Color textTertiary = Color(0xFF757575);
  static const Color textOnPrimary = Color(0xFF000000); // Black text on gold button

  static const Color glassBackground = Color(0x1AFFFFFF); // 10% white
  static const Color glassBorder = Color(0x33FFFFFF); // 20% white
  
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);

  static const Gradient primaryGradient = LinearGradient(
    colors: [kGold, kGoldDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
