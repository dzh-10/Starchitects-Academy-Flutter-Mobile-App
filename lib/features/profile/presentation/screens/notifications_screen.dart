import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/theme/text_styles.dart';
import 'package:starchitects_app/core/widgets/empty_state_widget.dart';
import 'package:starchitects_app/core/widgets/error_state_widget.dart';
import 'package:starchitects_app/core/widgets/glass_card.dart';
import 'package:starchitects_app/core/widgets/shimmer_loading.dart';
import 'package:starchitects_app/features/profile/data/models/notification_model.dart';
import 'package:starchitects_app/features/profile/presentation/providers/profile_provider.dart';

/// Notifications list screen with mark-all-read, unread indicators,
/// and time-ago formatting. Uses shimmer loading and empty state.
class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationsListProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'notifications.title'.tr(),
          style: AppTextStyles.headlineMedium,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        actions: [
          notificationsAsync.whenOrNull(
                data: (notifications) {
                  final hasUnread = notifications.any((n) => !n.isRead);
                  if (!hasUnread) return const SizedBox.shrink();

                  return TextButton(
                    onPressed: () {
                      ref
                          .read(notificationsListProvider.notifier)
                          .markAllAsRead();
                    },
                    child: Text(
                      'notifications.mark_all_read'.tr(),
                      style: GoogleFonts.tajawal(
                        fontSize: 13,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ) ??
              const SizedBox.shrink(),
        ],
      ),
      body: notificationsAsync.when(
        loading: () => const _NotificationsShimmer(),
        error: (error, _) => ErrorStateWidget(
          message: 'notifications.load_error'.tr(),
          onRetry: () => ref.invalidate(notificationsListProvider),
        ),
        data: (notifications) {
          if (notifications.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.notifications_none_rounded,
              title: 'notifications.empty_title'.tr(),
              subtitle: 'notifications.empty_subtitle'.tr(),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return _NotificationItem(
                notification: notification,
                onTap: () {
                  if (!notification.isRead) {
                    ref
                        .read(notificationsListProvider.notifier)
                        .markAsRead(notification.id);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}

/// Single notification item card with unread indicator and time ago.
class _NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;

  const _NotificationItem({
    required this.notification,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlassCard(
        onTap: onTap,
        padding: const EdgeInsets.all(16),
        borderColor: notification.isRead
            ? AppColors.glassBorderSubtle
            : AppColors.primary.withValues(alpha: 0.4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Unread indicator dot
            if (!notification.isRead)
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(top: 6, left: 0, right: 12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              )
            else
              const SizedBox(width: 22),

            // Notification icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getTypeColor().withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                _getTypeIcon(),
                size: 20,
                color: _getTypeColor(),
              ),
            ),

            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: notification.isRead
                          ? FontWeight.w400
                          : FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.body,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _formatTimeAgo(notification.createdAt),
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.textTertiary,
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

  IconData _getTypeIcon() {
    switch (notification.type) {
      case 'course':
        return Icons.school_rounded;
      case 'payment':
        return Icons.payment_rounded;
      case 'certificate':
        return Icons.workspace_premium_rounded;
      case 'live':
        return Icons.live_tv_rounded;
      default:
        return Icons.notifications_rounded;
    }
  }

  Color _getTypeColor() {
    switch (notification.type) {
      case 'course':
        return AppColors.info;
      case 'payment':
        return AppColors.success;
      case 'certificate':
        return AppColors.primary;
      case 'live':
        return AppColors.liveBadge;
      default:
        return AppColors.primary;
    }
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inMinutes < 1) return 'notifications.just_now'.tr();
    if (diff.inMinutes < 60) {
      return 'notifications.minutes_ago'
          .tr(namedArgs: {'count': '${diff.inMinutes}'});
    }
    if (diff.inHours < 24) {
      return 'notifications.hours_ago'
          .tr(namedArgs: {'count': '${diff.inHours}'});
    }
    if (diff.inDays < 7) {
      return 'notifications.days_ago'
          .tr(namedArgs: {'count': '${diff.inDays}'});
    }

    return DateFormat('dd/MM/yyyy', 'ar').format(dateTime);
  }
}

/// Shimmer loading placeholder for notifications list.
class _NotificationsShimmer extends StatelessWidget {
  const _NotificationsShimmer();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: 6,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: ShimmerListTile(hasLeading: true, hasTrailing: false),
      ),
    );
  }
}
