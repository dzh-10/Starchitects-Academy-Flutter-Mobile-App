import 'dart:async';
import 'dart:ui';
import 'package:chewie/chewie.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/theme/text_styles.dart';
import 'package:starchitects_app/core/widgets/error_state_widget.dart';
import 'package:starchitects_app/core/widgets/shimmer_loading.dart';
import 'package:starchitects_app/features/courses/data/models/course_model.dart';
import 'package:starchitects_app/features/courses/data/repositories/course_repository.dart';
import 'package:starchitects_app/features/courses/presentation/providers/course_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

/// Video player screen with Chewie player, progress tracking,
/// and lesson navigation
class VideoPlayerScreen extends ConsumerStatefulWidget {
  final String lessonId;
  final String? courseId;

  const VideoPlayerScreen({
    super.key,
    required this.lessonId,
    this.courseId,
  });

  @override
  ConsumerState<VideoPlayerScreen> createState() =>
      _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends ConsumerState<VideoPlayerScreen> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  Timer? _progressTimer;
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorMessage;
  String _lessonTitle = '';

  // Track lessons for next/prev navigation
  List<LessonModel> _lessons = [];
  int _currentLessonIndex = -1;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      // Load lesson list if courseId provided
      if (widget.courseId != null && _lessons.isEmpty) {
        final repo = ref.read(courseRepositoryProvider);
        _lessons = await repo.getCourseLessons(widget.courseId!);
        _currentLessonIndex = _lessons
            .indexWhere((l) => l.id == widget.lessonId);
        if (_currentLessonIndex >= 0) {
          _lessonTitle = _lessons[_currentLessonIndex].title;
        }
      }

      // Fetch video URL
      final repo = ref.read(courseRepositoryProvider);
      final videoUrl = await repo.getLessonVideo(widget.lessonId);

      // Dispose old controllers
      _disposeControllers();

