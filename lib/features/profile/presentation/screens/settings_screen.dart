import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/theme/text_styles.dart';
import 'package:starchitects_app/core/widgets/glass_card.dart';
import 'package:starchitects_app/features/profile/presentation/providers/profile_provider.dart';

/// Language picker bottom sheet used from the profile/settings screen.
/// Supports Arabic, English, and French locales.
void showLanguageBottomSheet(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (sheetContext) => _LanguageBottomSheet(ref: ref),
  );
}

class _LanguageBottomSheet extends StatelessWidget {
  final WidgetRef ref;

  const _LanguageBottomSheet({required this.ref});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;

    final languages = [
      _LanguageOption(
        locale: const Locale('ar'),
        name: 'العربية',
        nativeName: 'Arabic',
        flag: '🇩🇿',
      ),
      _LanguageOption(
        locale: const Locale('en'),
        name: 'English',
        nativeName: 'الإنجليزية',
        flag: '🇺🇸',
      ),
      _LanguageOption(
        locale: const Locale('fr'),
        name: 'Français',
        nativeName: 'الفرنسية',
        flag: '🇫🇷',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: 20),

          // Title
          Text(
            'settings.select_language'.tr(),
            style: AppTextStyles.headlineSmall,
          ),

          const SizedBox(height: 20),

          // Language options
          ...languages.map((lang) => _buildLanguageOption(
                context,
                lang,
                isSelected: currentLocale == lang.locale,
              )),

          const SizedBox(height: 24),

          // Safe area padding
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    _LanguageOption lang, {
    required bool isSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: GlassCard(
        onTap: () {
          context.setLocale(lang.locale);
          ref.read(appLanguageProvider.notifier).setLocale(lang.locale);
          Navigator.of(context).pop();
        },
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        borderColor: isSelected
            ? AppColors.primary.withValues(alpha: 0.5)
            : AppColors.glassBorderSubtle,
        backgroundColor: isSelected
            ? AppColors.primary.withValues(alpha: 0.08)
            : null,
        child: Row(
          children: [
            // Flag
            Text(
              lang.flag,
              style: const TextStyle(fontSize: 28),
            ),

            const SizedBox(width: 16),

            // Language names
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lang.name,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                  Text(
                    lang.nativeName,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),

            // Check indicator
            if (isSelected)
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 16,
                  color: AppColors.textOnPrimary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Internal language option data class
class _LanguageOption {
  final Locale locale;
  final String name;
  final String nativeName;
  final String flag;

  const _LanguageOption({
    required this.locale,
    required this.name,
    required this.nativeName,
    required this.flag,
  });
}

/// Settings screen placeholder (can be expanded later).
/// Currently delegates to the language bottom sheet.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'settings.title'.tr(),
          style: AppTextStyles.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Language setting
            GlassCard(
              onTap: () => showLanguageBottomSheet(context, ref),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.language_rounded,
                      size: 20,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'settings.language'.tr(),
                          style: AppTextStyles.titleMedium,
                        ),
                        Text(
                          _getCurrentLanguageLabel(context),
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_left_rounded,
                    color: AppColors.textTertiary,
                    size: 22,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCurrentLanguageLabel(BuildContext context) {
    final locale = context.locale;
    switch (locale.languageCode) {
      case 'ar':
        return 'العربية';
      case 'en':
        return 'English';
      case 'fr':
        return 'Français';
      default:
        return 'العربية';
    }
  }
}
