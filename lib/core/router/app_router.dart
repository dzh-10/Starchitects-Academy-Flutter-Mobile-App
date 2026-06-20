import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/domain/auth_provider.dart';
import '../../features/auth/domain/auth_state.dart';
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/auth/presentation/onboarding_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/courses/presentation/screens/course_catalog_screen.dart';
import '../../features/courses/presentation/screens/course_detail_screen.dart';
import '../../features/player/presentation/video_player_screen.dart';
import '../../features/subscription/presentation/plans_screen.dart';
import '../../features/subscription/presentation/checkout_webview_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/certificates/presentation/screens/certificates_list_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authNotifier = ValueNotifier<AuthState>(ref.read(authNotifierProvider));

  ref.listen<AuthState>(authNotifierProvider, (_, next) {
    authNotifier.value = next;
  });

  return GoRouter(
    initialLocation: '/',
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final authState = authNotifier.value;
      final isLoading = authState.isLoading;
      final isLoggedIn = authState.isAuthenticated;
      final location = state.matchedLocation;

      if (isLoading && location == '/') return null;

      const publicRoutes = ['/', '/onboarding', '/login', '/register'];
      final isPublic = publicRoutes.contains(location);

      if (!isLoggedIn && !isPublic) return '/login';

      if (isLoggedIn &&
          (location == '/login' ||
              location == '/register' ||
              location == '/onboarding')) {
        return '/home';
      }

      return null;
    },
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
        builder: (context, state) => const CourseCatalogScreen(),
      ),
      GoRoute(
        path: '/courses/:slug',
        builder: (context, state) {
          final slug = state.pathParameters['slug'];
          if (slug == null || slug.isEmpty) return const SizedBox.shrink();
          return CourseDetailScreen(slug: slug);
        },
      ),
      GoRoute(
        path: '/player/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'];
          if (id == null || id.isEmpty) return const SizedBox.shrink();
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
        builder: (context, state) => const CertificatesListScreen(),
      ),
    ],
  );
});