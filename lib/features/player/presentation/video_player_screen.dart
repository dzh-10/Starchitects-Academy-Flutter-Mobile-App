import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../../../core/constants/app_colors.dart';
import '../domain/player_provider.dart';

class VideoPlayerScreen extends ConsumerStatefulWidget {
  final String lessonId;
  const VideoPlayerScreen({super.key, required this.lessonId});

  @override
  ConsumerState<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends ConsumerState<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  Timer? _progressTimer;
  int _lastSavedSeconds = 0;

  @override
  void initState() {
    super.initState();
    _setupPlayer();
  }

  Future<void> _setupPlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse('https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
    );

    await _videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: AppColors.kGold,
        handleColor: AppColors.kGold,
        backgroundColor: AppColors.kBgPrimary,
        bufferedColor: Colors.white24,
      ),
    );

    setState(() {});
    _startProgressTimer();
  }

  void _startProgressTimer() {
    _progressTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_videoPlayerController.value.isInitialized) {
        final position = _videoPlayerController.value.position;
        final duration = _videoPlayerController.value.duration;
        
        if (duration.inSeconds > 0) {
          final secondsWatched = position.inSeconds;
          final isCompleted = secondsWatched >= (duration.inSeconds * 0.9); // 90% watched
          
          if (secondsWatched > _lastSavedSeconds) {
            _lastSavedSeconds = secondsWatched;
            ref.read(playerNotifierProvider.notifier).saveProgress(
              int.parse(widget.lessonId),
              secondsWatched,
              isCompleted,
            );
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: Chewie(controller: _chewieController!),
                  )
                : const CircularProgressIndicator(color: AppColors.kGold),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => context.pop(),
            ),
          ),
        ],
      ),
    );
  }
}
