import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starchitects_app/features/live_sessions/data/models/session_model.dart';
import 'package:starchitects_app/features/live_sessions/data/repositories/live_session_repository.dart';

part 'live_session_provider.g.dart';

/// Fetches sessions filtered by status.
/// Pass 'upcoming', 'live', or null for all sessions.
@riverpod
Future<List<SessionModel>> sessionsList(
  Ref ref,
  String? status,
) async {
  final repository = ref.read(liveSessionRepositoryProvider);
  return repository.getSessions(status: status);
}

/// Derived provider: only upcoming sessions.
@riverpod
Future<List<SessionModel>> upcomingSessions(Ref ref) async {
  return ref.watch(sessionsListProvider('upcoming').future);
}

/// Derived provider: only currently live sessions.
@riverpod
Future<List<SessionModel>> liveSessions(Ref ref) async {
  return ref.watch(sessionsListProvider('live').future);
}

/// Fetches a LiveKit token for a specific session.
@riverpod
Future<LiveKitTokenResponse> sessionToken(
  Ref ref,
  String sessionId,
) async {
  final repository = ref.read(liveSessionRepositoryProvider);
  return repository.getSessionToken(sessionId);
}
