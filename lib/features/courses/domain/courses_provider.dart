import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/repositories/course_repository.dart';
import '../data/models/course_model.dart';

part 'courses_provider.g.dart';

@riverpod
class CoursesNotifier extends _$CoursesNotifier {
  @override
  AsyncValue<List<CourseModel>> build() {
    return const AsyncValue.loading();
  }

  Future<void> fetchCourses({String? type, String? search}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return ref.watch(courseRepositoryProvider).getCourses(category: type, search: search);
    });
  }
}

@riverpod
Future<CourseModel> courseDetail(CourseDetailRef ref, String slug) {
  return ref.watch(courseRepositoryProvider).getCourseDetail(slug);
}

@riverpod
Future<List<LessonModel>> courseLessons(CourseLessonsRef ref, String slug) {
  return ref.watch(courseRepositoryProvider).getCourseLessons(slug);
}
