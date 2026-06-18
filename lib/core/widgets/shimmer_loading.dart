import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';

/// Shimmer placeholder widgets for premium loading states.
/// Uses dark base color with gold highlight for the Starchitects brand feel.

// ─── Base shimmer wrapper ───────────────────────────────────────────────

/// Wraps any child in a gold-accented shimmer effect
class ShimmerWrapper extends StatelessWidget {
  final Widget child;

  const ShimmerWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surfaceLight,
      highlightColor: AppColors.primary.withValues(alpha: 0.15),
      period: const Duration(milliseconds: 1500),
      child: child,
    );
  }
}

// ─── ShimmerBox ─────────────────────────────────────────────────────────

/// Rectangular shimmer placeholder
class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerBox({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

// ─── ShimmerCircle ──────────────────────────────────────────────────────

/// Circular shimmer placeholder (avatars, icons)
class ShimmerCircle extends StatelessWidget {
  final double size;

  const ShimmerCircle({super.key, this.size = 48.0});

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: AppColors.surfaceLight,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

// ─── ShimmerListTile ────────────────────────────────────────────────────

/// Full list-tile shaped shimmer placeholder
class ShimmerListTile extends StatelessWidget {
  final bool hasLeading;
  final bool hasTrailing;

  const ShimmerListTile({
    super.key,
    this.hasLeading = true,
    this.hasTrailing = false,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            if (hasLeading) ...[
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 14,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 150,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
            if (hasTrailing) ...[
              const SizedBox(width: 12),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── ShimmerCourseCard ──────────────────────────────────────────────────

/// Course card shaped shimmer placeholder with thumbnail, title, and details
class ShimmerCourseCard extends StatelessWidget {
  const ShimmerCourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.glassBorderSubtle),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Container(
                    width: double.infinity,
                    height: 16,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Subtitle
                  Container(
                    width: 120,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Bottom row (price, rating)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 60,
                        height: 14,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceLight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 14,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceLight,
                          borderRadius: BorderRadius.circular(4),
                        ),
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

// ─── ShimmerGrid ────────────────────────────────────────────────────────

/// Grid of course card shimmer placeholders
class ShimmerGrid extends StatelessWidget {
  final int itemCount;
  final int crossAxisCount;
  final double childAspectRatio;

  const ShimmerGrid({
    super.key,
    this.itemCount = 4,
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.72,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) => const ShimmerCourseCard(),
    );
  }
}

// ─── ShimmerList ────────────────────────────────────────────────────────

/// Vertical list of shimmer list tiles
class ShimmerList extends StatelessWidget {
  final int itemCount;
  final bool hasLeading;

  const ShimmerList({
    super.key,
    this.itemCount = 5,
    this.hasLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) => ShimmerListTile(
        hasLeading: hasLeading,
      ),
    );
  }
}
