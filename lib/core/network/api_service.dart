import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';
import '../../features/auth/data/models/user_model.dart';
import '../../features/courses/data/models/course_model.dart';

part 'api_service.g.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<AuthResponse> login(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.register)
  Future<AuthResponse> register(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.logout)
  Future<void> logout();

  @GET(ApiConstants.user)
  Future<User> getUser();

  @GET(ApiConstants.courses)
  Future<List<CourseModel>> getCourses(
    @Query('type') String? type,
    @Query('search') String? search,
  );

  @GET('\/{slug}')
  Future<CourseModel> getCourseDetail(@Path('slug') String slug);

  @GET('\/{id}/lessons')
  Future<List<SectionModel>> getCourseLessons(@Path('id') int id);

  @GET('lessons/{id}')
  Future<LessonModel> getLessonDetail(@Path('id') int id);

  @POST('lessons/{id}/progress')
  Future<void> saveLessonProgress(
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );

  @GET(ApiConstants.userCourses)
  Future<List<CourseModel>> getUserCourses();

  @GET(ApiConstants.plans)
  Future<dynamic> getSubscriptionPlans();

  @POST(ApiConstants.checkout)
  Future<dynamic> createCheckout();

  @GET(ApiConstants.certificates)
  Future<dynamic> getUserCertificates();
}
