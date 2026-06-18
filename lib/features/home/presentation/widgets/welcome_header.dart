import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/theme/text_styles.dart';
import 'package:starchitects_app/core/widgets/cached_avatar.dart';
import 'package:starchitects_app/features/auth/presentation/providers/auth_provider.dart';

/// Welcome header with time-based greeting, student avatar, and notification bell
class WelcomeHeader extends ConsumerWidget {
  const WelcomeHeader({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'home.greeting_morning'.tr(); // صباح الخير
    } else if (hour < 18) {
      return 'home.greeting_afternoon'.tr(); // مساء الخير
    } else {
      return 'home.greeting_evening'.tr(); // مساء الخير
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final userName = user?.name ?? 'home.student'.tr();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          // Avatar with gold ring
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary,
                width: 2.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: CachedAvatar(
              imageUrl: user?.avatar,
              size: AppSizes.avatarMD,
              name: userName,
            ),
          ),
          const SizedBox(width: 14),
          // Greeting & name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getGreeting(),
                  style: AppTextStyles.tajawalRegular(14,
                      color: AppColors.textSecondary),
                ),
                const SizedBox(height: 2),
                Text(
                  userName,
                  style: AppTextStyles.cairoBold(20),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Notification bell
          _NotificationBell(),
        ],
      ),
    );
  }
}

class _NotificationBell extends StatefulWidget {
  @override
  State<_NotificationBell> createState() => _NotificationBellState();
}

class _NotificationBellState extends State<_NotificationBell>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 0.1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.1, end: -0.1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -0.1, end: 0.08), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.08, end: -0.05), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -0.05, end: 0), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Subtle shake on appear
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _shakeAnimation.value,
          child: child,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.glassBackground,
          borderRadius: BorderRadius.circular(AppSizes.radiusMD),
          border: Border.all(color: AppColors.glassBorderSubtle),
        ),
        child: IconButton(
          onPressed: () {
            // TODO: Navigate to notifications
          },
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Icons.notifications_outlined,
                color: AppColors.textPrimary,
                size: 24,
              ),
              // Notification badge dot
              Positioned(
                top: -2,
                right: -2,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.background,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
