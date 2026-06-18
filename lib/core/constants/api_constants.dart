import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get baseUrl {
    final url = dotenv.env['API_BASE_URL'];
    if (url == null || url.isEmpty) {
      throw Exception('API_BASE_URL is missing');
    }
    return url.endsWith('/') ? url : '\$url/';
  }
  
  // Auth
  static const String login = 'login';
  static const String register = 'register';
  static const String logout = 'logout';
  
  // User
  static const String user = 'user';
  static const String notifications = 'notifications';
  static const String fcmToken = 'fcm/token';
  
  // Courses
  static const String courses = 'courses';
  static const String userCourses = 'user/courses';
  static const String certificates = 'user/certificates';
  
  // Subscriptions
  static const String plans = 'subscriptions/plans';
  static const String checkout = 'subscriptions/checkout';
}
