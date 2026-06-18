import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/widgets/empty_state_widget.dart';
import 'package:starchitects_app/core/widgets/error_state_widget.dart';
import 'package:starchitects_app/core/widgets/glass_card.dart';
import 'package:starchitects_app/core/widgets/shimmer_loading.dart';
import 'package:starchitects_app/features/progress/data/models/progress_model.dart';
import 'package:starchitects_app/features/progress/presentation/providers/progress_provider.dart';

/// Student progress dashboard with radial chart, weekly activity
/// bar chart, and per-course progress list.
class ProgressDashboardScreen extends ConsumerWidget {
  const ProgressDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressAsync = ref.watch(overallProgressProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'progress.title'.tr(),
          style: GoogleFonts.cairo(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: progressAsync.when(
        loading: () => _buildShimmerDashboard(),
        error: (error, stack) => ErrorStateWidget(
          message: error.toString(),
          onRetry: () => ref.invalidate(overallProgressProvider),
        ),
        data: (progress) {
          if (progress.totalCourses == 0) {
            return EmptyStateWidget(
              icon: Icons.school_rounded,
              title: 'progress.no_progress'.tr(),
              subtitle: 'progress.no_progress_subtitle'.tr(),
              actionText: 'progress.browse_courses'.tr(),
              actionIcon: Icons.explore_rounded,
              onAction: () => context.push('/courses'),
            );
          }

          return RefreshIndicator(
            color: AppColors.primary,
            backgroundColor: AppColors.surface,
            onRefresh: () async {
              ref.invalidate(overallProgressProvider);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // ── Overall Progress Radial Chart ──
                  _OverallProgressChart(progress: progress),
                  const SizedBox(height: 24),

                  // ── Stats Row ──
                  _StatsRow(progress: progress),
                  const SizedBox(height: 28),

                  // ── Weekly Activity Chart ──
                  _SectionTitle(title: 'progress.weekly_activity'.tr()),
                  const SizedBox(height: 12),
                  _WeeklyHoursChart(weeklyHours: progress.weeklyHours),
                  const SizedBox(height: 28),

                  // ── Course Progress List ──
                  _SectionTitle(title: 'progress.course_progress'.tr()),
                  const SizedBox(height: 12),
                  ...progress.courseProgress.map(
                    (course) => _CourseProgressCard(course: course),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─── Overall Progress Radial Chart ──────────────────────────────────────────

class _OverallProgressChart extends StatelessWidget {
  final OverallProgress progress;

  const _OverallProgressChart({required this.progress});

  @override
  Widget build(BuildContext context) {
    final percent = progress.overallPercent.clamp(0.0, 100.0);

    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'progress.overall'.tr(),
            style: GoogleFonts.cairo(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            width: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    startDegreeOffset: -90,
                    sectionsSpace: 0,
                    centerSpaceRadius: 70,
                    sections: [
                      PieChartSectionData(
                        value: percent,
                        color: AppColors.primary,
                        radius: 22,
                        showTitle: false,
                        gradient: AppColors.primaryGradient,
                      ),
                      PieChartSectionData(
                        value: (100 - percent).clamp(0.0, 100.0),
                        color: AppColors.surfaceLight,
                        radius: 18,
                        showTitle: false,
                      ),
                    ],
                  ),
                ),
                // Center percentage text
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${percent.toStringAsFixed(0)}%',
                      style: GoogleFonts.cairo(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      'progress.overall_label'.tr(),
                      style: GoogleFonts.tajawal(
                        fontSize: 12,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Stats Row ──────────────────────────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  final OverallProgress progress;

  const _StatsRow({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.school_rounded,
            value: '${progress.completedCourses}/${progress.totalCourses}',
            label: 'progress.courses'.tr(),
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: Icons.play_lesson_rounded,
            value: '${progress.completedLessons}/${progress.totalLessons}',
            label: 'progress.lessons'.tr(),
            color: AppColors.success,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 22, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: GoogleFonts.cairo(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  label,
                  style: GoogleFonts.tajawal(
                    fontSize: 12,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Weekly Hours Bar Chart ──────────────────────────────────────────────────

class _WeeklyHoursChart extends StatelessWidget {
  final List<double> weeklyHours;

  const _WeeklyHoursChart({required this.weeklyHours});

  static const List<String> _arabicDays = [
    'سبت',
    'أحد',
    'إثنين',
    'ثلاثاء',
    'أربعاء',
    'خميس',
    'جمعة',
  ];

  @override
  Widget build(BuildContext context) {
    // Ensure we have 7 values, pad with zeros
    final hours = List<double>.generate(
      7,
      (i) => i < weeklyHours.length ? weeklyHours[i] : 0.0,
    );

    final maxY = (hours.reduce(math.max) * 1.3).clamp(1.0, double.infinity);

    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 200,
        child: BarChart(
          BarChartData(
            maxY: maxY,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: maxY / 4,
              getDrawingHorizontalLine: (value) => FlLine(
                color: AppColors.surfaceElevated,
                strokeWidth: 0.5,
              ),
            ),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              show: true,
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 36,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '${value.toStringAsFixed(0)}h',
                      style: GoogleFonts.tajawal(
                        fontSize: 10,
                        color: AppColors.textTertiary,
                      ),
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index < 0 || index >= _arabicDays.length) {
                      return const SizedBox.shrink();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        _arabicDays[index],
                        style: GoogleFonts.tajawal(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            barGroups: List.generate(7, (index) {
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: hours[index],
                    width: 22,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(6),
                    ),
                    gradient: hours[index] > 0
                        ? AppColors.primaryGradient
                        : null,
                    color: hours[index] > 0
                        ? null
                        : AppColors.surfaceElevated,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ─── Course Progress Card ───────────────────────────────────────────────────

class _CourseProgressCard extends StatelessWidget {
  final CourseProgressItem course;

  const _CourseProgressCard({required this.course});

  @override
  Widget build(BuildContext context) {
    final percent = course.progressPercent.clamp(0.0, 100.0);

    return GlassCard(
      onTap: () {
        context.push('/courses/${course.courseId}');
      },
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          // ── Course Thumbnail ──
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 64,
              height: 64,
              color: AppColors.surfaceLight,
              child: course.courseThumbnail != null &&
                      course.courseThumbnail!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: course.courseThumbnail!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppColors.surfaceLight,
                        child: const Center(
                          child: Icon(
                            Icons.school_rounded,
                            color: AppColors.textTertiary,
                            size: 24,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.surfaceLight,
                        child: const Center(
                          child: Icon(
                            Icons.school_rounded,
                            color: AppColors.textTertiary,
                            size: 24,
                          ),
                        ),
                      ),
                    )
                  : const Center(
                      child: Icon(
                        Icons.school_rounded,
                        color: AppColors.textTertiary,
                        size: 28,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 14),

          // ── Course Info ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.courseTitle,
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // Lesson count
                Text(
                  'progress.lessons_count'.tr(namedArgs: {
                    'completed': '${course.completedLessons}',
                    'total': '${course.totalLessons}',
                  }),
                  style: GoogleFonts.tajawal(
                    fontSize: 12,
                    color: AppColors.textTertiary,
                  ),
                ),
                const SizedBox(height: 8),
                // Progress bar
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: percent / 100,
                          minHeight: 6,
                          backgroundColor: AppColors.surfaceLight,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            percent >= 100
                                ? AppColors.success
                                : AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${percent.toStringAsFixed(0)}%',
                      style: GoogleFonts.cairo(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: percent >= 100
                            ? AppColors.success
                            : AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Chevron ──
          const SizedBox(width: 8),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: AppColors.textTertiary,
          ),
        ],
      ),
    );
  }
}

// ─── Section Title ──────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

// ─── Shimmer Dashboard ──────────────────────────────────────────────────────

Widget _buildShimmerDashboard() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        // Radial chart placeholder
        ShimmerWrapper(
          child: Container(
            height: 280,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Stats row
        Row(
          children: [
            Expanded(
              child: ShimmerBox(height: 80, borderRadius: 16),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ShimmerBox(height: 80, borderRadius: 16),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Section title shimmer
        ShimmerBox(height: 20, width: 150, borderRadius: 4),
        const SizedBox(height: 12),
        // Weekly chart placeholder
        ShimmerWrapper(
          child: Container(
            height: 240,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Course cards shimmer
        ShimmerBox(height: 20, width: 150, borderRadius: 4),
        const SizedBox(height: 12),
        ...List.generate(
          3,
          (_) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ShimmerWrapper(
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
