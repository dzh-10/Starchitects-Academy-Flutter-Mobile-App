import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:starchitects_app/features/live_sessions/presentation/providers/live_session_provider.dart';
import 'package:starchitects_app/features/live_sessions/presentation/widgets/controls_bar.dart';

/// LiveKit live room screen — handles permissions, room connection,
/// video rendering, and call controls.
class LiveRoomScreen extends ConsumerStatefulWidget {
  final String sessionId;

  const LiveRoomScreen({super.key, required this.sessionId});

  @override
  ConsumerState<LiveRoomScreen> createState() => _LiveRoomScreenState();
}

class _LiveRoomScreenState extends ConsumerState<LiveRoomScreen> {
  Room? _room;
  EventsListener<RoomEvent>? _roomListener;
  LocalParticipant? _localParticipant;
  List<RemoteParticipant> _remoteParticipants = [];

  bool _isConnecting = true;
  bool _isReconnecting = false;
  bool _isMicEnabled = true;
  bool _isCameraEnabled = true;
  String? _errorMessage;
  String _sessionTitle = '';

  // PiP drag position
  Offset _pipOffset = const Offset(16, 80);

  @override
  void initState() {
    super.initState();
    _initializeRoom();
  }

  Future<void> _initializeRoom() async {
    try {
      // 1. Request permissions
      final cameraStatus = await Permission.camera.request();
      final micStatus = await Permission.microphone.request();

      if (cameraStatus.isDenied || micStatus.isDenied) {
        setState(() {
          _errorMessage = 'live_sessions.permissions_required'.tr();
          _isConnecting = false;
        });
        return;
      }

      // 2. Fetch LiveKit token
      final tokenResponse = await ref.read(
        sessionTokenProvider(widget.sessionId).future,
      );

      // 3. Create room and connect
      final room = Room(
        roomOptions: const RoomOptions(
          adaptiveStream: true,
          dynacast: true,
          defaultVideoPublishOptions: VideoPublishOptions(
            simulcast: true,
          ),
        ),
      );

      // 4. Listen to room events
      _roomListener = room.createListener();
      _setupRoomListeners();

      // 5. Connect
      await room.connect(
        tokenResponse.url,
        tokenResponse.token,
        fastConnectOptions: FastConnectOptions(
          microphone: const TrackOption(enabled: true),
          camera: const TrackOption(enabled: true),
        ),
      );

      // 6. Set display name from auth state
      final user = ref.read(currentUserProvider);
      if (user != null) {
        await room.localParticipant?.setName(user.name);
      }

      // 7. Enable wakelock
      await WakelockPlus.enable();

      setState(() {
        _room = room;
        _localParticipant = room.localParticipant;
        _remoteParticipants = room.remoteParticipants.values.toList();
        _isConnecting = false;
        _sessionTitle = tokenResponse.roomName;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isConnecting = false;
      });
    }
  }

  void _setupRoomListeners() {
    _roomListener
      ?..on<ParticipantConnectedEvent>((event) {
        setState(() {
          _remoteParticipants =
              _room?.remoteParticipants.values.toList() ?? [];
        });
      })
      ..on<ParticipantDisconnectedEvent>((event) {
        setState(() {
          _remoteParticipants =
              _room?.remoteParticipants.values.toList() ?? [];
        });
      })
      ..on<TrackSubscribedEvent>((event) {
        setState(() {});
      })
      ..on<TrackUnsubscribedEvent>((event) {
        setState(() {});
      })
      ..on<RoomReconnectingEvent>((event) {
        setState(() => _isReconnecting = true);
      })
      ..on<RoomReconnectedEvent>((event) {
        setState(() => _isReconnecting = false);
      })
      ..on<RoomDisconnectedEvent>((event) {
        _handleDisconnection();
      });
  }

