import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/theme/text_styles.dart';
import 'package:starchitects_app/core/widgets/glass_card.dart';
import 'package:starchitects_app/core/widgets/shimmer_loading.dart';
import 'package:starchitects_app/features/home/data/models/dashboard_model.dart';
import 'package:starchitects_app/features/home/presentation/providers/home_provider.dart';

/// Row of 3 quick stat cards with animated count-up numbers
class QuickStatsRow extends ConsumerWidget {
  const QuickStatsRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardStatsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'home.your_progress'.tr(),
            style: AppTextStyles.cairoSemiBold(18),
          ),
          const SizedBox(height: 14),
          statsAsync.when(
            data: (stats) => Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.menu_book_rounded,
                    count: stats.enrolledCourses,
                    label: 'home.enrolled_courses'.tr(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    icon: Icons.check_circle_rounded,
                    count: stats.completedLessons,
                    label: 'home.completed_lessons'.tr(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    icon: Icons.emoji_events_rounded,
                    count: stats.certificatesEarned,
                    label: 'home.certificates'.tr(),
                  ),
                ),
              ],
            ),
            loading: () => Row(
              children: List.generate(
                3,
                (index) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: index > 0 ? 6 : 0, right: index < 2 ? 6 : 0),
                    child: const ShimmerBox(
                      width: double.infinity,
                      height: 110,
                      borderRadius: AppSizes.radiusLG,
                    ),
                  ),
                ),
              ),
            ),
            error: (_, __) => Row(
              children: List.generate(
                3,
                (index) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: index > 0 ? 6 : 0, right: index < 2 ? 6 : 0),
                    child: const ShimmerBox(
                      width: double.infinity,
                      height: 110,
                      borderRadius: AppSizes.radiusLG,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final int count;
  final String label;

  const _StatCard({
    required this.icon,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Gold icon with glow
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(AppSizes.radiusMD),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(height: 10),
          // Animated count
          TweenAnimationBuilder<int>(
            tween: IntTween(begin: 0, end: count),
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Text(
                '$value',
                style: AppTextStyles.cairoBold(22),
              );
            },
          ),
          const SizedBox(height: 2),
          // Label
          Text(
            label,
            style: AppTextStyles.tajawalRegular(11,
                color: AppColors.textSecondary),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
