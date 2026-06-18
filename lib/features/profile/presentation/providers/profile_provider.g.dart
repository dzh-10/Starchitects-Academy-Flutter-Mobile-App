// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$unreadNotificationsCountHash() =>
    r'5275a5f88c7d573c567bc24395de219fd0a2e1d4';

/// Derived provider that counts unread notifications.
///
/// Copied from [unreadNotificationsCount].
@ProviderFor(unreadNotificationsCount)
final unreadNotificationsCountProvider = AutoDisposeProvider<int>.internal(
  unreadNotificationsCount,
  name: r'unreadNotificationsCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$unreadNotificationsCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UnreadNotificationsCountRef = AutoDisposeProviderRef<int>;
String _$notificationsListHash() => r'e5418493d3fee3014e97800f67ad4c468b91dd4a';

/// Provides the list of notifications for the current user.
/// Auto-refreshes when invalidated.
///
/// Copied from [NotificationsList].
@ProviderFor(NotificationsList)
final notificationsListProvider = AutoDisposeAsyncNotifierProvider<
    NotificationsList, List<NotificationModel>>.internal(
  NotificationsList.new,
  name: r'notificationsListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NotificationsList = AutoDisposeAsyncNotifier<List<NotificationModel>>;
String _$appLanguageHash() => r'77f54da1a4bc2d1fd07ddb0809812c719b62e37d';

/// Manages the current app locale.
/// Defaults to Arabic (ar).
///
/// Copied from [AppLanguage].
@ProviderFor(AppLanguage)
final appLanguageProvider =
    AutoDisposeNotifierProvider<AppLanguage, Locale>.internal(
  AppLanguage.new,
  name: r'appLanguageProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appLanguageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AppLanguage = AutoDisposeNotifier<Locale>;
String _$darkModeHash() => r'9e727c5370c7edbd7fbd5fccc34a0166b6390e80';

/// Manages the dark/light mode toggle.
/// Defaults to dark mode (true) since the app is dark-themed.
///
/// Copied from [DarkMode].
@ProviderFor(DarkMode)
final darkModeProvider = AutoDisposeNotifierProvider<DarkMode, bool>.internal(
  DarkMode.new,
  name: r'darkModeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$darkModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DarkMode = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
