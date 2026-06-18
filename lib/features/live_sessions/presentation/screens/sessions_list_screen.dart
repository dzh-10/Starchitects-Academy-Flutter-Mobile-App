import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/widgets/empty_state_widget.dart';
import 'package:starchitects_app/core/widgets/error_state_widget.dart';
import 'package:starchitects_app/core/widgets/shimmer_loading.dart';
import 'package:starchitects_app/features/live_sessions/presentation/providers/live_session_provider.dart';
import 'package:starchitects_app/features/live_sessions/presentation/widgets/session_card.dart';

/// Sessions list screen with tabs for Upcoming and Live Now.
class SessionsListScreen extends ConsumerStatefulWidget {
  const SessionsListScreen({super.key});

  @override
  ConsumerState<SessionsListScreen> createState() =>
      _SessionsListScreenState();
}

class _SessionsListScreenState extends ConsumerState<SessionsListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'live_sessions.title'.tr(),
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: _buildTabBar(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _UpcomingTab(),
          _LiveNowTab(),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: AppColors.textOnPrimary,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: GoogleFonts.cairo(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: GoogleFonts.cairo(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        tabs: [
          Tab(text: 'live_sessions.upcoming'.tr()),
          Tab(text: 'live_sessions.live_now'.tr()),
        ],
      ),
    );
  }
}

/// Tab showing upcoming sessions.
class _UpcomingTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(upcomingSessionsProvider);

    return sessionsAsync.when(
      loading: () => _buildShimmerList(),
      error: (error, stack) => ErrorStateWidget(
        message: error.toString(),
        onRetry: () => ref.invalidate(upcomingSessionsProvider),
      ),
      data: (sessions) {
        if (sessions.isEmpty) {
          return EmptyStateWidget(
            icon: Icons.event_note_rounded,
            title: 'live_sessions.no_upcoming'.tr(),
            subtitle: 'live_sessions.no_upcoming_subtitle'.tr(),
          );
        }

        return RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: AppColors.surface,
          onRefresh: () async {
            ref.invalidate(upcomingSessionsProvider);
          },
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              return SessionCard(
                session: session,
                onTap: () {
                  // Could navigate to session detail
                },
              );
            },
          ),
        );
      },
    );
  }
}

/// Tab showing currently live sessions.
class _LiveNowTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(liveSessionsProvider);

    return sessionsAsync.when(
      loading: () => _buildShimmerList(),
      error: (error, stack) => ErrorStateWidget(
        message: error.toString(),
        onRetry: () => ref.invalidate(liveSessionsProvider),
      ),
      data: (sessions) {
        if (sessions.isEmpty) {
          return EmptyStateWidget(
            icon: Icons.videocam_off_rounded,
            title: 'live_sessions.no_live'.tr(),
            subtitle: 'live_sessions.no_live_subtitle'.tr(),
          );
        }

        return RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: AppColors.surface,
          onRefresh: () async {
            ref.invalidate(liveSessionsProvider);
          },
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              return SessionCard(
                session: session,
                onJoin: () {
                  context.push('/live-room/${session.id}');
                },
              );
            },
          ),
        );
      },
    );
  }
}

/// Shimmer loading placeholder for the session list.
Widget _buildShimmerList() {
  return ListView.builder(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    itemCount: 4,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: ShimmerWrapper(
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.glassBorderSubtle),
            ),
          ),
        ),
      );
    },
  );
}
