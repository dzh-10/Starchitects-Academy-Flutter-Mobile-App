import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/theme/text_styles.dart';
import 'package:starchitects_app/core/widgets/app_button.dart';
import 'package:starchitects_app/core/widgets/glass_card.dart';
import 'package:starchitects_app/features/payments/presentation/providers/payment_provider.dart';

/// Payment result screen showing success or failure state.
/// Polls the backend to verify payment and shows appropriate UI.
class PaymentResultScreen extends ConsumerStatefulWidget {
  final String paymentId;
  final bool success;

  const PaymentResultScreen({
    super.key,
    required this.paymentId,
    required this.success,
  });

  @override
  ConsumerState<PaymentResultScreen> createState() =>
      _PaymentResultScreenState();
}

class _PaymentResultScreenState extends ConsumerState<PaymentResultScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  Timer? _verifyTimer;
  String? _verifiedCourseId;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    // Play animations
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _scaleController.forward();
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _fadeController.forward();
    });

    // Start verification polling if success
    if (widget.success) {
      _startVerification();
    }
  }

  void _startVerification() {
    _isVerifying = true;
    _verifyPayment();
    _verifyTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => _verifyPayment(),
    );
  }

  Future<void> _verifyPayment() async {
    try {
      final result = await ref.read(
        paymentVerifyProvider(widget.paymentId).future,
      );
      if (result.status == 'paid') {
        _verifyTimer?.cancel();
        if (mounted) {
          setState(() {
            _isVerifying = false;
            _verifiedCourseId = result.courseId;
          });
        }
      }
    } catch (_) {
      // Silently retry on next poll
    }
  }

  @override
  void dispose() {
    _verifyTimer?.cancel();
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Spacer(flex: 2),

                // ─── Result Icon ─────────────────────────────────
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: _buildResultIcon(),
                ),

                const SizedBox(height: 32),

                // ─── Result Content ──────────────────────────────
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildResultContent(),
                ),

                const Spacer(flex: 2),

                // ─── Action Buttons ──────────────────────────────
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildActionButtons(),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultIcon() {
    final isSuccess = widget.success;

    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: (isSuccess ? AppColors.primary : AppColors.error)
            .withValues(alpha: 0.1),
        border: Border.all(
          color: (isSuccess ? AppColors.primary : AppColors.error)
              .withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: (isSuccess ? AppColors.primary : AppColors.error)
                .withValues(alpha: 0.2),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Icon(
        isSuccess
            ? Icons.check_circle_rounded
            : Icons.cancel_rounded,
        size: 64,
        color: isSuccess ? AppColors.primary : AppColors.error,
      ),
    );
  }

  Widget _buildResultContent() {
    final isSuccess = widget.success;

    return GlassCard(
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          Text(
            isSuccess
                ? 'payments.success_title'.tr()
                : 'payments.failure_title'.tr(),
            style: GoogleFonts.cairo(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: isSuccess ? AppColors.primary : AppColors.error,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          Text(
            isSuccess
                ? 'payments.success_subtitle'.tr()
                : 'payments.failure_subtitle'.tr(),
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),

          if (isSuccess && _isVerifying) ...[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'payments.verifying'.tr(),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ],

          if (isSuccess && !_isVerifying) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.success.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.verified_rounded,
                    size: 16,
                    color: AppColors.success,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'payments.verified'.tr(),
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    final isSuccess = widget.success;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (isSuccess) ...[
          AppButton(
            text: 'payments.start_learning'.tr(),
            onPressed: () {
              if (_verifiedCourseId != null) {
                context.go('/courses/$_verifiedCourseId');
              } else {
                context.go('/home');
              }
            },
            icon: Icons.play_circle_filled_rounded,
            gradient: AppColors.primaryGradient,
          ),
          const SizedBox(height: 12),
          AppButton.outlined(
            text: 'common.back_home'.tr(),
            onPressed: () => context.go('/home'),
            icon: Icons.home_rounded,
          ),
        ] else ...[
          AppButton(
            text: 'payments.retry'.tr(),
            onPressed: () => context.pop(),
            icon: Icons.refresh_rounded,
            gradient: AppColors.primaryGradient,
          ),
          const SizedBox(height: 12),
          AppButton.outlined(
            text: 'common.go_back'.tr(),
            onPressed: () => context.go('/home'),
            icon: Icons.arrow_back_rounded,
          ),
        ],
      ],
    );
  }
}
