import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_service.dart';

final progressRepositoryProvider = Provider<ProgressRepository>((ref) {
  return ProgressRepository(ref.watch(apiServiceProvider));
});

class ProgressRepository {
  final ApiService _apiService;

  ProgressRepository(this._apiService);

  Future<void> saveProgress(int lessonId, int secondsWatched, bool completed) {
    return _apiService.saveLessonProgress(lessonId, {
      'seconds_watched': secondsWatched,
      'completed': completed,
    });
  }
}
