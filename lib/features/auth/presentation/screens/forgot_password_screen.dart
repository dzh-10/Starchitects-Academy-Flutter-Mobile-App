import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/widgets/app_button.dart';
import 'package:starchitects_app/core/widgets/app_text_field.dart';
import 'package:starchitects_app/core/widgets/glass_card.dart';
import 'package:starchitects_app/features/auth/domain/auth_provider.dart';
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _isLoading = false;
  bool _emailSent = false;

  late final AnimationController _animController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    ));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleSendReset() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // await ref.read(authNotifierProvider.notifier).forgotPassword(_emailController.text.trim());
      throw Exception('Forgot Password is not yet implemented');

      if (mounted) {
        setState(() => _emailSent = true);
        // Re-trigger fade-in for the success state
        _animController.reset();
        _animController.forward();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
              style: GoogleFonts.tajawal(color: Colors.white),
            ),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMD),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A2E),
              AppColors.background,
              AppColors.backgroundDarkest,
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // ─── App Bar ──────────────────────────────────────
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    floating: true,
                    leading: IconButton(
                      onPressed: () => context.pop(),
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.glassBackground,
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusMD,
                          ),
                          border: Border.all(
                            color: AppColors.glassBorderSubtle,
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),

                  // ─── Content ──────────────────────────────────────
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.paddingLG,
                      ),
                      child: _emailSent
                          ? _buildSuccessState()
                          : _buildFormState(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─── Form State (Before Sending) ────────────────────────────────────────

  Widget _buildFormState() {
    return Column(
      children: [
        const Spacer(flex: 1),

        // ─── Lock Illustration ────────────────────────────────
        _buildLockIllustration(),

        const SizedBox(height: AppSizes.paddingXL),

        // ─── Title & Subtitle ─────────────────────────────────
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.goldShimmer.createShader(bounds),
          child: Text(
            'auth.forgot_password_title'.tr(),
            style: GoogleFonts.cairo(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: AppSizes.paddingSM),
        Text(
          'auth.forgot_password_subtitle'.tr(),
          style: GoogleFonts.tajawal(
            fontSize: 15,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: AppSizes.paddingXL),

        // ─── Email Form ───────────────────────────────────────
        GlassCard(
          padding: const EdgeInsets.all(AppSizes.paddingLG),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppTextField(
                  controller: _emailController,
                  hintText: 'auth.email_hint'.tr(),
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _handleSendReset(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'auth.email_required'.tr();
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value.trim())) {
                      return 'auth.email_invalid'.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSizes.paddingLG),
                AppButton.primary(
                  text: 'auth.send_reset_link'.tr(),
                  onPressed: _isLoading ? null : _handleSendReset,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
        ),

        const Spacer(flex: 2),
      ],
    );
  }

  // ─── Success State (After Sending) ──────────────────────────────────────

  Widget _buildSuccessState() {
    return Column(
      children: [
        const Spacer(flex: 1),

        // ─── Success Illustration ─────────────────────────────
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.primaryGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.35),
                blurRadius: 30,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(
            Icons.mark_email_read_outlined,
            size: 44,
            color: AppColors.textOnPrimary,
          ),
        ),

        const SizedBox(height: AppSizes.paddingXL),

        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.goldShimmer.createShader(bounds),
          child: Text(
            'auth.reset_email_sent_title'.tr(),
            style: GoogleFonts.cairo(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        const SizedBox(height: AppSizes.paddingSM),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMD),
          child: Text(
            'auth.reset_email_sent_message'.tr(
              namedArgs: {'email': _emailController.text.trim()},
            ),
            style: GoogleFonts.tajawal(
              fontSize: 15,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        const SizedBox(height: AppSizes.paddingXL),

        GlassCard(
          padding: const EdgeInsets.all(AppSizes.paddingLG),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppButton.primary(
                text: 'auth.back_to_login'.tr(),
                onPressed: () => context.pop(),
              ),
              const SizedBox(height: AppSizes.paddingMD),
              AppButton.outlined(
                text: 'auth.resend_email'.tr(),
                onPressed: () {
                  setState(() => _emailSent = false);
                  _animController.reset();
                  _animController.forward();
                },
              ),
            ],
          ),
        ),

        const Spacer(flex: 2),
      ],
    );
  }

  // ─── Lock Illustration ──────────────────────────────────────────────────

  Widget _buildLockIllustration() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer glow ring
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.15),
              width: 2,
            ),
          ),
        ),
        // Inner filled circle
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withValues(alpha: 0.1),
            border: Border.all(
              color: AppColors.glassBorder,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.2),
                blurRadius: 25,
                spreadRadius: 1,
              ),
            ],
          ),
          child: const Icon(
            Icons.lock_reset_rounded,
            size: 36,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
