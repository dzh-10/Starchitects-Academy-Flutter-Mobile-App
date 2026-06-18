import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/widgets/app_button.dart';

/// Premium error state widget with icon, message, and retry button.
class ErrorStateWidget extends StatelessWidget {
  final String? message;
  final String? title;
  final VoidCallback? onRetry;
  final String retryText;
  final IconData icon;
  final double iconSize;

  const ErrorStateWidget({
    super.key,
    this.message,
    this.title,
    this.onRetry,
    this.retryText = 'إعادة المحاولة',
    this.icon = Icons.error_outline_rounded,
    this.iconSize = 64,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated error icon with glow
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.error.withValues(alpha: 0.1),
                border: Border.all(
                  color: AppColors.error.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Icon(
                icon,
                size: iconSize,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: 24),

            // Title
            if (title != null) ...[
              Text(
                title!,
                style: GoogleFonts.cairo(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],

            // Error message
            Text(
              message ?? 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.',
              style: GoogleFonts.tajawal(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),

            // Retry button
            if (onRetry != null)
              SizedBox(
                width: 200,
                child: AppButton(
                  text: retryText,
                  onPressed: onRetry,
                  icon: Icons.refresh_rounded,
                  height: 44,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
