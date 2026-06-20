import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/constants/app_colors.dart';
import '../domain/auth_provider.dart';
import '../domain/auth_state.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        ref.read(authNotifierProvider.notifier).checkAuth());
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      // إصلاح: استخدام when المُعرَّف في AuthState
      next.when(
        loading: () {},
        data: (user) {
          Future.delayed(const Duration(seconds: 2), () {
            if (!mounted) return;
            if (user != null) {
              context.go('/home');
            } else {
              context.go('/onboarding');
            }
          });
        },
        error: (_, __) {
          Future.delayed(const Duration(seconds: 2), () {
            if (!mounted) return;
            context.go('/onboarding');
          });
        },
      );
    });

    return Scaffold(
      backgroundColor: AppColors.kBgPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Shimmer.fromColors(
              baseColor: AppColors.kGold,
              highlightColor: AppColors.kGoldDark,
              child: const Icon(Icons.school, size: 100),
            ).animate(onPlay: (c) => c.repeat()).scale(duration: 1000.ms),
            const SizedBox(height: 24),
            Text(
              'Starchitects Academy',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: AppColors.kGold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}