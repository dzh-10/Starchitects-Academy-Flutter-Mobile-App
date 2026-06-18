/// Starchitects Academy API Endpoints
/// All endpoint constants organized by feature
class ApiEndpoints {
  ApiEndpoints._();

  // ─── Auth ────────────────────────────────────────────────────────────
  static const String login = '/v1/login';
  static const String register = '/v1/register';
  static const String forgotPassword = '/v1/forgot-password';
  static const String logout = '/v1/logout';
  static const String user = '/v1/me';
  static const String updateUser = '/v1/me';
  static const String changePassword = '/v1/password';
  static const String googleAuth = '/v1/auth/google';

  // ─── Courses ─────────────────────────────────────────────────────────
  static const String courses = '/v1/courses';
  static String courseDetail(String id) => '/v1/courses/$id';
  static String courseLessons(String id) => '/v1/courses/$id/v1/lessons';
  static String enrollCourse(String id) => '/v1/courses/$id/enroll';
  static const String featuredCourses = '/v1/courses/featured';

  // ─── Lessons ─────────────────────────────────────────────────────────
  static String lessonVideo(String id) => '/v1/lessons/$id/video';
  static String lessonProgress(String id) => '/v1/lessons/$id/progress';

  // ─── Live Sessions ───────────────────────────────────────────────────
  static const String liveSessions = '/v1/live-sessions';
  static String sessionToken(String id) => '/v1/live-sessions/$id/token';

  // ─── Student Progress ────────────────────────────────────────────────
  static const String studentProgress = '/v1/student/progress';
  static String courseProgress(String id) => '/v1/student/progress/$id';
  static const String studentDashboard = '/v1/student/dashboard';
  static const String continueLearning = '/v1/student/continue-learning';

  // ─── Payments ────────────────────────────────────────────────────────
  static const String paymentsInitiate = '/v1/payments/initiate';
  static String paymentVerify(String id) => '/v1/payments/$id/verify';

  // ─── Certificates ────────────────────────────────────────────────────
  static const String certificates = '/v1/certificates';
  static String certificateDownload(String id) => '/v1/certificates/$id/download';

  // ─── Notifications ──────────────────────────────────────────────────
  static const String notifications = '/v1/notifications';
  static const String registerFcmToken = '/v1/notifications/fcm-token';
  static String markNotificationRead(String id) => '/v1/notifications/$id/read';
  static const String markAllNotificationsRead = '/v1/notifications/mark-all-read';
}
