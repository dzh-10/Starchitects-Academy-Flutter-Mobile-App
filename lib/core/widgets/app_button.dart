import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';

/// Premium gold gradient button or outlined variant
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final IconData? icon;
  final Widget? iconWidget;
  final double? width;
  final double height;
  final double borderRadius;
  final Gradient? gradient;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.icon,
    this.iconWidget,
    this.width,
    this.height = 52.0,
    this.borderRadius = 12.0,
    this.gradient,
    this.backgroundColor,
    this.textColor,
    this.padding,
  });

  /// Convenience factory for a gold gradient primary button
  factory AppButton.primary({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      icon: icon,
      gradient: AppColors.primaryGradient,
    );
  }

  /// Convenience factory for an outlined secondary button
  factory AppButton.outlined({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    Widget? iconWidget,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isOutlined: true,
      icon: icon,
      iconWidget: iconWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return _buildOutlined();
    }
    return _buildFilled();
  }

  Widget _buildFilled() {
    final effectiveGradient = gradient ?? AppColors.primaryGradient;

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: onPressed != null && !isLoading ? effectiveGradient : null,
          color: onPressed == null || isLoading
              ? AppColors.surfaceElevated
              : null,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: onPressed != null && !isLoading
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isLoading ? null : onPressed,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: AppColors.textOnPrimary,
                      ),
                    )
                  : _buildContent(AppColors.textOnPrimary),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOutlined() {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: onPressed != null
                ? AppColors.glassBorder
                : AppColors.surfaceElevated,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          backgroundColor: AppColors.glassBackground,
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.primary,
                ),
              )
            : _buildContent(textColor ?? AppColors.textPrimary),
      ),
    );
  }

  Widget _buildContent(Color color) {
    final label = Text(
      text,
      style: GoogleFonts.cairo(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: color,
      ),
    );

    if (iconWidget != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          iconWidget!,
          const SizedBox(width: 10),
          label,
        ],
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          label,
        ],
      );
    }

    return label;
  }
}
