import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starchitects_app/features/progress/data/models/progress_model.dart';
import 'package:starchitects_app/features/progress/data/repositories/progress_repository.dart';

part 'progress_provider.g.dart';

/// Fetches overall student progress for the dashboard.
@riverpod
Future<OverallProgress> overallProgress(Ref ref) async {
  final repository = ref.read(progressRepositoryProvider);
  return repository.getOverallProgress();
}

/// Fetches detailed progress for a specific course.
@riverpod
Future<CourseProgressItem> courseProgress(
  Ref ref,
  String courseId,
) async {
  final repository = ref.read(progressRepositoryProvider);
  return repository.getCourseProgress(courseId);
}