      // Initialize new controllers
      _videoController =
          VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      await _videoController!.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: true,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: AppColors.primary,
          handleColor: AppColors.primaryLight,
          bufferedColor: AppColors.primary.withOpacity(0.3),
          backgroundColor: AppColors.surfaceLight,
        ),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline,
                    color: AppColors.error, size: 48),
                const SizedBox(height: 12),
                Text(
                  'video.playback_error'.tr(),
                  style: AppTextStyles.tajawalRegular(14,
                      color: AppColors.textSecondary),
                ),
              ],
            ),
          );
        },
      );

      // Start progress tracking timer (every 10 seconds)
      _startProgressTracking();

      // Listen for completion
      _videoController!.addListener(_onVideoProgress);

      if (mounted) {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
          _errorMessage = e.toString();
        });
      }
    }
  }

  void _startProgressTracking() {
    _progressTimer?.cancel();
    _progressTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      _reportProgress();
    });
  }

  void _reportProgress() {
    if (_videoController == null || !_videoController!.value.isInitialized) {
      return;
    }

    final duration = _videoController!.value.duration.inSeconds;
    final position = _videoController!.value.position.inSeconds;
    if (duration <= 0) return;

    final progressPercent = (position / duration * 100).clamp(0.0, 100.0);
    ref
        .read(lessonProgressProvider.notifier)
        .updateProgress(widget.lessonId, progressPercent);
  }

  void _onVideoProgress() {
    if (_videoController == null) return;
    final value = _videoController!.value;

    // Auto-advance on completion
    if (value.isInitialized &&
        value.position >= value.duration &&
        value.duration > Duration.zero &&
        !value.isPlaying) {
      // Report 100% progress
      ref
          .read(lessonProgressProvider.notifier)
          .updateProgress(widget.lessonId, 100.0);

      // Auto-advance to next lesson
      _goToNextLesson();
    }
  }

  void _goToNextLesson() {
    if (_lessons.isEmpty || _currentLessonIndex < 0) return;
    final nextIndex = _currentLessonIndex + 1;
    if (nextIndex < _lessons.length && !_lessons[nextIndex].isLocked) {
      _navigateToLesson(nextIndex);
    }
  }

  void _goToPrevLesson() {
    if (_lessons.isEmpty || _currentLessonIndex <= 0) return;
    final prevIndex = _currentLessonIndex - 1;
    if (!_lessons[prevIndex].isLocked) {
      _navigateToLesson(prevIndex);
    }
  }

  void _navigateToLesson(int index) {
    setState(() {
      _currentLessonIndex = index;
      _lessonTitle = _lessons[index].title;
    });
    _disposeControllers();
    _initializeVideoForLesson(_lessons[index].id);
  }

  Future<void> _initializeVideoForLesson(String lessonId) async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final repo = ref.read(courseRepositoryProvider);
      final videoUrl = await repo.getLessonVideo(lessonId);

      _videoController =
          VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      await _videoController!.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: true,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: AppColors.primary,
          handleColor: AppColors.primaryLight,
          bufferedColor: AppColors.primary.withOpacity(0.3),
          backgroundColor: AppColors.surfaceLight,
        ),
      );

      _startProgressTracking();
      _videoController!.addListener(_onVideoProgress);

      if (mounted) setState(() => _isLoading = false);
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
          _errorMessage = e.toString();
        });
      }
    }
  }

  void _disposeControllers() {
    _progressTimer?.cancel();
    _videoController?.removeListener(_onVideoProgress);
    _chewieController?.dispose();
    _videoController?.dispose();
    _chewieController = null;
    _videoController = null;
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    _disposeControllers();
    // Restore portrait orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Video player
            Column(
              children: [
                // Video area
                Expanded(
                  child: _isLoading
                      ? _buildLoadingState()
                      : _hasError
                          ? _buildErrorState()
                          : _chewieController != null
                              ? Chewie(controller: _chewieController!)
                              : _buildLoadingState(),
                ),
                // Bottom controls
                _BottomControls(
                  lessonTitle: _lessonTitle,
                  hasPrevious:
                      _currentLessonIndex > 0 && _lessons.isNotEmpty,
                  hasNext: _currentLessonIndex >= 0 &&
                      _currentLessonIndex < _lessons.length - 1,
                  onPrevious: _goToPrevLesson,
                  onNext: _goToNextLesson,
                ),
              ],
            ),
            // Top overlay with title and back button
            _TopOverlay(
              title: _lessonTitle,
              onBack: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(AppColors.primary),
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'video.loading'.tr(),
            style: AppTextStyles.tajawalRegular(14,
                color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: ErrorStateWidget(
        message: _errorMessage ?? 'video.playback_error'.tr(),
        onRetry: _initializeVideo,
      ),
    );
  }
}

// ─── Top Overlay ─────────────────────────────────────────────────────

class _TopOverlay extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  const _TopOverlay({required this.title, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back_rounded,
                  color: AppColors.textPrimary),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.tajawalMedium(16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Bottom Controls ─────────────────────────────────────────────────

class _BottomControls extends StatelessWidget {
  final String lessonTitle;
  final bool hasPrevious;
  final bool hasNext;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _BottomControls({
    required this.lessonTitle,
    required this.hasPrevious,
    required this.hasNext,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.9),
        border: Border(
          top: BorderSide(
            color: AppColors.glassBorderSubtle,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous lesson
          _NavButton(
            icon: Icons.skip_previous_rounded,
            label: 'video.previous'.tr(),
            enabled: hasPrevious,
            onTap: onPrevious,
          ),
          // Current lesson title
          Expanded(
            child: Text(
              lessonTitle,
              style: AppTextStyles.tajawalMedium(13,
                  color: AppColors.textSecondary),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Next lesson
          _NavButton(
            icon: Icons.skip_next_rounded,
            label: 'video.next'.tr(),
            enabled: hasNext,
            onTap: onNext,
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool enabled;
  final VoidCallback onTap;

  const _NavButton({
    required this.icon,
    required this.label,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.3,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 28,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: AppTextStyles.tajawalMedium(12,
                  color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
