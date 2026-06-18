import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starchitects_app/features/home/data/models/dashboard_model.dart';
import 'package:starchitects_app/features/home/data/repositories/home_repository.dart';

part 'home_provider.g.dart';

/// Provides dashboard statistics (enrolled courses, completed lessons, certificates)
@riverpod
Future<DashboardStats> dashboardStats(Ref ref) async {
  final repository = ref.read(homeRepositoryProvider);
  return repository.getDashboardStats();
}

/// Provides the list of courses the student should continue learning
@riverpod
Future<List<ContinueLearningItem>> continueLearning(
    Ref ref) async {
  final repository = ref.read(homeRepositoryProvider);
  return repository.getContinueLearning();
}

/// Provides featured courses for the home carousel
@riverpod
Future<List<FeaturedCourse>> featuredCourses(Ref ref) async {
  final repository = ref.read(homeRepositoryProvider);
  return repository.getFeaturedCourses();
}
