import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/theme/text_styles.dart';
import 'package:starchitects_app/core/widgets/app_button.dart';
import 'package:starchitects_app/core/widgets/cached_avatar.dart';
import 'package:starchitects_app/core/widgets/error_state_widget.dart';
import 'package:starchitects_app/core/widgets/glass_card.dart';
import 'package:starchitects_app/core/widgets/shimmer_loading.dart';
import 'package:starchitects_app/features/courses/data/models/course_model.dart';
import 'package:starchitects_app/features/courses/presentation/providers/course_provider.dart';

/// Course detail screen with hero image, tabs (description, syllabus, reviews),
/// and bottom enrollment CTA
class CourseDetailScreen extends ConsumerStatefulWidget {
  final String courseId;

  const CourseDetailScreen({super.key, required this.courseId});

  @override
  ConsumerState<CourseDetailScreen> createState() =>
      _CourseDetailScreenState();
}

class _CourseDetailScreenState extends ConsumerState<CourseDetailScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseAsync = ref.watch(courseDetailProvider(widget.courseId));
    final enrollState = ref.watch(enrollCourseProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: courseAsync.when(
        data: (course) => _buildContent(context, course, enrollState),
        loading: () => _buildLoading(),
        error: (error, _) => SafeArea(
          child: Center(
            child: ErrorStateWidget(
              message: 'courses.load_error'.tr(),
              onRetry: () {
                ref.invalidate(courseDetailProvider(widget.courseId));
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, CourseModel course, AsyncValue<void> enrollState) {
    final isFreeCourse =
        course.isFree || course.price == null || course.price == 0;
    final isEnrolled = course.isEnrolled ?? false;

    return Stack(
      children: [
        CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Hero Image
            SliverToBoxAdapter(
              child: _HeroSection(course: course),
            ),

            // Course Info
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      course.title,
                      style: AppTextStyles.cairoBold(24),
                    ),
                    const SizedBox(height: 14),

                    // Instructor row
                    Row(
                      children: [
                        CachedAvatar(
                          imageUrl: course.instructor.avatar,
                          size: 36,
                          name: course.instructor.name,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.instructor.name,
                                style: AppTextStyles.tajawalMedium(14),
                              ),
                              if (course.instructor.bio != null)
                                Text(
                                  course.instructor.bio!,
                                  style: AppTextStyles.tajawalRegular(11,
                                      color: AppColors.textTertiary),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
                          ),
                        ),
                        _buildRatingStars(course.rating),
                        const SizedBox(width: 4),
                        Text(
                          course.rating.toStringAsFixed(1),
                          style: AppTextStyles.tajawalBold(14,
                              color: AppColors.primary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Price badge
                    _PriceBadgeLarge(
                        price: course.price, isFree: isFreeCourse),
                    const SizedBox(height: 18),

                    // Stats row
                    _StatsRow(course: course),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Tab bar
            SliverPersistentHeader(
              pinned: true,
              delegate: _TabBarDelegate(
                tabController: _tabController,
              ),
            ),

            // Tab content
            SliverToBoxAdapter(
              child: SizedBox(
                // Dynamic height based on content
                height: MediaQuery.of(context).size.height * 0.6,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _DescriptionTab(description: course.description),
                    _SyllabusTab(courseId: widget.courseId),
                    _ReviewsTab(courseId: widget.courseId),
                  ],
                ),
              ),
            ),

            // Bottom padding for CTA
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),

        // Back button
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 16,
          child: _GlassBackButton(),
        ),

        // Bottom CTA
        if (!isEnrolled)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _BottomCTA(
              course: course,
              isLoading: enrollState.isLoading,
              onEnroll: () {
                ref
                    .read(enrollCourseProvider.notifier)
                    .enroll(widget.courseId);
              },
            ),
          ),
      ],
    );
  }

  Widget _buildRatingStars(double rating) {
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
        return Icon(icon, size: 16, color: AppColors.primary);
      }),
    );
  }

  Widget _buildLoading() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShimmerBox(
                width: double.infinity, height: 220, borderRadius: 0),
            const SizedBox(height: 20),
            const ShimmerBox(width: 250, height: 28, borderRadius: 8),
            const SizedBox(height: 14),
            const ShimmerBox(width: 180, height: 20, borderRadius: 8),
            const SizedBox(height: 18),
            Row(
              children: List.generate(
                3,
                (_) => const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: ShimmerBox(
                      width: double.infinity,
                      height: 60,
                      borderRadius: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Hero Section ────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  final CourseModel course;

  const _HeroSection({required this.course});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (course.thumbnail != null && course.thumbnail!.isNotEmpty)
            CachedNetworkImage(
              imageUrl: course.thumbnail!,
              fit: BoxFit.cover,
              placeholder: (_, __) =>
                  Container(color: AppColors.surfaceLight),
              errorWidget: (_, __, ___) =>
                  Container(color: AppColors.surfaceLight),
            )
          else
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.2),
                    AppColors.surfaceLight,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.school_rounded,
                  size: 64,
                  color: AppColors.primary.withOpacity(0.4),
                ),
              ),
            ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.background.withOpacity(0.5),
                  AppColors.background,
                ],
                stops: const [0.0, 0.6, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Play button center
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(
                    color: AppColors.primary.withOpacity(0.5), width: 2),
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: AppColors.primary,
                size: 36,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Glass Back Button ───────────────────────────────────────────────

class _GlassBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.radiusMD),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(AppSizes.radiusMD),
            border: Border.all(
                color: AppColors.glassBorderSubtle, width: 0.5),
          ),
          child: GestureDetector(
            onTap: () => context.pop(),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.textPrimary,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Price Badge Large ───────────────────────────────────────────────

class _PriceBadgeLarge extends StatelessWidget {
  final double? price;
  final bool isFree;

  const _PriceBadgeLarge({this.price, required this.isFree});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: isFree
            ? AppColors.freeBadge.withOpacity(0.15)
            : AppColors.paidBadge.withOpacity(0.15),
        borderRadius: BorderRadius.circular(AppSizes.radiusRound),
        border: Border.all(
          color: isFree
              ? AppColors.freeBadge.withOpacity(0.5)
              : AppColors.paidBadge.withOpacity(0.5),
        ),
      ),
      child: Text(
        isFree
            ? 'courses.free'.tr()
            : '${price?.toStringAsFixed(0) ?? '0'} ${'courses.currency_full'.tr()}',
        style: AppTextStyles.tajawalBold(
          16,
          color: isFree ? AppColors.freeBadge : AppColors.paidBadge,
        ),
      ),
    );
  }
}

