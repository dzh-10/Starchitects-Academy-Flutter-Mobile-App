import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/widgets/glass_card.dart';
import 'package:starchitects_app/features/live_sessions/data/models/session_model.dart';

/// Premium session card with glassmorphism, countdown timer,
/// live badge, and instructor info.
class SessionCard extends StatefulWidget {
  final SessionModel session;
  final VoidCallback? onTap;
  final VoidCallback? onJoin;

  const SessionCard({
    super.key,
    required this.session,
    this.onTap,
    this.onJoin,
  });

  @override
  State<SessionCard> createState() => _SessionCardState();
}

class _SessionCardState extends State<SessionCard>
    with SingleTickerProviderStateMixin {
  Timer? _countdownTimer;
  Duration _remaining = Duration.zero;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Pulsing animation for live badge
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Countdown timer for upcoming sessions
    if (widget.session.status == 'upcoming') {
      _updateRemaining();
      _countdownTimer = Timer.periodic(
        const Duration(seconds: 30),
        (_) => _updateRemaining(),
      );
    }
  }

  void _updateRemaining() {
    final now = DateTime.now();
    final diff = widget.session.scheduledAt.difference(now);
    if (mounted) {
      setState(() {
        _remaining = diff.isNegative ? Duration.zero : diff;
      });
    }
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  String _formatCountdown() {
    if (_remaining == Duration.zero) return 'live_sessions.starting_soon'.tr();

    final hours = _remaining.inHours;
    final minutes = _remaining.inMinutes.remainder(60);

    if (hours > 0) {
      return 'live_sessions.starts_in_hours_minutes'
          .tr(namedArgs: {'hours': '$hours', 'minutes': '$minutes'});
    }
    return 'live_sessions.starts_in_minutes'
        .tr(namedArgs: {'minutes': '$minutes'});
  }

  String _formatScheduledTime() {
    final formatter = DateFormat('EEEE، d MMMM - hh:mm a', 'ar');
    return formatter.format(widget.session.scheduledAt);
  }

  @override
  Widget build(BuildContext context) {
    final session = widget.session;
    final isLive = session.status == 'live';

    return GlassCard(
      onTap: widget.onTap,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      borderColor: isLive
          ? AppColors.error.withValues(alpha: 0.5)
          : AppColors.glassBorder,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top Row: Course name + Live badge / Countdown ──
          Row(
            children: [
              Expanded(
                child: Text(
                  session.courseName,
                  style: GoogleFonts.cairo(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isLive) _buildLiveBadge(),
            ],
          ),
          const SizedBox(height: 8),

          // ── Session Title ──
          Text(
            session.title,
            style: GoogleFonts.cairo(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),

          // ── Instructor Row ──
          if (session.instructorName != null) ...[
            Row(
              children: [
                _buildInstructorAvatar(),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        session.instructorName!,
                        style: GoogleFonts.tajawal(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'live_sessions.instructor'.tr(),
                        style: GoogleFonts.tajawal(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],

          // ── Divider ──
          Container(
            height: 1,
            color: AppColors.surfaceElevated,
          ),
          const SizedBox(height: 12),

          // ── Bottom Row: Time info + Participants + Join ──
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Scheduled time
                    Row(
                      children: [
                        Icon(
                          Icons.schedule_rounded,
                          size: 14,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            _formatScheduledTime(),
                            style: GoogleFonts.tajawal(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Countdown or participants
                    if (session.status == 'upcoming') ...[
                      Row(
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 14,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _formatCountdown(),
                            style: GoogleFonts.tajawal(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ],

                    // Participants count
                    Row(
                      children: [
                        Icon(
                          Icons.people_outline_rounded,
                          size: 14,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'live_sessions.participants_count'.tr(
                            namedArgs: {
                              'count': '${session.participantsCount}'
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

              // Join button for live sessions
              if (isLive && widget.onJoin != null) ...[
                const SizedBox(width: 12),
                _buildJoinButton(),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLiveBadge() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: _pulseAnimation.value * 0.2),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: AppColors.error.withValues(alpha: _pulseAnimation.value),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.error.withValues(alpha: 0.6),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'live_sessions.live'.tr(),
                style: GoogleFonts.cairo(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.error,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInstructorAvatar() {
    final avatar = widget.session.instructorAvatar;
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.4),
          width: 1.5,
        ),
        image: avatar != null && avatar.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(avatar),
                fit: BoxFit.cover,
              )
            : null,
        color: avatar == null || avatar.isEmpty
            ? AppColors.surfaceElevated
            : null,
      ),
      child: avatar == null || avatar.isEmpty
          ? const Icon(
              Icons.person_rounded,
              size: 20,
              color: AppColors.textTertiary,
            )
          : null,
    );
  }

  Widget _buildJoinButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onJoin,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.videocam_rounded,
                size: 18,
                color: AppColors.textOnPrimary,
              ),
              const SizedBox(width: 6),
              Text(
                'live_sessions.join'.tr(),
                style: GoogleFonts.cairo(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textOnPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
