// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sessionsListHash() => r'004f0f625ab27a0e785a9aeb8b8e6efaa96b77f1';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Fetches sessions filtered by status.
/// Pass 'upcoming', 'live', or null for all sessions.
///
/// Copied from [sessionsList].
@ProviderFor(sessionsList)
const sessionsListProvider = SessionsListFamily();

/// Fetches sessions filtered by status.
/// Pass 'upcoming', 'live', or null for all sessions.
///
/// Copied from [sessionsList].
class SessionsListFamily extends Family<AsyncValue<List<SessionModel>>> {
  /// Fetches sessions filtered by status.
  /// Pass 'upcoming', 'live', or null for all sessions.
  ///
  /// Copied from [sessionsList].
  const SessionsListFamily();

  /// Fetches sessions filtered by status.
  /// Pass 'upcoming', 'live', or null for all sessions.
  ///
  /// Copied from [sessionsList].
  SessionsListProvider call(
    String? status,
  ) {
    return SessionsListProvider(
      status,
    );
  }

  @override
  SessionsListProvider getProviderOverride(
    covariant SessionsListProvider provider,
  ) {
    return call(
      provider.status,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'sessionsListProvider';
}

/// Fetches sessions filtered by status.
/// Pass 'upcoming', 'live', or null for all sessions.
///
/// Copied from [sessionsList].
class SessionsListProvider
    extends AutoDisposeFutureProvider<List<SessionModel>> {
  /// Fetches sessions filtered by status.
  /// Pass 'upcoming', 'live', or null for all sessions.
  ///
  /// Copied from [sessionsList].
  SessionsListProvider(
    String? status,
  ) : this._internal(
          (ref) => sessionsList(
            ref as SessionsListRef,
            status,
          ),
          from: sessionsListProvider,
          name: r'sessionsListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sessionsListHash,
          dependencies: SessionsListFamily._dependencies,
          allTransitiveDependencies:
              SessionsListFamily._allTransitiveDependencies,
          status: status,
        );

  SessionsListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.status,
  }) : super.internal();

  final String? status;

  @override
  Override overrideWith(
    FutureOr<List<SessionModel>> Function(SessionsListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SessionsListProvider._internal(
        (ref) => create(ref as SessionsListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        status: status,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<SessionModel>> createElement() {
    return _SessionsListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SessionsListProvider && other.status == status;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SessionsListRef on AutoDisposeFutureProviderRef<List<SessionModel>> {
  /// The parameter `status` of this provider.
  String? get status;
}

class _SessionsListProviderElement
    extends AutoDisposeFutureProviderElement<List<SessionModel>>
    with SessionsListRef {
  _SessionsListProviderElement(super.provider);

  @override
  String? get status => (origin as SessionsListProvider).status;
}

String _$upcomingSessionsHash() => r'ba8b4a7995f629d9e7fc4ee5145283eba7c1d402';

/// Derived provider: only upcoming sessions.
///
/// Copied from [upcomingSessions].
@ProviderFor(upcomingSessions)
final upcomingSessionsProvider =
    AutoDisposeFutureProvider<List<SessionModel>>.internal(
  upcomingSessions,
  name: r'upcomingSessionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$upcomingSessionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UpcomingSessionsRef = AutoDisposeFutureProviderRef<List<SessionModel>>;
String _$liveSessionsHash() => r'1e34a145ec8ab5a46c3a6c8ceacb252a7490ad08';

/// Derived provider: only currently live sessions.
///
/// Copied from [liveSessions].
@ProviderFor(liveSessions)
final liveSessionsProvider =
    AutoDisposeFutureProvider<List<SessionModel>>.internal(
  liveSessions,
  name: r'liveSessionsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$liveSessionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LiveSessionsRef = AutoDisposeFutureProviderRef<List<SessionModel>>;
String _$sessionTokenHash() => r'6f0967364cceaf2af2023fac699d10700147bda2';

/// Fetches a LiveKit token for a specific session.
///
/// Copied from [sessionToken].
@ProviderFor(sessionToken)
const sessionTokenProvider = SessionTokenFamily();

/// Fetches a LiveKit token for a specific session.
///
/// Copied from [sessionToken].
class SessionTokenFamily extends Family<AsyncValue<LiveKitTokenResponse>> {
  /// Fetches a LiveKit token for a specific session.
  ///
  /// Copied from [sessionToken].
  const SessionTokenFamily();

  /// Fetches a LiveKit token for a specific session.
  ///
  /// Copied from [sessionToken].
  SessionTokenProvider call(
    String sessionId,
  ) {
    return SessionTokenProvider(
      sessionId,
    );
  }

  @override
  SessionTokenProvider getProviderOverride(
    covariant SessionTokenProvider provider,
  ) {
    return call(
      provider.sessionId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'sessionTokenProvider';
}

/// Fetches a LiveKit token for a specific session.
///
/// Copied from [sessionToken].
class SessionTokenProvider
    extends AutoDisposeFutureProvider<LiveKitTokenResponse> {
  /// Fetches a LiveKit token for a specific session.
  ///
  /// Copied from [sessionToken].
  SessionTokenProvider(
    String sessionId,
  ) : this._internal(
          (ref) => sessionToken(
            ref as SessionTokenRef,
            sessionId,
          ),
          from: sessionTokenProvider,
          name: r'sessionTokenProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sessionTokenHash,
          dependencies: SessionTokenFamily._dependencies,
          allTransitiveDependencies:
              SessionTokenFamily._allTransitiveDependencies,
          sessionId: sessionId,
        );

  SessionTokenProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sessionId,
  }) : super.internal();

  final String sessionId;

  @override
  Override overrideWith(
    FutureOr<LiveKitTokenResponse> Function(SessionTokenRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SessionTokenProvider._internal(
        (ref) => create(ref as SessionTokenRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sessionId: sessionId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LiveKitTokenResponse> createElement() {
    return _SessionTokenProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SessionTokenProvider && other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SessionTokenRef on AutoDisposeFutureProviderRef<LiveKitTokenResponse> {
  /// The parameter `sessionId` of this provider.
  String get sessionId;
}

class _SessionTokenProviderElement
    extends AutoDisposeFutureProviderElement<LiveKitTokenResponse>
    with SessionTokenRef {
  _SessionTokenProviderElement(super.provider);

  @override
  String get sessionId => (origin as SessionTokenProvider).sessionId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
