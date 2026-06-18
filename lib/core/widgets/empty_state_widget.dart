import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/widgets/app_button.dart';

/// Premium empty state widget with icon, title, subtitle,
/// and optional action button.
class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? actionText;
  final VoidCallback? onAction;
  final IconData? actionIcon;
  final double iconSize;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.actionText,
    this.onAction,
    this.actionIcon,
    this.iconSize = 72,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon with subtle gold container
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.06),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  width: 1,
                ),
              ),
              child: Icon(
                icon,
                size: iconSize,
                color: AppColors.primary.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 28),

            // Title
            Text(
              title,
              style: GoogleFonts.cairo(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),

            // Subtitle
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: GoogleFonts.tajawal(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ],

            // Action button
            if (actionText != null && onAction != null) ...[
              const SizedBox(height: 28),
              SizedBox(
                width: 220,
                child: AppButton(
                  text: actionText!,
                  onPressed: onAction,
                  icon: actionIcon,
                  height: 44,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
