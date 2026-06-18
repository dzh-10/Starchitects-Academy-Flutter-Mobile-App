import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/splash_screen.dart';
import '../../features/auth/presentation/onboarding_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/courses/presentation/courses_list_screen.dart';
import '../../features/courses/presentation/course_detail_screen.dart';
import '../../features/player/presentation/video_player_screen.dart';
import '../../features/subscription/presentation/plans_screen.dart';
import '../../features/subscription/presentation/checkout_webview_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/profile/presentation/certificates_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/courses',
        builder: (context, state) => const CoursesListScreen(),
      ),
      GoRoute(
        path: '/courses/:slug',
        builder: (context, state) {
          final slug = state.pathParameters['slug']!;
          return CourseDetailScreen(slug: slug);
        },
      ),
      GoRoute(
        path: '/player/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return VideoPlayerScreen(lessonId: id);
        },
      ),
      GoRoute(
        path: '/subscriptions',
        builder: (context, state) => const PlansScreen(),
      ),
      GoRoute(
        path: '/checkout',
        builder: (context, state) {
          final url = state.uri.queryParameters['url'] ?? '';
          return CheckoutWebviewScreen(checkoutUrl: url);
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/certificates',
        builder: (context, state) => const CertificatesScreen(),
      ),
    ],
  );
});
