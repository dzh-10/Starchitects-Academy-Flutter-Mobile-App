import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starchitects_app/features/profile/data/models/notification_model.dart';
import 'package:starchitects_app/features/profile/data/repositories/profile_repository.dart';

part 'profile_provider.g.dart';

// ─── Notifications Provider ─────────────────────────────────────────────

/// Provides the list of notifications for the current user.
/// Auto-refreshes when invalidated.
@riverpod
class NotificationsList extends _$NotificationsList {
  @override
  Future<List<NotificationModel>> build() async {
    final repo = ref.read(profileRepositoryProvider);
    return repo.getNotifications();
  }

  /// Mark a single notification as read (optimistic update).
  Future<void> markAsRead(String id) async {
    final repo = ref.read(profileRepositoryProvider);
    await repo.markNotificationRead(id);

    // Optimistically update the local state
    state.whenData((notifications) {
      state = AsyncData(
        notifications.map((n) {
          if (n.id == id) return n.copyWith(isRead: true);
          return n;
        }).toList(),
      );
    });
  }

  /// Mark all notifications as read (optimistic update).
  Future<void> markAllAsRead() async {
    final repo = ref.read(profileRepositoryProvider);
    await repo.markAllRead();

    // Optimistically update the local state
    state.whenData((notifications) {
      state = AsyncData(
        notifications.map((n) => n.copyWith(isRead: true)).toList(),
      );
    });
  }
}

// ─── Unread Count Provider ──────────────────────────────────────────────

/// Derived provider that counts unread notifications.
@riverpod
int unreadNotificationsCount(Ref ref) {
  final notificationsAsync = ref.watch(notificationsListProvider);
  return notificationsAsync.whenOrNull(
        data: (notifications) =>
            notifications.where((n) => !n.isRead).length,
      ) ??
      0;
}

// ─── Language Provider ──────────────────────────────────────────────────

/// Manages the current app locale.
/// Defaults to Arabic (ar).
@riverpod
class AppLanguage extends _$AppLanguage {
  @override
  Locale build() {
    return const Locale('ar');
  }

  void setLocale(Locale locale) {
    state = locale;
  }
}

// ─── Dark Mode Provider ─────────────────────────────────────────────────

/// Manages the dark/light mode toggle.
/// Defaults to dark mode (true) since the app is dark-themed.
@riverpod
class DarkMode extends _$DarkMode {
  @override
  bool build() {
    return true; // Dark mode by default
  }

  void toggle() {
    state = !state;
  }

  void setDarkMode(bool isDark) {
    state = isDark;
  }
}
