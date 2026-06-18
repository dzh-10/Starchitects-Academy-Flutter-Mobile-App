import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/theme/text_styles.dart';
import 'package:starchitects_app/core/widgets/glass_card.dart';
import 'package:starchitects_app/features/certificates/data/models/certificate_model.dart';

/// Premium certificate card widget with gold seal, course info,
/// and download/share action buttons. Uses glassmorphism design.
class CertificateCard extends StatelessWidget {
  final CertificateModel certificate;
  final VoidCallback? onDownload;
  final VoidCallback? onShare;
  final bool isDownloading;

  const CertificateCard({
    super.key,
    required this.certificate,
    this.onDownload,
    this.onShare,
    this.isDownloading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ─── Top Section: Gold Seal ────────────────────────
          _buildSealHeader(),

          // ─── Content Section ──────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Course title
                Text(
                  certificate.courseTitle,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.textPrimary,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 6),

                // Student name
                Text(
                  certificate.studentName,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 8),

                // Issue date
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 12,
                      color: AppColors.primary.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${'certificates.issued_on'.tr()} ${_formatDate(certificate.issuedAt)}',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ─── Action Buttons ───────────────────────────────
          _buildActionBar(),
        ],
      ),
    );
  }

  Widget _buildSealHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.12),
            AppColors.primary.withValues(alpha: 0.04),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          // Gold medal/seal icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.primaryGradient,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Icon(
              Icons.workspace_premium_rounded,
              size: 28,
              color: AppColors.textOnPrimary,
            ),
          ),

          const SizedBox(height: 8),

          // Certificate label
          Text(
            'certificates.certificate'.tr(),
            style: GoogleFonts.cairo(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.glassBorderSubtle,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Download button
          _ActionIconButton(
            icon: isDownloading
                ? Icons.hourglass_top_rounded
                : Icons.download_rounded,
            tooltip: 'certificates.download'.tr(),
            onTap: isDownloading ? null : onDownload,
            isLoading: isDownloading,
          ),

          const SizedBox(width: 4),

          // Share button
          _ActionIconButton(
            icon: Icons.share_rounded,
            tooltip: 'certificates.share'.tr(),
            onTap: onShare,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd MMMM yyyy', 'ar').format(date);
  }
}

/// Small icon button for certificate card actions.
class _ActionIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;
  final bool isLoading;

  const _ActionIconButton({
    required this.icon,
    required this.tooltip,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: isLoading
                ? SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary.withValues(alpha: 0.6),
                    ),
                  )
                : Icon(
                    icon,
                    size: 18,
                    color: onTap != null
                        ? AppColors.primary.withValues(alpha: 0.8)
                        : AppColors.textTertiary,
                  ),
          ),
        ),
      ),
    );
  }
}