// ─── Stats Row ───────────────────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  final CourseModel course;

  const _StatsRow({required this.course});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatItem(
          icon: Icons.people_outline,
          value: '${course.studentsCount}',
          label: 'courses.students'.tr(),
        ),
        const SizedBox(width: 20),
        _StatItem(
          icon: Icons.play_lesson_outlined,
          value: '${course.lessonsCount}',
          label: 'courses.lessons'.tr(),
        ),
        const SizedBox(width: 20),
        _StatItem(
          icon: Icons.star_outline_rounded,
          value: course.rating.toStringAsFixed(1),
          label: 'courses.rating'.tr(),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: AppTextStyles.tajawalBold(14)),
              Text(
                label,
                style: AppTextStyles.tajawalRegular(10,
                    color: AppColors.textTertiary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Tab Bar Delegate ────────────────────────────────────────────────

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabController tabController;

  _TabBarDelegate({required this.tabController});

  @override
  double get minExtent => 56;
  @override
  double get maxExtent => 56;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.background,
      child: TabBar(
        controller: tabController,
        indicatorColor: AppColors.primary,
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: AppTextStyles.tajawalBold(14),
        unselectedLabelStyle: AppTextStyles.tajawalRegular(14),
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textTertiary,
        dividerColor: AppColors.glassBorderSubtle,
        tabs: [
          Tab(text: 'courses.tab_description'.tr()),
          Tab(text: 'courses.tab_syllabus'.tr()),
          Tab(text: 'courses.tab_reviews'.tr()),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _TabBarDelegate oldDelegate) => false;
}

// ─── Description Tab ─────────────────────────────────────────────────

class _DescriptionTab extends StatelessWidget {
  final String description;

  const _DescriptionTab({required this.description});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      physics: const NeverScrollableScrollPhysics(),
      child: Text(
        description.isNotEmpty
            ? description
            : 'courses.no_description'.tr(),
        style: AppTextStyles.tajawalRegular(15,
            color: AppColors.textSecondary),
        textDirection: TextDirection.rtl,
      ),
    );
  }
}

// ─── Syllabus Tab ────────────────────────────────────────────────────

class _SyllabusTab extends ConsumerWidget {
  final String courseId;

  const _SyllabusTab({required this.courseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonsAsync = ref.watch(courseLessonsProvider(courseId));

    return lessonsAsync.when(
      data: (lessons) {
        if (lessons.isEmpty) {
          return Center(
            child: Text(
              'courses.no_lessons'.tr(),
              style: AppTextStyles.tajawalRegular(14,
                  color: AppColors.textTertiary),
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(20),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: lessons.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final lesson = lessons[index];
            return _LessonTile(
              lesson: lesson,
              number: index + 1,
              onTap: lesson.isLocked
                  ? null
                  : () {
                      context.push('/lessons/${lesson.id}/video');
                    },
            );
          },
        );
      },
      loading: () => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: List.generate(
            5,
            (_) => const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: ShimmerBox(
                width: double.infinity,
                height: 64,
                borderRadius: 12,
              ),
            ),
          ),
        ),
      ),
      error: (error, _) => Center(
        child: ErrorStateWidget(
          message: 'courses.load_error'.tr(),
          onRetry: () =>
              ref.invalidate(courseLessonsProvider(courseId)),
        ),
      ),
    );
  }
}

