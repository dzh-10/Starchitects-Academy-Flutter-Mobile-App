import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_service.dart';
import 'models/course_model.dart';

final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  return CourseRepository(ref.watch(apiServiceProvider));
});

class CourseRepository {
  final ApiService _apiService;

  CourseRepository(this._apiService);

  Future<List<Course>> getCourses({String? type, String? search}) {
    return _apiService.getCourses(type, search);
  }

  Future<Course> getCourseDetail(String slug) {
    return _apiService.getCourseDetail(slug);
  }

  Future<List<Section>> getCourseLessons(int courseId) {
    return _apiService.getCourseLessons(courseId);
  }
}
