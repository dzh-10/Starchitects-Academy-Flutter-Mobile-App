/// Starchitects Academy API Endpoints
/// All endpoint constants organized by feature
class ApiEndpoints {
  ApiEndpoints._();

  // ─── Auth ────────────────────────────────────────────────────────────
  static const String login = '/api/v1/login';
  static const String register = '/api/v1/register';
  static const String forgotPassword = '/api/v1/forgot-password';
  static const String logout = '/api/v1/logout';
  static const String user = '/api/v1/me';
  static const String updateUser = '/api/v1/me';
  static const String changePassword = '/api/v1/password';
  static const String googleAuth = '/api/v1/auth/google';

  // ─── Courses ─────────────────────────────────────────────────────────
  static const String courses = '/api/v1/courses';
  static String courseDetail(String id) => '/api/v1/courses/$id';
  static String courseLessons(String id) => '/api/v1/courses/$id/lessons';
  static String enrollCourse(String id) => '/api/v1/courses/$id/enroll';
  static const String featuredCourses = '/api/v1/courses/featured';

  // ─── Lessons ─────────────────────────────────────────────────────────
  static String lessonVideo(String id) => '/api/v1/lessons/$id/video';
  static String lessonProgress(String id) => '/api/v1/lessons/$id/progress';

  // ─── Live Sessions ───────────────────────────────────────────────────
  static const String liveSessions = '/api/v1/live-sessions';
  static String sessionToken(String id) => '/api/v1/live-sessions/$id/token';

  // ─── Student Progress ────────────────────────────────────────────────
  static const String studentProgress = '/api/v1/student/progress';
  static String courseProgress(String id) => '/api/v1/student/progress/$id';
  static const String studentDashboard = '/api/v1/student/dashboard';
  static const String continueLearning = '/api/v1/student/continue-learning';

  // ─── Payments ────────────────────────────────────────────────────────
  static const String paymentsInitiate = '/api/v1/payments/initiate';
  static String paymentVerify(String id) => '/api/v1/payments/$id/verify';

  // ─── Certificates ────────────────────────────────────────────────────
  static const String certificates = '/api/v1/certificates';
  static String certificateDownload(String id) => '/api/v1/certificates/$id/download';

  // ─── Notifications ──────────────────────────────────────────────────
  static const String notifications = '/api/v1/notifications';
  static const String registerFcmToken = '/api/v1/notifications/fcm-token';
  static String markNotificationRead(String id) => '/api/v1/notifications/$id/read';
  static const String markAllNotificationsRead = '/v1/notifications/mark-all-read';
}
