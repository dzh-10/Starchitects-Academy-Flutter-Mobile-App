enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class UserData {
  final String? name;
  final String? email;
  final String? avatar;
  final Map<String, dynamic> raw;

  UserData({this.name, this.email, this.avatar, required this.raw});

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      name: map['name']?.toString(),
      email: map['email']?.toString(),
      avatar: map['avatar']?.toString() ?? map['profile_photo_url']?.toString(),
      raw: map,
    );
  }
}

class AuthState {
  final AuthStatus status;
  final UserData? userData;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.userData,
    this.errorMessage,
  });

  bool get isLoading => status == AuthStatus.loading;
  bool get isAuthenticated => status == AuthStatus.authenticated;

  /// للتوافق مع app_router و home_screen و profile_screen
  UserData? get valueOrNull =>
      status == AuthStatus.authenticated ? userData : null;

  /// للتوافق مع register_screen و splash_screen
  T? whenOrNull<T>({
    T? Function(UserData? user)? data,
    T? Function(Object error, StackTrace? stack)? error,
  }) {
    if (status == AuthStatus.authenticated && data != null) return data(userData);
    if (status == AuthStatus.error && error != null) {
      return error(Exception(errorMessage), null);
    }
    return null;
  }

  /// للتوافق مع splash_screen
  T when<T>({
    required T Function() loading,
    required T Function(UserData? user) data,
    required T Function(Object error, StackTrace? stack) error,
  }) {
    switch (status) {
      case AuthStatus.loading:
      case AuthStatus.initial:
        return loading();
      case AuthStatus.authenticated:
      case AuthStatus.unauthenticated:
        return data(userData);
      case AuthStatus.error:
        return error(Exception(errorMessage), null);
    }
  }

  AuthState copyWith({
    AuthStatus? status,
    UserData? userData,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      userData: userData ?? this.userData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}