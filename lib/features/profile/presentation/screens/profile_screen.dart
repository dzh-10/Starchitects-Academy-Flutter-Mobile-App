import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/theme/text_styles.dart';
import 'package:starchitects_app/core/widgets/cached_avatar.dart';
import 'package:starchitects_app/core/widgets/glass_card.dart';
import 'package:starchitects_app/features/auth/domain/auth_provider.dart';import 'package:starchitects_app/features/profile/presentation/providers/profile_provider.dart';
import 'package:starchitects_app/features/profile/presentation/screens/settings_screen.dart';

/// Main profile screen with user info, menu items, and settings.
/// Uses glassmorphism cards with gold accents and smooth list animations.
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _listAnimController;

  @override
  void initState() {
    super.initState();
    _listAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _listAnimController.forward();
  }

  @override
  void dispose() {
    _listAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final unreadCount = ref.watch(unreadNotificationsCountProvider);
    final isDarkMode = ref.watch(darkModeProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ─── App Bar ────────────────────────────────────────
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 60,
            floating: true,
            title: Text(
              'profile.title'.tr(),
              style: AppTextStyles.headlineMedium,
            ),
            centerTitle: true,
          ),

          // ─── User Header ──────────────────────────────────
          SliverToBoxAdapter(
            child: _buildUserHeader(user?.name, user?.email, user?.avatar),
          ),

          // ─── Menu Items ───────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                _buildMenuItems(unreadCount, isDarkMode),
              ),
            ),
          ),

          // Bottom spacing
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }

  Widget _buildUserHeader(String? name, String? email, String? avatar) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: GlassCard(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            // Avatar with gold ring
            CachedAvatar.xl(
              imageUrl: avatar,
              name: name,
              borderWidth: 3.5,
            ),

            const SizedBox(height: 16),

            // Name
            Text(
              name ?? 'profile.guest'.tr(),
              style: GoogleFonts.cairo(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 4),

            // Email
            Text(
              email ?? '',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMenuItems(int unreadCount, bool isDarkMode) {
    final items = <_MenuItem>[
      _MenuItem(
        icon: Icons.edit_rounded,
        title: 'profile.edit_profile'.tr(),
        onTap: () => context.push('/profile/edit'),
      ),
      _MenuItem(
        icon: Icons.lock_outline_rounded,
        title: 'profile.change_password'.tr(),
        onTap: () => context.push('/profile/change-password'),
      ),
      _MenuItem(
        icon: Icons.notifications_outlined,
        title: 'profile.notifications'.tr(),
        badge: unreadCount > 0 ? unreadCount : null,
        onTap: () => context.push('/profile/notifications'),
      ),
      _MenuItem(
        icon: Icons.workspace_premium_rounded,
        title: 'profile.my_certificates'.tr(),
        onTap: () => context.push('/certificates'),
      ),
      _MenuItem(
        icon: Icons.language_rounded,
        title: 'profile.language'.tr(),
        trailing: Text(
          _getCurrentLanguageLabel(context),
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
        onTap: () => _showLanguageSheet(context),
      ),
      _MenuItem(
        icon: Icons.dark_mode_rounded,
        title: 'profile.dark_mode'.tr(),
        trailing: Switch(
          value: isDarkMode,
          onChanged: (value) => ref.read(darkModeProvider.notifier).toggle(),
          activeColor: AppColors.primary,
          activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
          inactiveTrackColor: AppColors.surfaceElevated,
          inactiveThumbColor: AppColors.textTertiary,
        ),
        onTap: () => ref.read(darkModeProvider.notifier).toggle(),
      ),
      _MenuItem(
        icon: Icons.info_outline_rounded,
        title: 'profile.about'.tr(),
        onTap: () => _showAboutDialog(context),
      ),
      _MenuItem(
        icon: Icons.logout_rounded,
        title: 'profile.logout'.tr(),
        isDestructive: true,
        onTap: () => _showLogoutConfirmation(context),
      ),
    ];

    return items.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;

      // Staggered animation for each item
      final delay = index / items.length;
      final animation = CurvedAnimation(
        parent: _listAnimController,
        curve: Interval(delay, (delay + 0.4).clamp(0, 1),
            curve: Curves.easeOutCubic),
      );

      return FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.2),
            end: Offset.zero,
          ).animate(animation),
          child: _buildMenuItem(item),
        ),
      );
    }).toList();
  }

  Widget _buildMenuItem(_MenuItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlassCard(
        onTap: item.onTap,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        borderColor: item.isDestructive
            ? AppColors.error.withValues(alpha: 0.15)
            : null,
        child: Row(
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (item.isDestructive ? AppColors.error : AppColors.primary)
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                item.icon,
                size: 20,
                color: item.isDestructive ? AppColors.error : AppColors.primary,
              ),
            ),

            const SizedBox(width: 14),

            // Title
            Expanded(
              child: Text(
                item.title,
                style: AppTextStyles.titleMedium.copyWith(
                  color: item.isDestructive
                      ? AppColors.error
                      : AppColors.textPrimary,
                ),
              ),
            ),

            // Badge
            if (item.badge != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${item.badge}',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],

            // Trailing widget or chevron
            item.trailing ??
                Icon(
                  Icons.chevron_left_rounded,
                  color: item.isDestructive
                      ? AppColors.error.withValues(alpha: 0.5)
                      : AppColors.textTertiary,
                  size: 22,
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

  void _showLanguageSheet(BuildContext context) {
    showLanguageBottomSheet(context, ref);
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.backgroundLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: AppColors.primary.withValues(alpha: 0.3),
          ),
        ),
        title: Text(
          'Starchitects Academy',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'profile.about_description'.tr(),
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'v1.0.0',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'common.close'.tr(),
              style: GoogleFonts.cairo(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.backgroundLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: AppColors.error.withValues(alpha: 0.2),
          ),
        ),
        title: Text(
          'profile.logout_title'.tr(),
          style: AppTextStyles.headlineSmall,
          textAlign: TextAlign.center,
        ),
        content: Text(
          'profile.logout_confirm'.tr(),
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              'common.cancel'.tr(),
              style: GoogleFonts.cairo(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              ref.read(authNotifierProvider.notifier).logout();
              context.go('/login');
            },
            child: Text(
              'profile.logout'.tr(),
              style: GoogleFonts.cairo(
                color: AppColors.error,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Internal menu item data class
class _MenuItem {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  final int? badge;
  final bool isDestructive;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.onTap,
    this.trailing,
    this.badge,
    this.isDestructive = false,
  });
}
