import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/theme/text_styles.dart';
import 'package:starchitects_app/features/home/presentation/providers/home_provider.dart';
import 'package:starchitects_app/features/home/presentation/widgets/welcome_header.dart';
import 'package:starchitects_app/features/home/presentation/widgets/continue_learning_section.dart';
import 'package:starchitects_app/features/home/presentation/widgets/featured_carousel.dart';
import 'package:starchitects_app/features/home/presentation/widgets/quick_stats_row.dart';

/// Main home screen with scrollable dashboard sections
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future<void> _onRefresh() async {
    // Invalidate all home providers to trigger refresh
    ref.invalidate(dashboardStatsProvider);
    ref.invalidate(continueLearningProvider);
    ref.invalidate(featuredCoursesProvider);

    // Wait for all to complete
    await Future.wait([
      ref.read(dashboardStatsProvider.future),
      ref.read(continueLearningProvider.future),
      ref.read(featuredCoursesProvider.future),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          color: AppColors.primary,
          backgroundColor: AppColors.surface,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              // Top spacing
              const SliverToBoxAdapter(
                child: SizedBox(height: 12),
              ),

              // Welcome header
              const SliverToBoxAdapter(
                child: WelcomeHeader(),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),

              // Continue learning section
              const SliverToBoxAdapter(
                child: ContinueLearningSection(),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 28),
              ),

              // Featured courses carousel
              const SliverToBoxAdapter(
                child: FeaturedCarousel(),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 28),
              ),

              // Quick stats row
              const SliverToBoxAdapter(
                child: QuickStatsRow(),
              ),

              // Bottom padding for bottom nav
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
