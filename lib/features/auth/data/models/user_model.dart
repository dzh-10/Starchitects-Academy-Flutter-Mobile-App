import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class User with _$User {
  factory User({
    required int id,
    required String name,
    required String email,
    String? avatar,
    @JsonKey(name: 'subscription_plan') String? subscriptionPlan,
    @JsonKey(name: 'subscription_ends_at') DateTime? subscriptionEndsAt,
  }) = _User;
  
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class AuthResponse with _$AuthResponse {
  factory AuthResponse({
    required String token,
    required User user,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
}
