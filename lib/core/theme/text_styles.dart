import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';

/// Core text styles using Arabic-first fonts
class AppTextStyles {
  AppTextStyles._();

  // --- Tajawal (Primary Arabic body font) ---
  static TextStyle tajawalRegular(double size, {Color? color}) =>
      GoogleFonts.tajawal(
        fontSize: size,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textPrimary,
      );

  static TextStyle tajawalMedium(double size, {Color? color}) =>
      GoogleFonts.tajawal(
        fontSize: size,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.textPrimary,
      );

  static TextStyle tajawalBold(double size, {Color? color}) =>
      GoogleFonts.tajawal(
        fontSize: size,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.textPrimary,
      );

  // --- Cairo (Arabic heading font) ---
  static TextStyle cairoSemiBold(double size, {Color? color}) =>
      GoogleFonts.cairo(
        fontSize: size,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.textPrimary,
      );

  static TextStyle cairoBold(double size, {Color? color}) =>
      GoogleFonts.cairo(
        fontSize: size,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.textPrimary,
      );

  // --- Playfair Display (Decorative English headings) ---
  static TextStyle playfairBold(double size, {Color? color}) =>
      GoogleFonts.playfairDisplay(
        fontSize: size,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.primary,
      );

  // --- Semantic text styles ---
  static TextStyle get displayLarge => cairoBold(32);
  static TextStyle get displayMedium => cairoBold(28);
  static TextStyle get displaySmall => cairoSemiBold(24);

  static TextStyle get headlineLarge => cairoBold(22);
  static TextStyle get headlineMedium => cairoSemiBold(20);
  static TextStyle get headlineSmall => cairoSemiBold(18);

  static TextStyle get titleLarge => tajawalBold(18);
  static TextStyle get titleMedium => tajawalMedium(16);
  static TextStyle get titleSmall => tajawalMedium(14);

  static TextStyle get bodyLarge => tajawalRegular(16);
  static TextStyle get bodyMedium => tajawalRegular(14);
  static TextStyle get bodySmall => tajawalRegular(12);

  static TextStyle get labelLarge => tajawalMedium(14);
  static TextStyle get labelMedium => tajawalMedium(12);
  static TextStyle get labelSmall => tajawalMedium(10);

  // Special styles
  static TextStyle get goldHeading => cairoBold(24, color: AppColors.primary);
  static TextStyle get priceTag => tajawalBold(20, color: AppColors.primary);
  static TextStyle get badge => tajawalMedium(11, color: AppColors.textOnPrimary);
}