class _LessonTile extends StatelessWidget {
  final LessonModel lesson;
  final int number;
  final VoidCallback? onTap;

  const _LessonTile({
    required this.lesson,
    required this.number,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            // Lesson number
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: lesson.isCompleted
                    ? AppColors.success.withOpacity(0.15)
                    : lesson.isLocked
                        ? AppColors.surfaceLight
                        : AppColors.primary.withOpacity(0.12),
                borderRadius:
                    BorderRadius.circular(AppSizes.radiusSM),
              ),
              child: Center(
                child: lesson.isCompleted
                    ? const Icon(Icons.check_rounded,
                        color: AppColors.success, size: 18)
                    : lesson.isLocked
                        ? const Icon(Icons.lock_outline,
                            color: AppColors.textTertiary, size: 16)
                        : Text(
                            '$number',
                            style: AppTextStyles.tajawalBold(13,
                                color: AppColors.primary),
                          ),
              ),
            ),
            const SizedBox(width: 12),
            // Title & duration
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson.title,
                    style: AppTextStyles.tajawalMedium(
                      14,
                      color: lesson.isLocked
                          ? AppColors.textTertiary
                          : AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${lesson.durationMinutes} ${'courses.minutes'.tr()}',
                    style: AppTextStyles.tajawalRegular(11,
                        color: AppColors.textTertiary),
                  ),
                ],
              ),
            ),
            // Play/Lock icon
            Icon(
              lesson.isLocked
                  ? Icons.lock_outline
                  : Icons.play_circle_outline,
              color: lesson.isLocked
                  ? AppColors.textTertiary
                  : AppColors.primary,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Reviews Tab ─────────────────────────────────────────────────────

class _ReviewsTab extends ConsumerWidget {
  final String courseId;

  const _ReviewsTab({required this.courseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(courseReviewsProvider(courseId));

    return reviewsAsync.when(
      data: (reviews) {
        if (reviews.isEmpty) {
          return Center(
            child: Text(
              'courses.no_reviews'.tr(),
              style: AppTextStyles.tajawalRegular(14,
                  color: AppColors.textTertiary),
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(20),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: reviews.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) =>
              _ReviewCard(review: reviews[index]),
        );
      },
      loading: () => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: List.generate(
            3,
            (_) => const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: ShimmerBox(
                width: double.infinity,
                height: 100,
                borderRadius: 12,
              ),
            ),
          ),
        ),
      ),
      error: (error, _) => Center(
        child: ErrorStateWidget(
          message: 'courses.load_error'.tr(),
          onRetry: () =>
              ref.invalidate(courseReviewsProvider(courseId)),
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final ReviewModel review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CachedAvatar(
                imageUrl: review.userAvatar,
                size: 36,
                name: review.userName,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      style: AppTextStyles.tajawalMedium(14),
                    ),
                    Text(
                      _formatDate(review.createdAt),
                      style: AppTextStyles.tajawalRegular(11,
                          color: AppColors.textTertiary),
                    ),
                  ],
                ),
              ),
              // Rating
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  return Icon(
                    index < review.rating.round()
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    size: 14,
                    color: AppColors.primary,
                  );
                }),
              ),
            ],
          ),
          if (review.comment != null && review.comment!.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              review.comment!,
              style: AppTextStyles.tajawalRegular(13,
                  color: AppColors.textSecondary),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) return 'courses.today'.tr();
    if (diff.inDays == 1) return 'courses.yesterday'.tr();
    if (diff.inDays < 30) {
      return '${'courses.days_ago_prefix'.tr()} ${diff.inDays} ${'courses.days_ago_suffix'.tr()}';
    }
    return '${date.day}/${date.month}/${date.year}';
  }
}

// ─── Bottom CTA ──────────────────────────────────────────────────────

class _BottomCTA extends StatelessWidget {
  final CourseModel course;
  final bool isLoading;
  final VoidCallback onEnroll;

  const _BottomCTA({
    required this.course,
    required this.isLoading,
    required this.onEnroll,
  });

  @override
  Widget build(BuildContext context) {
    final isFreeCourse =
        course.isFree || course.price == null || course.price == 0;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: EdgeInsets.fromLTRB(
            20,
            16,
            20,
            MediaQuery.of(context).padding.bottom + 16,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface.withOpacity(0.85),
            border: Border(
              top: BorderSide(
                color: AppColors.glassBorderSubtle,
                width: 0.5,
              ),
            ),
          ),
          child: AppButton(
            onPressed: isLoading ? null : onEnroll,
            isLoading: isLoading,
            text: isFreeCourse
                ? 'courses.enroll_free'.tr()
                : '${'courses.buy_course'.tr()} - ${course.price?.toStringAsFixed(0) ?? '0'} ${'courses.currency_full'.tr()}',
          ),
        ),
      ),
    );
  }
}
