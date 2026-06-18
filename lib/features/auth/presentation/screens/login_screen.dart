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
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _isGoogleLoading = false;

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await ref.read(authNotifierProvider.notifier).login(
            _emailController.text.trim(),
            _passwordController.text,
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

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isGoogleLoading = true);

    try {
      // await ref.read(authNotifierProvider.notifier).googleSignIn();
      throw Exception('Google Sign In is not yet implemented');
      if (mounted) {
        context.go('/');
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar(e.toString());
      }
    } finally {
      if (mounted) setState(() => _isGoogleLoading = false);
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
    final size = MediaQuery.of(context).size;

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
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingLG,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: AppSizes.paddingXL),

                      // ─── Logo / Brand ──────────────────────────────
                      _buildBranding(),

                      const SizedBox(height: AppSizes.paddingXXL),

                      // ─── Login Form Card ───────────────────────────
                      _buildLoginCard(),

                      const SizedBox(height: AppSizes.paddingLG),

                      // ─── Divider ───────────────────────────────────
                      _buildDivider(),

                      const SizedBox(height: AppSizes.paddingLG),

                      // ─── Google Sign-In ────────────────────────────
                      _buildGoogleButton(),

                      const SizedBox(height: AppSizes.paddingXL),

                      // ─── Register Link ─────────────────────────────
                      _buildRegisterLink(),

                      const SizedBox(height: AppSizes.paddingXL),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─── Branding Section ───────────────────────────────────────────────────

  Widget _buildBranding() {
    return Column(
      children: [
        // Gold star icon
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.primaryGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.4),
                blurRadius: 30,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(
            Icons.architecture_rounded,
            size: 36,
            color: AppColors.textOnPrimary,
          ),
        ),
        const SizedBox(height: AppSizes.paddingMD),

        // App name in gold with glow
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.goldShimmer.createShader(bounds),
          child: Text(
            'auth.academy_name'.tr(),
            style: GoogleFonts.cairo(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: AppSizes.paddingSM),

        // Subtitle
        Text(
          'auth.login_subtitle'.tr(),
          style: GoogleFonts.tajawal(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // ─── Login Card ─────────────────────────────────────────────────────────

  Widget _buildLoginCard() {
    return GlassCard(
      padding: const EdgeInsets.all(AppSizes.paddingLG),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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

            // Password
            AppTextField(
              controller: _passwordController,
              hintText: 'auth.password_hint'.tr(),
              prefixIcon: Icons.lock_outline_rounded,
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _handleLogin(),
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
                if (value.length < 6) {
                  return 'auth.password_min_length'.tr();
                }
                return null;
              },
            ),

            const SizedBox(height: AppSizes.paddingSM),

            // Forgot Password
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () => context.push('/forgot-password'),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingSM,
                    vertical: AppSizes.paddingXS,
                  ),
                ),
                child: Text(
                  'auth.forgot_password'.tr(),
                  style: GoogleFonts.tajawal(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppSizes.paddingMD),

            // Login Button
            AppButton.primary(
              text: 'auth.login'.tr(),
              onPressed: _isLoading ? null : _handleLogin,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }

  // ─── Divider ────────────────────────────────────────────────────────────

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 0.5,
            color: AppColors.surfaceElevated,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMD),
          child: Text(
            'auth.or'.tr(),
            style: GoogleFonts.tajawal(
              fontSize: 14,
              color: AppColors.textTertiary,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 0.5,
            color: AppColors.surfaceElevated,
          ),
        ),
      ],
    );
  }

  // ─── Google Button ──────────────────────────────────────────────────────

  Widget _buildGoogleButton() {
    return AppButton.outlined(
      text: 'auth.google_sign_in'.tr(),
      onPressed: _isGoogleLoading ? null : _handleGoogleSignIn,
      isLoading: _isGoogleLoading,
      iconWidget: const Icon(
        Icons.g_mobiledata_rounded,
        size: 32,
        color: AppColors.textPrimary,
      ),
    );
  }

  // ─── Register Link ─────────────────────────────────────────────────────

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'auth.no_account'.tr(),
          style: GoogleFonts.tajawal(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        TextButton(
          onPressed: () => context.push('/register'),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingSM,
            ),
          ),
          child: Text(
            'auth.create_account'.tr(),
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
