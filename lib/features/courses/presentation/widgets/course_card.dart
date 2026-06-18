import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/theme/text_styles.dart';
import 'package:starchitects_app/core/widgets/glass_card.dart';
import 'package:starchitects_app/features/courses/data/models/course_model.dart';

/// Reusable course card for the catalog grid
class CourseCard extends StatelessWidget {
  final CourseModel course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final isFreeCourse =
        course.isFree || course.price == null || course.price == 0;

    return GestureDetector(
      onTap: () => context.push('/courses/${course.id}'),
      child: GlassCard(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail with badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppSizes.radiusLG),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 10,
                    child: course.thumbnail != null &&
                            course.thumbnail!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: course.thumbnail!,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => Container(
                              color: AppColors.surfaceLight,
                              child: Center(
                                child: Icon(
                                  Icons.play_circle_outline,
                                  color: AppColors.primary.withOpacity(0.3),
                                  size: 32,
                                ),
                              ),
                            ),
                            errorWidget: (_, __, ___) => Container(
                              color: AppColors.surfaceLight,
                              child: const Icon(Icons.image_outlined,
                                  color: AppColors.textTertiary, size: 28),
                            ),
                          )
                        : Container(
                            color: AppColors.surfaceLight,
                            child: Center(
                              child: Icon(
                                Icons.school_outlined,
                                color: AppColors.primary.withOpacity(0.4),
                                size: 36,
                              ),
                            ),
                          ),
                  ),
                ),
                // Free/Paid badge
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isFreeCourse
                          ? AppColors.freeBadge
                          : AppColors.paidBadge,
                      borderRadius: BorderRadius.circular(AppSizes.radiusRound),
                      boxShadow: [
                        BoxShadow(
                          color: (isFreeCourse
                                  ? AppColors.freeBadge
                                  : AppColors.paidBadge)
                              .withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      isFreeCourse
                          ? 'courses.free'.tr()
                          : '${course.price!.toStringAsFixed(0)} ${'courses.currency'.tr()}',
                      style: AppTextStyles.tajawalBold(10,
                          color: isFreeCourse
                              ? Colors.white
                              : AppColors.textOnPrimary),
                    ),
                  ),
                ),
              ],
            ),
            // Content
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    course.title,
                    style: AppTextStyles.tajawalBold(14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  // Instructor
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 14,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          course.instructor.name,
                          style: AppTextStyles.tajawalRegular(12,
                              color: AppColors.textSecondary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Rating & count
                  Row(
                    children: [
                      // Stars
                      ...List.generate(5, (index) {
                        final starValue = index + 1;
                        IconData icon;
                        if (course.rating >= starValue) {
                          icon = Icons.star_rounded;
                        } else if (course.rating >= starValue - 0.5) {
                          icon = Icons.star_half_rounded;
                        } else {
                          icon = Icons.star_outline_rounded;
                        }
                        return Icon(icon, size: 14, color: AppColors.primary);
                      }),
                      const SizedBox(width: 6),
                      Text(
                        course.rating.toStringAsFixed(1),
                        style: AppTextStyles.tajawalBold(11,
                            color: AppColors.primary),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${course.ratingsCount})',
                        style: AppTextStyles.tajawalRegular(10,
                            color: AppColors.textTertiary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