  void _handleDisconnection() {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'live_sessions.disconnected'.tr(),
            style: GoogleFonts.tajawal(color: Colors.white),
          ),
          backgroundColor: AppColors.error,
        ),
      );
      context.pop();
    }
  }

  Future<void> _toggleMic() async {
    try {
      if (_isMicEnabled) {
        await _localParticipant?.setMicrophoneEnabled(false);
      } else {
        await _localParticipant?.setMicrophoneEnabled(true);
      }
      setState(() => _isMicEnabled = !_isMicEnabled);
    } catch (_) {}
  }

  Future<void> _toggleCamera() async {
    try {
      if (_isCameraEnabled) {
        await _localParticipant?.setCameraEnabled(false);
      } else {
        await _localParticipant?.setCameraEnabled(true);
      }
      setState(() => _isCameraEnabled = !_isCameraEnabled);
    } catch (_) {}
  }

  Future<void> _leaveRoom() async {
    final shouldLeave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.glassBorder),
        ),
        title: Text(
          'live_sessions.leave_confirm_title'.tr(),
          style: GoogleFonts.cairo(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          'live_sessions.leave_confirm_message'.tr(),
          style: GoogleFonts.tajawal(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              'common.cancel'.tr(),
              style: GoogleFonts.cairo(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              'live_sessions.leave'.tr(),
              style: GoogleFonts.cairo(color: AppColors.error),
            ),
          ),
        ],
      ),
    );

    if (shouldLeave == true) {
      await _cleanup();
      if (mounted) context.pop();
    }
  }

  Future<void> _cleanup() async {
    _roomListener?.dispose();
    await _room?.disconnect();
    await _room?.dispose();
    await WakelockPlus.disable();
  }

  @override
  void dispose() {
    _cleanup();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ── Connecting state ──
    if (_isConnecting) {
      return Scaffold(
        backgroundColor: AppColors.backgroundDarkest,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'live_sessions.connecting'.tr(),
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'live_sessions.connecting_subtitle'.tr(),
                style: GoogleFonts.tajawal(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // ── Error state ──
    if (_errorMessage != null) {
      return Scaffold(
        backgroundColor: AppColors.backgroundDarkest,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close_rounded, color: AppColors.textPrimary),
            onPressed: () => context.pop(),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.error.withValues(alpha: 0.1),
                  ),
                  child: Icon(
                    Icons.videocam_off_rounded,
                    size: 48,
                    color: AppColors.error,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'live_sessions.connection_failed'.tr(),
                  style: GoogleFonts.cairo(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _errorMessage!,
                  style: GoogleFonts.tajawal(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _isConnecting = true;
                      _errorMessage = null;
                    });
                    _initializeRoom();
                  },
                  icon: Icon(Icons.refresh_rounded, color: AppColors.primary),
                  label: Text(
                    'common.retry'.tr(),
                    style: GoogleFonts.cairo(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // ── Connected: main room UI ──
    return Scaffold(
      backgroundColor: AppColors.backgroundDarkest,
      body: Stack(
        children: [
          // ── Video Grid (main area) ──
          Column(
            children: [
              // Top bar
              _buildTopBar(),
              // Reconnecting indicator
              if (_isReconnecting) _buildReconnectingBanner(),
              // Main video area
              Expanded(
                child: _buildVideoGrid(),
              ),
            ],
          ),

          // ── Local camera PiP overlay ──
          if (_isCameraEnabled && _localParticipant != null)
            _buildLocalCameraPiP(),

          // ── Bottom controls ──
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ControlsBar(
              isMicEnabled: _isMicEnabled,
              isCameraEnabled: _isCameraEnabled,
              onToggleMic: _toggleMic,
              onToggleCamera: _toggleCamera,
              onLeave: _leaveRoom,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            right: 16,
            bottom: 12,
          ),
          decoration: BoxDecoration(
            color: AppColors.backgroundDarkest.withValues(alpha: 0.8),
            border: Border(
              bottom: BorderSide(
                color: AppColors.glassBorderSubtle,
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _sessionTitle.isNotEmpty
                          ? _sessionTitle
                          : 'live_sessions.live_room'.tr(),
                      style: GoogleFonts.cairo(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'live_sessions.participants_count'.tr(
                            namedArgs: {
                              'count':
                                  '${_remoteParticipants.length + 1}'
                            },
                          ),
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
              // Leave button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _leaveRoom,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.error.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.call_end_rounded,
                            size: 18, color: AppColors.error),
                        const SizedBox(width: 6),
                        Text(
                          'live_sessions.leave'.tr(),
                          style: GoogleFonts.cairo(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.error,
                          ),
                        ),
                      ],
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

  Widget _buildReconnectingBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: AppColors.warning.withValues(alpha: 0.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.warning,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'live_sessions.reconnecting'.tr(),
            style: GoogleFonts.tajawal(
              fontSize: 13,
              color: AppColors.warning,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoGrid() {
    // Find instructor participant (first remote participant or the one
    // whose identity does not start with a student pattern)
    final participants = _remoteParticipants;

    if (participants.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.people_outline_rounded,
              size: 64,
              color: AppColors.textTertiary.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 16),
            Text(
              'live_sessions.waiting_for_participants'.tr(),
              style: GoogleFonts.tajawal(
                fontSize: 15,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      );
    }

    // If only one participant, show them full screen
    if (participants.length == 1) {
      return _buildParticipantVideo(participants.first, isLarge: true);
    }

    // Multiple participants: first one large, rest in a row at bottom
    return Column(
      children: [
        // Main (instructor / first remote) video
        Expanded(
          flex: 3,
          child: _buildParticipantVideo(participants.first, isLarge: true),
        ),
        // Other participants row
        if (participants.length > 1)
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              itemCount: participants.length - 1,
              itemBuilder: (context, index) {
                return Container(
                  width: 160,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _buildParticipantVideo(
                      participants[index + 1],
                      isLarge: false,
                    ),
                  ),
                );
              },
            ),
          ),
        // Bottom spacing for controls bar
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildParticipantVideo(
    RemoteParticipant participant, {
    required bool isLarge,
  }) {
    // Find the first video track
    final videoTrack = participant.videoTrackPublications
        .where((pub) => pub.subscribed && pub.track != null)
        .map((pub) => pub.track as VideoTrack)
        .firstOrNull;

    final name = participant.name.isNotEmpty
        ? participant.name
        : participant.identity.split('_').first;

    if (videoTrack != null) {
      return Stack(
        fit: StackFit.expand,
        children: [
          VideoTrackRenderer(videoTrack),
          // Name overlay
          Positioned(
            bottom: 8,
            right: 8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundDarkest.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    name,
                    style: GoogleFonts.tajawal(
                      fontSize: 12,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    // No video: show avatar placeholder
    return Container(
      color: AppColors.surface,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: isLarge ? 80 : 48,
              height: isLarge ? 80 : 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surfaceElevated,
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : '?',
                  style: GoogleFonts.cairo(
                    fontSize: isLarge ? 32 : 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: GoogleFonts.tajawal(
                fontSize: isLarge ? 16 : 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocalCameraPiP() {
    final localVideoTrack = _localParticipant?.videoTrackPublications
        .where((pub) => pub.track != null)
        .map((pub) => pub.track as VideoTrack)
        .firstOrNull;

    if (localVideoTrack == null) return const SizedBox.shrink();

    return Positioned(
      right: _pipOffset.dx,
      top: _pipOffset.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _pipOffset = Offset(
              _pipOffset.dx - details.delta.dx,
              _pipOffset.dy + details.delta.dy,
            );
          });
        },
        child: Container(
          width: 120,
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.5),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: VideoTrackRenderer(
              localVideoTrack,
              mirrorMode: VideoViewMirrorMode.mirror,
            ),
          ),
        ),
      ),
    );
  }
}
