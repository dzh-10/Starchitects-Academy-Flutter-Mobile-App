import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';

/// Bottom controls bar for the live room with glassmorphism design.
/// Provides microphone, camera, and leave controls.
class ControlsBar extends StatelessWidget {
  final bool isMicEnabled;
  final bool isCameraEnabled;
  final VoidCallback onToggleMic;
  final VoidCallback onToggleCamera;
  final VoidCallback onLeave;

  const ControlsBar({
    super.key,
    required this.isMicEnabled,
    required this.isCameraEnabled,
    required this.onToggleMic,
    required this.onToggleCamera,
    required this.onLeave,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 16,
            bottom: MediaQuery.of(context).padding.bottom + 16,
          ),
          decoration: BoxDecoration(
            color: AppColors.backgroundLight.withValues(alpha: 0.85),
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(
              top: BorderSide(
                color: AppColors.glassBorder,
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // ── Microphone Toggle ──
              _ControlButton(
                icon: isMicEnabled
                    ? Icons.mic_rounded
                    : Icons.mic_off_rounded,
                label: isMicEnabled
                    ? 'live_sessions.mic_on'.tr()
                    : 'live_sessions.mic_off'.tr(),
                isActive: isMicEnabled,
                activeColor: AppColors.primary,
                inactiveColor: AppColors.textTertiary,
                onTap: onToggleMic,
              ),

              // ── Leave Call Button ──
              _LeaveButton(onTap: onLeave),

              // ── Camera Toggle ──
              _ControlButton(
                icon: isCameraEnabled
                    ? Icons.videocam_rounded
                    : Icons.videocam_off_rounded,
                label: isCameraEnabled
                    ? 'live_sessions.camera_on'.tr()
                    : 'live_sessions.camera_off'.tr(),
                isActive: isCameraEnabled,
                activeColor: AppColors.primary,
                inactiveColor: AppColors.textTertiary,
                onTap: onToggleCamera,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Individual control button with active/inactive states.
class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  const _ControlButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? activeColor.withValues(alpha: 0.15)
                  : inactiveColor.withValues(alpha: 0.1),
              border: Border.all(
                color: isActive
                    ? activeColor.withValues(alpha: 0.5)
                    : inactiveColor.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            child: Icon(
              icon,
              size: 26,
              color: isActive ? activeColor : inactiveColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.tajawal(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isActive ? activeColor : inactiveColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// Prominent red leave button.
class _LeaveButton extends StatelessWidget {
  final VoidCallback onTap;

  const _LeaveButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.error,
                  AppColors.error.withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.error.withValues(alpha: 0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.call_end_rounded,
              size: 28,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'live_sessions.leave'.tr(),
            style: GoogleFonts.tajawal(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.error,
            ),
          ),
        ],
      ),
    );
  }
}
