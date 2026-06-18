import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/theme/text_styles.dart';
import 'package:starchitects_app/core/widgets/empty_state_widget.dart';
import 'package:starchitects_app/core/widgets/error_state_widget.dart';
import 'package:starchitects_app/core/widgets/shimmer_loading.dart';
import 'package:starchitects_app/features/certificates/data/models/certificate_model.dart';
import 'package:starchitects_app/features/certificates/data/repositories/certificate_repository.dart';
import 'package:starchitects_app/features/certificates/presentation/providers/certificate_provider.dart';
import 'package:starchitects_app/features/certificates/presentation/widgets/certificate_card.dart';

/// Certificates list screen showing a responsive grid of certificate cards.
/// Supports download and share actions with PDF handling.
class CertificatesListScreen extends ConsumerStatefulWidget {
  const CertificatesListScreen({super.key});

  @override
  ConsumerState<CertificatesListScreen> createState() =>
      _CertificatesListScreenState();
}

class _CertificatesListScreenState
    extends ConsumerState<CertificatesListScreen> {
  final Set<String> _downloadingIds = {};

  Future<void> _downloadCertificate(CertificateModel certificate) async {
    setState(() => _downloadingIds.add(certificate.id));

    try {
      final repo = ref.read(certificateRepositoryProvider);
      final pdfBytes = await repo.downloadCertificate(certificate.id);

      // Save to device
      final dir = await getApplicationDocumentsDirectory();
      final fileName =
          'certificate_${certificate.courseTitle.replaceAll(RegExp(r'[^\w\s]'), '').replaceAll(' ', '_')}.pdf';
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(pdfBytes);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'certificates.download_success'.tr(),
            style: GoogleFonts.tajawal(),
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          action: SnackBarAction(
            label: 'certificates.open'.tr(),
            textColor: Colors.white,
            onPressed: () {
              // Open file - platform specific handling
            },
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'certificates.download_failed'.tr(),
            style: GoogleFonts.tajawal(),
          ),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _downloadingIds.remove(certificate.id));
      }
    }
  }

  Future<void> _shareCertificate(CertificateModel certificate) async {
    try {
      final repo = ref.read(certificateRepositoryProvider);
      final pdfBytes = await repo.downloadCertificate(certificate.id);

      // Save temporarily for sharing
      final dir = await getTemporaryDirectory();
      final fileName =
          'certificate_${certificate.courseTitle.replaceAll(RegExp(r'[^\w\s]'), '').replaceAll(' ', '_')}.pdf';
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(pdfBytes);

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: 'certificates.share_text'
              .tr(namedArgs: {'course': certificate.courseTitle}),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'certificates.share_failed'.tr(),
            style: GoogleFonts.tajawal(),
          ),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final certificatesAsync = ref.watch(certificatesListProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'certificates.title'.tr(),
          style: AppTextStyles.headlineMedium,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: certificatesAsync.when(
        loading: () => const _CertificatesShimmer(),
        error: (error, _) => ErrorStateWidget(
          message: 'certificates.load_error'.tr(),
          onRetry: () => ref.invalidate(certificatesListProvider),
        ),
        data: (certificates) {
          if (certificates.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.school_rounded,
              title: 'certificates.empty_title'.tr(),
              subtitle: 'certificates.empty_subtitle'.tr(),
              actionText: 'certificates.browse_courses'.tr(),
              actionIcon: Icons.explore_rounded,
              onAction: () => context.go('/courses'),
            );
          }

          return _buildCertificatesGrid(certificates);
        },
      ),
    );
  }

  Widget _buildCertificatesGrid(List<CertificateModel> certificates) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive column count: 2 for wider screens, 1 for narrow
        final crossAxisCount = constraints.maxWidth > 500 ? 2 : 1;
        final childAspectRatio = crossAxisCount == 2 ? 0.68 : 1.1;

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: certificates.length,
          itemBuilder: (context, index) {
            final certificate = certificates[index];
            return CertificateCard(
              certificate: certificate,
              isDownloading: _downloadingIds.contains(certificate.id),
              onDownload: () => _downloadCertificate(certificate),
              onShare: () => _shareCertificate(certificate),
            );
          },
        );
      },
    );
  }
}

/// Shimmer loading placeholder for certificates grid.
class _CertificatesShimmer extends StatelessWidget {
  const _CertificatesShimmer();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.68,
      ),
      itemCount: 4,
      itemBuilder: (context, index) => const _CertificateShimmerCard(),
    );
  }
}

/// Single shimmer card matching the certificate card layout.
class _CertificateShimmerCard extends StatelessWidget {
  const _CertificateShimmerCard();

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.glassBorderSubtle),
        ),
        child: Column(
          children: [
            // Seal header placeholder
            Container(
              height: 90,
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 14,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 80,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 100,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
