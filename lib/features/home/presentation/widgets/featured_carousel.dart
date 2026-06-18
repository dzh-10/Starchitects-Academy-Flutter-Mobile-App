import 'dart:async';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/theme/text_styles.dart';
import 'package:starchitects_app/core/widgets/shimmer_loading.dart';
import 'package:starchitects_app/features/home/data/models/dashboard_model.dart';
import 'package:starchitects_app/features/home/presentation/providers/home_provider.dart';

/// Auto-scrolling featured courses carousel with glassmorphism overlay and dot indicators
class FeaturedCarousel extends ConsumerStatefulWidget {
  const FeaturedCarousel({super.key});

  @override
  ConsumerState<FeaturedCarousel> createState() => _FeaturedCarouselState();
}

class _FeaturedCarouselState extends ConsumerState<FeaturedCarousel> {
  late final PageController _pageController;
  Timer? _autoScrollTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
  }

  void _startAutoScroll(int totalPages) {
    _autoScrollTimer?.cancel();
    if (totalPages <= 1) return;
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      final nextPage = (_currentPage + 1) % totalPages;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final featuredAsync = ref.watch(featuredCoursesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'home.featured_courses'.tr(),
            style: AppTextStyles.cairoSemiBold(18),
          ),
        ),
        const SizedBox(height: 14),
        featuredAsync.when(
          data: (courses) {
            if (courses.isEmpty) return const SizedBox.shrink();
            // Start auto-scroll after data arrives
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _startAutoScroll(courses.length);
            });
            return Column(
              children: [
                SizedBox(
                  height: 220,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: courses.length,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemBuilder: (context, index) =>
                        _FeaturedCourseCard(course: courses[index]),
                  ),
                ),
                const SizedBox(height: 14),
                // Dot indicators
                _DotIndicators(
                  count: courses.length,
                  currentIndex: _currentPage,
                ),
              ],
            );
          },
          loading: () => _buildShimmer(),
          error: (_, __) => _buildShimmer(),
        ),
      ],
    );
  }

  Widget _buildShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ShimmerBox(
        width: double.infinity,
        height: 220,
        borderRadius: AppSizes.radiusLG,
      ),
    );
  }
}

class _FeaturedCourseCard extends StatelessWidget {
  final FeaturedCourse course;

  const _FeaturedCourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/courses/${course.id}'),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radiusXL),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.radiusXL),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              course.thumbnail.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: course.thumbnail,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        color: AppColors.surfaceLight,
                      ),
                      errorWidget: (_, __, ___) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.surfaceLight,
                              AppColors.surface,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.2),
                            AppColors.surfaceLight,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.85),
                    ],
                    stops: const [0.0, 0.45, 1.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              // Glassmorphism bottom overlay
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.25),
                        border: Border(
                          top: BorderSide(
                            color: AppColors.primary.withOpacity(0.2),
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Title
                          Text(
                            course.title,
                            style: AppTextStyles.cairoBold(18),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          // Instructor & rating row
                          Row(
                            children: [
                              Icon(
                                Icons.person_outline,
                                size: 16,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  course.instructorName,
                                  style: AppTextStyles.tajawalRegular(13,
                                      color: AppColors.textSecondary),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Rating stars
                              _RatingStars(rating: course.rating),
                              const SizedBox(width: 4),
                              Text(
                                course.rating.toStringAsFixed(1),
                                style: AppTextStyles.tajawalBold(12,
                                    color: AppColors.primary),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Price badge + students
                          Row(
                            children: [
                              _PriceBadge(
                                price: course.price,
                                isFree: course.isFree,
                              ),
                              const Spacer(),
                              Icon(Icons.people_outline,
                                  size: 15,
                                  color: AppColors.textTertiary),
                              const SizedBox(width: 4),
                              Text(
                                '${course.studentsCount} ${'home.students'.tr()}',
                                style: AppTextStyles.tajawalRegular(12,
                                    color: AppColors.textTertiary),
                              ),
                            ],
                          ),
                        ],
                      ),
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

class _RatingStars extends StatelessWidget {
  final double rating;

  const _RatingStars({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starValue = index + 1;
        IconData icon;
        if (rating >= starValue) {
          icon = Icons.star_rounded;
        } else if (rating >= starValue - 0.5) {
          icon = Icons.star_half_rounded;
        } else {
          icon = Icons.star_outline_rounded;
        }
        return Icon(icon, size: 14, color: AppColors.primary);
      }),
    );
  }
}

class _PriceBadge extends StatelessWidget {
  final double? price;
  final bool isFree;

  const _PriceBadge({this.price, required this.isFree});

  @override
  Widget build(BuildContext context) {
    final isFreeCourse = isFree || price == null || price == 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isFreeCourse
            ? AppColors.freeBadge.withOpacity(0.2)
            : AppColors.paidBadge.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppSizes.radiusRound),
        border: Border.all(
          color: isFreeCourse
              ? AppColors.freeBadge.withOpacity(0.5)
              : AppColors.paidBadge.withOpacity(0.5),
          width: 0.5,
        ),
      ),
      child: Text(
        isFreeCourse
            ? 'courses.free'.tr()
            : '${price!.toStringAsFixed(0)} ${'courses.currency'.tr()}',
        style: AppTextStyles.tajawalBold(11,
            color: isFreeCourse ? AppColors.freeBadge : AppColors.paidBadge),
      ),
    );
  }
}

class _DotIndicators extends StatelessWidget {
  final int count;
  final int currentIndex;

  const _DotIndicators({required this.count, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primary
                : AppColors.textTertiary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(AppSizes.radiusRound),
          ),
        );
      }),
    );
  }
}
