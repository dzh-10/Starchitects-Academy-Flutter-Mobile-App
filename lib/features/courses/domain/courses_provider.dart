import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/course_repository.dart';
import '../data/models/course_model.dart';

part 'courses_provider.g.dart';

@riverpod
class CoursesNotifier extends _$CoursesNotifier {
  @override
  AsyncValue<List<Course>> build() {
    return const AsyncValue.loading();
  }

  Future<void> fetchCourses({String? type, String? search}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return ref.read(courseRepositoryProvider).getCourses(type: type, search: search);
    });
  }
}

@riverpod
Future<Course> courseDetail(CourseDetailRef ref, String slug) {
  return ref.read(courseRepositoryProvider).getCourseDetail(slug);
}

@riverpod
Future<List<Section>> courseLessons(CourseLessonsRef ref, int courseId) {
  return ref.read(courseRepositoryProvider).getCourseLessons(courseId);
}
