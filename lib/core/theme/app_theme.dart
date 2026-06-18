import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.kBgPrimary,
      primaryColor: AppColors.kGold,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.kGold,
        secondary: AppColors.kGoldDark,
        surface: AppColors.kBgCard,
      ),
      textTheme: GoogleFonts.tajawalTextTheme(
        ThemeData.dark().textTheme.copyWith(
          displayLarge: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.kTextPrimary),
          displayMedium: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.kTextPrimary),
          bodyLarge: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.kTextPrimary),
          bodyMedium: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: AppColors.kTextSecondary),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.kBgCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kGold,
          foregroundColor: AppColors.kBgPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Tajawal'),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.kBgPrimary,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.kGold),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.kBgCard,
        selectedItemColor: AppColors.kGold,
        unselectedItemColor: AppColors.kTextSecondary,
        type: BottomNavigationBarType.fixed,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.kBgCardLight,
        selectedColor: AppColors.kGold,
        labelStyle: const TextStyle(color: AppColors.kTextPrimary),
        secondaryLabelStyle: const TextStyle(color: AppColors.kBgPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}
