import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/theme/text_styles.dart';
import 'package:starchitects_app/core/widgets/empty_state_widget.dart';
import 'package:starchitects_app/core/widgets/glass_card.dart';
import 'package:starchitects_app/core/widgets/shimmer_loading.dart';
import 'package:starchitects_app/features/home/data/models/dashboard_model.dart';
import 'package:starchitects_app/features/home/presentation/providers/home_provider.dart';

/// Horizontal scrolling section showing courses the student should continue
class ContinueLearningSection extends ConsumerWidget {
  const ContinueLearningSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final continueLearningAsync = ref.watch(continueLearningProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'home.continue_learning'.tr(),
                style: AppTextStyles.cairoSemiBold(18),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to my courses
                },
                child: Text(
                  'home.view_all'.tr(),
                  style: AppTextStyles.tajawalMedium(14,
                      color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Content
        continueLearningAsync.when(
          data: (items) {
            if (items.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: EmptyStateWidget(
                  icon: Icons.school_outlined,
                  title: 'home.no_courses_title'.tr(),
                  subtitle: 'home.no_courses_subtitle'.tr(),
                ),
              );
            }
            return SizedBox(
              height: 195,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (context, index) =>
                    _ContinueLearningCard(item: items[index]),
              ),
            );
          },
          loading: () => _buildShimmer(),
          error: (_, __) => _buildShimmer(),
        ),
      ],
    );
  }

  Widget _buildShimmer() {
    return SizedBox(
      height: 195,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: 3,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (_, __) => const ShimmerBox(
          width: 260,
          height: 195,
          borderRadius: AppSizes.radiusLG,
        ),
      ),
    );
  }
}

class _ContinueLearningCard extends StatelessWidget {
  final ContinueLearningItem item;

  const _ContinueLearningCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final progressClamped = item.progressPercent.clamp(0.0, 1.0);

    return GestureDetector(
      onTap: () {
        context.push('/courses/${item.courseId}');
      },
      child: SizedBox(
        width: 260,
        child: GlassCard(
          padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppSizes.radiusLG),
              ),
              child: SizedBox(
                height: 90,
                width: double.infinity,
                child: item.courseThumbnail.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: item.courseThumbnail,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(
                          color: AppColors.surfaceLight,
                        ),
                        errorWidget: (_, __, ___) => Container(
                          color: AppColors.surfaceLight,
                          child: const Icon(Icons.image_outlined,
                              color: AppColors.textTertiary, size: 32),
                        ),
                      )
                    : Container(
                        color: AppColors.surfaceLight,
                        child: Center(
                          child: Icon(
                            Icons.play_circle_outline,
                            color: AppColors.primary.withOpacity(0.5),
                            size: 40,
                          ),
                        ),
                      ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.courseTitle,
                    style: AppTextStyles.tajawalBold(14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.lastLessonTitle,
                    style: AppTextStyles.tajawalRegular(12,
                        color: AppColors.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  // Progress bar
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusRound),
                          child: LinearProgressIndicator(
                            value: progressClamped,
                            minHeight: 6,
                            backgroundColor:
                                AppColors.surfaceLight,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.primary),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${(progressClamped * 100).toInt()}%',
                        style: AppTextStyles.tajawalBold(12,
                            color: AppColors.primary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
