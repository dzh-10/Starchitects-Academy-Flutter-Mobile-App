import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starchitects_app/core/constants/app_colors.dart';
import 'package:starchitects_app/core/widgets/shimmer_loading.dart';

/// Circular avatar with cached network image, gold border ring,
/// fallback initials, and shimmer loading state.
class CachedAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double size;
  final double borderWidth;
  final Color? borderColor;
  final VoidCallback? onTap;

  const CachedAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size = 48.0,
    this.borderWidth = 2.0,
    this.borderColor,
    this.onTap,
  });

  /// Small avatar (32px)
  const CachedAvatar.sm({
    super.key,
    this.imageUrl,
    this.name,
    this.borderWidth = 1.5,
    this.borderColor,
    this.onTap,
  }) : size = 32.0;

  /// Medium avatar (48px)
  const CachedAvatar.md({
    super.key,
    this.imageUrl,
    this.name,
    this.borderWidth = 2.0,
    this.borderColor,
    this.onTap,
  }) : size = 48.0;

  /// Large avatar (64px)
  const CachedAvatar.lg({
    super.key,
    this.imageUrl,
    this.name,
    this.borderWidth = 2.5,
    this.borderColor,
    this.onTap,
  }) : size = 64.0;

  /// Extra large avatar (96px)
  const CachedAvatar.xl({
    super.key,
    this.imageUrl,
    this.name,
    this.borderWidth = 3.0,
    this.borderColor,
    this.onTap,
  }) : size = 96.0;

  /// Get initials from the name (supports Arabic and Latin)
  String get _initials {
    if (name == null || name!.isEmpty) return '?';
    final parts = name!.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  double get _fontSize => size * 0.35;

  @override
  Widget build(BuildContext context) {
    final avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor ?? AppColors.primary,
          width: borderWidth,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipOval(
        child: _buildContent(),
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: avatar,
      );
    }

    return avatar;
  }

  Widget _buildContent() {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _buildFallback();
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      width: size,
      height: size,
      fit: BoxFit.cover,
      placeholder: (context, url) => ShimmerWrapper(
        child: Container(
          width: size,
          height: size,
          color: AppColors.surfaceLight,
        ),
      ),
      errorWidget: (context, url, error) => _buildFallback(),
    );
  }

  Widget _buildFallback() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.2),
            AppColors.primaryDark.withValues(alpha: 0.3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        _initials,
        style: GoogleFonts.cairo(
          fontSize: _fontSize,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
