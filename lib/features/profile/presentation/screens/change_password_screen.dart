import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/theme/text_styles.dart';
import 'package:starchitects_app/core/widgets/app_button.dart';
import 'package:starchitects_app/core/widgets/app_text_field.dart';
import 'package:starchitects_app/core/widgets/glass_card.dart';
import 'package:starchitects_app/features/auth/data/repositories/auth_repository.dart';

/// Change password screen with current, new, and confirm password fields.
class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.changePassword(
        currentPassword: _currentPasswordController.text,
        newPassword: _newPasswordController.text,
        confirmPassword: _confirmPasswordController.text,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'profile.password_changed'.tr(),
            style: GoogleFonts.tajawal(),
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

      context.pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'profile.password_change_failed'.tr(),
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
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'profile.change_password'.tr(),
          style: AppTextStyles.headlineMedium,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 16),

              // ─── Security Icon ─────────────────────────────
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.08),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: Icon(
                  Icons.shield_rounded,
                  size: 40,
                  color: AppColors.primary.withValues(alpha: 0.8),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'profile.password_security'.tr(),
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),

              const SizedBox(height: 28),

              // ─── Password Form ─────────────────────────────
              GlassCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Current password
                    Text(
                      'profile.current_password'.tr(),
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppTextField.password(
                      controller: _currentPasswordController,
                      hintText: 'profile.current_password_hint'.tr(),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'profile.current_password_required'.tr();
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // New password
                    Text(
                      'profile.new_password'.tr(),
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppTextField.password(
                      controller: _newPasswordController,
                      hintText: 'profile.new_password_hint'.tr(),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'profile.new_password_required'.tr();
                        }
                        if (value.length < 8) {
                          return 'profile.password_min_length'.tr();
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Confirm password
                    Text(
                      'profile.confirm_password'.tr(),
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppTextField.password(
                      controller: _confirmPasswordController,
                      hintText: 'profile.confirm_password_hint'.tr(),
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'profile.confirm_password_required'.tr();
                        }
                        if (value != _newPasswordController.text) {
                          return 'profile.passwords_mismatch'.tr();
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ─── Change Button ─────────────────────────────
              AppButton(
                text: 'profile.change'.tr(),
                onPressed: _isLoading ? null : _changePassword,
                isLoading: _isLoading,
                icon: Icons.lock_reset_rounded,
                gradient: AppColors.primaryGradient,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
