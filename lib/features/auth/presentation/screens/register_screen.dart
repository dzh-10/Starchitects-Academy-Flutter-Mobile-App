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
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptedTerms = false;
  bool _isLoading = false;

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOutCubic,
    ));
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_acceptedTerms) {
      _showErrorSnackBar('auth.accept_terms_required'.tr());
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref.read(authNotifierProvider.notifier).register(
            _nameController.text.trim(),
            _emailController.text.trim(),
            _passwordController.text,
            _confirmPasswordController.text,
          );

      if (mounted) {
        context.go('/');
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar(e.toString());
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
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
                  // ─── App Bar ─────────────────────────────────────
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

                  // ─── Content ────────────────────────────────────
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingLG,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(height: AppSizes.paddingMD),

                        // ─── Title ────────────────────────────────
                        _buildHeader(),

                        const SizedBox(height: AppSizes.paddingXL),

                        // ─── Form Card ────────────────────────────
                        _buildRegisterCard(),

                        const SizedBox(height: AppSizes.paddingXL),

                        // ─── Login Link ───────────────────────────
                        _buildLoginLink(),

                        const SizedBox(height: AppSizes.paddingXXL),
                      ]),
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

  // ─── Header ─────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.goldShimmer.createShader(bounds),
          child: Text(
            'auth.create_account'.tr(),
            style: GoogleFonts.cairo(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: AppSizes.paddingSM),
        Text(
          'auth.register_subtitle'.tr(),
          style: GoogleFonts.tajawal(
            fontSize: 15,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  // ─── Register Card ──────────────────────────────────────────────────────

  Widget _buildRegisterCard() {
    return GlassCard(
      padding: const EdgeInsets.all(AppSizes.paddingLG),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Name
            AppTextField(
              controller: _nameController,
              hintText: 'auth.name_hint'.tr(),
              prefixIcon: Icons.person_outline_rounded,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'auth.name_required'.tr();
                }
                if (value.trim().length < 2) {
                  return 'auth.name_min_length'.tr();
                }
                return null;
              },
            ),

            const SizedBox(height: AppSizes.paddingMD),

            // Email
            AppTextField(
              controller: _emailController,
              hintText: 'auth.email_hint'.tr(),
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
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

            const SizedBox(height: AppSizes.paddingMD),

            // Phone (optional)
            AppTextField(
              controller: _phoneController,
              hintText: 'auth.phone_hint'.tr(),
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
            ),

            const SizedBox(height: AppSizes.paddingMD),

            // Password
            AppTextField(
              controller: _passwordController,
              hintText: 'auth.password_hint'.tr(),
              prefixIcon: Icons.lock_outline_rounded,
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.next,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20,
                  color: AppColors.textTertiary,
                ),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'auth.password_required'.tr();
                }
                if (value.length < 8) {
                  return 'auth.password_min_length_8'.tr();
                }
                return null;
              },
            ),

            const SizedBox(height: AppSizes.paddingMD),

            // Confirm Password
            AppTextField(
              controller: _confirmPasswordController,
              hintText: 'auth.confirm_password_hint'.tr(),
              prefixIcon: Icons.lock_outline_rounded,
              obscureText: _obscureConfirmPassword,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _handleRegister(),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20,
                  color: AppColors.textTertiary,
                ),
                onPressed: () {
                  setState(() =>
                      _obscureConfirmPassword = !_obscureConfirmPassword);
                },
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'auth.confirm_password_required'.tr();
                }
                if (value != _passwordController.text) {
                  return 'auth.passwords_not_match'.tr();
                }
                return null;
              },
            ),

            const SizedBox(height: AppSizes.paddingMD),

            // Terms Checkbox
            _buildTermsCheckbox(),

            const SizedBox(height: AppSizes.paddingLG),

            // Register Button
            AppButton.primary(
              text: 'auth.register'.tr(),
              onPressed: _isLoading ? null : _handleRegister,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }

  // ─── Terms Checkbox ─────────────────────────────────────────────────────

  Widget _buildTermsCheckbox() {
    return GestureDetector(
      onTap: () => setState(() => _acceptedTerms = !_acceptedTerms),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: _acceptedTerms
                    ? AppColors.primary
                    : AppColors.textTertiary,
                width: 1.5,
              ),
              color: _acceptedTerms
                  ? AppColors.primary.withValues(alpha: 0.15)
                  : Colors.transparent,
            ),
            child: _acceptedTerms
                ? const Icon(
                    Icons.check_rounded,
                    size: 16,
                    color: AppColors.primary,
                  )
                : null,
          ),
          const SizedBox(width: AppSizes.paddingSM),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: 'auth.accept_terms_prefix'.tr(),
                style: GoogleFonts.tajawal(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
                children: [
                  TextSpan(
                    text: 'auth.terms_and_conditions'.tr(),
                    style: GoogleFonts.tajawal(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Login Link ─────────────────────────────────────────────────────────

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'auth.have_account'.tr(),
          style: GoogleFonts.tajawal(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        TextButton(
          onPressed: () => context.pop(),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingSM,
            ),
          ),
          child: Text(
            'auth.login'.tr(),
            style: GoogleFonts.tajawal(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
