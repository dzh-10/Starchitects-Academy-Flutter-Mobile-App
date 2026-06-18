// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OverallProgress _$OverallProgressFromJson(Map<String, dynamic> json) {
  return _OverallProgress.fromJson(json);
}

/// @nodoc
mixin _$OverallProgress {
  @JsonKey(name: 'total_courses')
  int get totalCourses => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_courses')
  int get completedCourses => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_lessons')
  int get totalLessons => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_lessons')
  int get completedLessons => throw _privateConstructorUsedError;
  @JsonKey(name: 'overall_percent')
  double get overallPercent => throw _privateConstructorUsedError;
  @JsonKey(name: 'weekly_hours')
  List<double> get weeklyHours => throw _privateConstructorUsedError;
  @JsonKey(name: 'course_progress')
  List<CourseProgressItem> get courseProgress =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OverallProgressCopyWith<OverallProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OverallProgressCopyWith<$Res> {
  factory $OverallProgressCopyWith(
          OverallProgress value, $Res Function(OverallProgress) then) =
      _$OverallProgressCopyWithImpl<$Res, OverallProgress>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_courses') int totalCourses,
      @JsonKey(name: 'completed_courses') int completedCourses,
      @JsonKey(name: 'total_lessons') int totalLessons,
      @JsonKey(name: 'completed_lessons') int completedLessons,
      @JsonKey(name: 'overall_percent') double overallPercent,
      @JsonKey(name: 'weekly_hours') List<double> weeklyHours,
      @JsonKey(name: 'course_progress')
      List<CourseProgressItem> courseProgress});
}

/// @nodoc
class _$OverallProgressCopyWithImpl<$Res, $Val extends OverallProgress>
    implements $OverallProgressCopyWith<$Res> {
  _$OverallProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCourses = null,
    Object? completedCourses = null,
    Object? totalLessons = null,
    Object? completedLessons = null,
    Object? overallPercent = null,
    Object? weeklyHours = null,
    Object? courseProgress = null,
  }) {
    return _then(_value.copyWith(
      totalCourses: null == totalCourses
          ? _value.totalCourses
          : totalCourses // ignore: cast_nullable_to_non_nullable
              as int,
      completedCourses: null == completedCourses
          ? _value.completedCourses
          : completedCourses // ignore: cast_nullable_to_non_nullable
              as int,
      totalLessons: null == totalLessons
          ? _value.totalLessons
          : totalLessons // ignore: cast_nullable_to_non_nullable
              as int,
      completedLessons: null == completedLessons
          ? _value.completedLessons
          : completedLessons // ignore: cast_nullable_to_non_nullable
              as int,
      overallPercent: null == overallPercent
          ? _value.overallPercent
          : overallPercent // ignore: cast_nullable_to_non_nullable
              as double,
      weeklyHours: null == weeklyHours
          ? _value.weeklyHours
          : weeklyHours // ignore: cast_nullable_to_non_nullable
              as List<double>,
      courseProgress: null == courseProgress
          ? _value.courseProgress
          : courseProgress // ignore: cast_nullable_to_non_nullable
              as List<CourseProgressItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OverallProgressImplCopyWith<$Res>
    implements $OverallProgressCopyWith<$Res> {
  factory _$$OverallProgressImplCopyWith(_$OverallProgressImpl value,
          $Res Function(_$OverallProgressImpl) then) =
      __$$OverallProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_courses') int totalCourses,
      @JsonKey(name: 'completed_courses') int completedCourses,
      @JsonKey(name: 'total_lessons') int totalLessons,
      @JsonKey(name: 'completed_lessons') int completedLessons,
      @JsonKey(name: 'overall_percent') double overallPercent,
      @JsonKey(name: 'weekly_hours') List<double> weeklyHours,
      @JsonKey(name: 'course_progress')
      List<CourseProgressItem> courseProgress});
}

/// @nodoc
class __$$OverallProgressImplCopyWithImpl<$Res>
    extends _$OverallProgressCopyWithImpl<$Res, _$OverallProgressImpl>
    implements _$$OverallProgressImplCopyWith<$Res> {
  __$$OverallProgressImplCopyWithImpl(
      _$OverallProgressImpl _value, $Res Function(_$OverallProgressImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCourses = null,
    Object? completedCourses = null,
    Object? totalLessons = null,
    Object? completedLessons = null,
    Object? overallPercent = null,
    Object? weeklyHours = null,
    Object? courseProgress = null,
  }) {
    return _then(_$OverallProgressImpl(
      totalCourses: null == totalCourses
          ? _value.totalCourses
          : totalCourses // ignore: cast_nullable_to_non_nullable
              as int,
      completedCourses: null == completedCourses
          ? _value.completedCourses
          : completedCourses // ignore: cast_nullable_to_non_nullable
              as int,
      totalLessons: null == totalLessons
          ? _value.totalLessons
          : totalLessons // ignore: cast_nullable_to_non_nullable
              as int,
      completedLessons: null == completedLessons
          ? _value.completedLessons
          : completedLessons // ignore: cast_nullable_to_non_nullable
              as int,
      overallPercent: null == overallPercent
          ? _value.overallPercent
          : overallPercent // ignore: cast_nullable_to_non_nullable
              as double,
      weeklyHours: null == weeklyHours
          ? _value._weeklyHours
          : weeklyHours // ignore: cast_nullable_to_non_nullable
              as List<double>,
      courseProgress: null == courseProgress
          ? _value._courseProgress
          : courseProgress // ignore: cast_nullable_to_non_nullable
              as List<CourseProgressItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OverallProgressImpl implements _OverallProgress {
  const _$OverallProgressImpl(
      {@JsonKey(name: 'total_courses') required this.totalCourses,
      @JsonKey(name: 'completed_courses') required this.completedCourses,
      @JsonKey(name: 'total_lessons') required this.totalLessons,
      @JsonKey(name: 'completed_lessons') required this.completedLessons,
      @JsonKey(name: 'overall_percent') required this.overallPercent,
      @JsonKey(name: 'weekly_hours') final List<double> weeklyHours = const [],
      @JsonKey(name: 'course_progress')
      final List<CourseProgressItem> courseProgress = const []})
      : _weeklyHours = weeklyHours,
        _courseProgress = courseProgress;

  factory _$OverallProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$OverallProgressImplFromJson(json);

  @override
  @JsonKey(name: 'total_courses')
  final int totalCourses;
  @override
  @JsonKey(name: 'completed_courses')
  final int completedCourses;
  @override
  @JsonKey(name: 'total_lessons')
  final int totalLessons;
  @override
  @JsonKey(name: 'completed_lessons')
  final int completedLessons;
  @override
  @JsonKey(name: 'overall_percent')
  final double overallPercent;
  final List<double> _weeklyHours;
  @override
  @JsonKey(name: 'weekly_hours')
  List<double> get weeklyHours {
    if (_weeklyHours is EqualUnmodifiableListView) return _weeklyHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weeklyHours);
  }

  final List<CourseProgressItem> _courseProgress;
  @override
  @JsonKey(name: 'course_progress')
  List<CourseProgressItem> get courseProgress {
    if (_courseProgress is EqualUnmodifiableListView) return _courseProgress;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_courseProgress);
  }

  @override
  String toString() {
    return 'OverallProgress(totalCourses: $totalCourses, completedCourses: $completedCourses, totalLessons: $totalLessons, completedLessons: $completedLessons, overallPercent: $overallPercent, weeklyHours: $weeklyHours, courseProgress: $courseProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OverallProgressImpl &&
            (identical(other.totalCourses, totalCourses) ||
                other.totalCourses == totalCourses) &&
            (identical(other.completedCourses, completedCourses) ||
                other.completedCourses == completedCourses) &&
            (identical(other.totalLessons, totalLessons) ||
                other.totalLessons == totalLessons) &&
            (identical(other.completedLessons, completedLessons) ||
                other.completedLessons == completedLessons) &&
            (identical(other.overallPercent, overallPercent) ||
                other.overallPercent == overallPercent) &&
            const DeepCollectionEquality()
                .equals(other._weeklyHours, _weeklyHours) &&
            const DeepCollectionEquality()
                .equals(other._courseProgress, _courseProgress));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalCourses,
      completedCourses,
      totalLessons,
      completedLessons,
      overallPercent,
      const DeepCollectionEquality().hash(_weeklyHours),
      const DeepCollectionEquality().hash(_courseProgress));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OverallProgressImplCopyWith<_$OverallProgressImpl> get copyWith =>
      __$$OverallProgressImplCopyWithImpl<_$OverallProgressImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OverallProgressImplToJson(
      this,
    );
  }
}

abstract class _OverallProgress implements OverallProgress {
  const factory _OverallProgress(
      {@JsonKey(name: 'total_courses') required final int totalCourses,
      @JsonKey(name: 'completed_courses') required final int completedCourses,
      @JsonKey(name: 'total_lessons') required final int totalLessons,
      @JsonKey(name: 'completed_lessons') required final int completedLessons,
      @JsonKey(name: 'overall_percent') required final double overallPercent,
      @JsonKey(name: 'weekly_hours') final List<double> weeklyHours,
      @JsonKey(name: 'course_progress')
      final List<CourseProgressItem> courseProgress}) = _$OverallProgressImpl;

  factory _OverallProgress.fromJson(Map<String, dynamic> json) =
      _$OverallProgressImpl.fromJson;

  @override
  @JsonKey(name: 'total_courses')
  int get totalCourses;
  @override
  @JsonKey(name: 'completed_courses')
  int get completedCourses;
  @override
  @JsonKey(name: 'total_lessons')
  int get totalLessons;
  @override
  @JsonKey(name: 'completed_lessons')
  int get completedLessons;
  @override
  @JsonKey(name: 'overall_percent')
  double get overallPercent;
  @override
  @JsonKey(name: 'weekly_hours')
  List<double> get weeklyHours;
  @override
  @JsonKey(name: 'course_progress')
  List<CourseProgressItem> get courseProgress;
  @override
  @JsonKey(ignore: true)
  _$$OverallProgressImplCopyWith<_$OverallProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CourseProgressItem _$CourseProgressItemFromJson(Map<String, dynamic> json) {
  return _CourseProgressItem.fromJson(json);
}

/// @nodoc
mixin _$CourseProgressItem {
  @JsonKey(name: 'course_id')
  String get courseId => throw _privateConstructorUsedError;
  @JsonKey(name: 'course_title')
  String get courseTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'course_thumbnail')
  String? get courseThumbnail => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_lessons')
  int get completedLessons => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_lessons')
  int get totalLessons => throw _privateConstructorUsedError;
  @JsonKey(name: 'progress_percent')
  double get progressPercent => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_accessed')
  DateTime? get lastAccessed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CourseProgressItemCopyWith<CourseProgressItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseProgressItemCopyWith<$Res> {
  factory $CourseProgressItemCopyWith(
          CourseProgressItem value, $Res Function(CourseProgressItem) then) =
      _$CourseProgressItemCopyWithImpl<$Res, CourseProgressItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'course_id') String courseId,
      @JsonKey(name: 'course_title') String courseTitle,
      @JsonKey(name: 'course_thumbnail') String? courseThumbnail,
      @JsonKey(name: 'completed_lessons') int completedLessons,
      @JsonKey(name: 'total_lessons') int totalLessons,
      @JsonKey(name: 'progress_percent') double progressPercent,
      @JsonKey(name: 'last_accessed') DateTime? lastAccessed});
}

/// @nodoc
class _$CourseProgressItemCopyWithImpl<$Res, $Val extends CourseProgressItem>
    implements $CourseProgressItemCopyWith<$Res> {
  _$CourseProgressItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courseId = null,
    Object? courseTitle = null,
    Object? courseThumbnail = freezed,
    Object? completedLessons = null,
    Object? totalLessons = null,
    Object? progressPercent = null,
    Object? lastAccessed = freezed,
  }) {
    return _then(_value.copyWith(
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      courseTitle: null == courseTitle
          ? _value.courseTitle
          : courseTitle // ignore: cast_nullable_to_non_nullable
              as String,
      courseThumbnail: freezed == courseThumbnail
          ? _value.courseThumbnail
          : courseThumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
      completedLessons: null == completedLessons
          ? _value.completedLessons
          : completedLessons // ignore: cast_nullable_to_non_nullable
              as int,
      totalLessons: null == totalLessons
          ? _value.totalLessons
          : totalLessons // ignore: cast_nullable_to_non_nullable
              as int,
      progressPercent: null == progressPercent
          ? _value.progressPercent
          : progressPercent // ignore: cast_nullable_to_non_nullable
              as double,
      lastAccessed: freezed == lastAccessed
          ? _value.lastAccessed
          : lastAccessed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CourseProgressItemImplCopyWith<$Res>
    implements $CourseProgressItemCopyWith<$Res> {
  factory _$$CourseProgressItemImplCopyWith(_$CourseProgressItemImpl value,
          $Res Function(_$CourseProgressItemImpl) then) =
      __$$CourseProgressItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'course_id') String courseId,
      @JsonKey(name: 'course_title') String courseTitle,
      @JsonKey(name: 'course_thumbnail') String? courseThumbnail,
      @JsonKey(name: 'completed_lessons') int completedLessons,
      @JsonKey(name: 'total_lessons') int totalLessons,
      @JsonKey(name: 'progress_percent') double progressPercent,
      @JsonKey(name: 'last_accessed') DateTime? lastAccessed});
}

/// @nodoc
class __$$CourseProgressItemImplCopyWithImpl<$Res>
    extends _$CourseProgressItemCopyWithImpl<$Res, _$CourseProgressItemImpl>
    implements _$$CourseProgressItemImplCopyWith<$Res> {
  __$$CourseProgressItemImplCopyWithImpl(_$CourseProgressItemImpl _value,
      $Res Function(_$CourseProgressItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courseId = null,
    Object? courseTitle = null,
    Object? courseThumbnail = freezed,
    Object? completedLessons = null,
    Object? totalLessons = null,
    Object? progressPercent = null,
    Object? lastAccessed = freezed,
  }) {
    return _then(_$CourseProgressItemImpl(
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      courseTitle: null == courseTitle
          ? _value.courseTitle
          : courseTitle // ignore: cast_nullable_to_non_nullable
              as String,
      courseThumbnail: freezed == courseThumbnail
          ? _value.courseThumbnail
          : courseThumbnail // ignore: cast_nullable_to_non_nullable
              as String?,
      completedLessons: null == completedLessons
          ? _value.completedLessons
          : completedLessons // ignore: cast_nullable_to_non_nullable
              as int,
      totalLessons: null == totalLessons
          ? _value.totalLessons
          : totalLessons // ignore: cast_nullable_to_non_nullable
              as int,
      progressPercent: null == progressPercent
          ? _value.progressPercent
          : progressPercent // ignore: cast_nullable_to_non_nullable
              as double,
      lastAccessed: freezed == lastAccessed
          ? _value.lastAccessed
          : lastAccessed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseProgressItemImpl implements _CourseProgressItem {
  const _$CourseProgressItemImpl(
      {@JsonKey(name: 'course_id') required this.courseId,
      @JsonKey(name: 'course_title') required this.courseTitle,
      @JsonKey(name: 'course_thumbnail') this.courseThumbnail,
      @JsonKey(name: 'completed_lessons') required this.completedLessons,
      @JsonKey(name: 'total_lessons') required this.totalLessons,
      @JsonKey(name: 'progress_percent') required this.progressPercent,
      @JsonKey(name: 'last_accessed') this.lastAccessed});

  factory _$CourseProgressItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseProgressItemImplFromJson(json);

  @override
  @JsonKey(name: 'course_id')
  final String courseId;
  @override
  @JsonKey(name: 'course_title')
  final String courseTitle;
  @override
  @JsonKey(name: 'course_thumbnail')
  final String? courseThumbnail;
  @override
  @JsonKey(name: 'completed_lessons')
  final int completedLessons;
  @override
  @JsonKey(name: 'total_lessons')
  final int totalLessons;
  @override
  @JsonKey(name: 'progress_percent')
  final double progressPercent;
  @override
  @JsonKey(name: 'last_accessed')
  final DateTime? lastAccessed;

  @override
  String toString() {
    return 'CourseProgressItem(courseId: $courseId, courseTitle: $courseTitle, courseThumbnail: $courseThumbnail, completedLessons: $completedLessons, totalLessons: $totalLessons, progressPercent: $progressPercent, lastAccessed: $lastAccessed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseProgressItemImpl &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.courseTitle, courseTitle) ||
                other.courseTitle == courseTitle) &&
            (identical(other.courseThumbnail, courseThumbnail) ||
                other.courseThumbnail == courseThumbnail) &&
            (identical(other.completedLessons, completedLessons) ||
                other.completedLessons == completedLessons) &&
            (identical(other.totalLessons, totalLessons) ||
                other.totalLessons == totalLessons) &&
            (identical(other.progressPercent, progressPercent) ||
                other.progressPercent == progressPercent) &&
            (identical(other.lastAccessed, lastAccessed) ||
                other.lastAccessed == lastAccessed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      courseId,
      courseTitle,
      courseThumbnail,
      completedLessons,
      totalLessons,
      progressPercent,
      lastAccessed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseProgressItemImplCopyWith<_$CourseProgressItemImpl> get copyWith =>
      __$$CourseProgressItemImplCopyWithImpl<_$CourseProgressItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseProgressItemImplToJson(
      this,
    );
  }
}

abstract class _CourseProgressItem implements CourseProgressItem {
  const factory _CourseProgressItem(
      {@JsonKey(name: 'course_id') required final String courseId,
      @JsonKey(name: 'course_title') required final String courseTitle,
      @JsonKey(name: 'course_thumbnail') final String? courseThumbnail,
      @JsonKey(name: 'completed_lessons') required final int completedLessons,
      @JsonKey(name: 'total_lessons') required final int totalLessons,
      @JsonKey(name: 'progress_percent') required final double progressPercent,
      @JsonKey(name: 'last_accessed')
      final DateTime? lastAccessed}) = _$CourseProgressItemImpl;

  factory _CourseProgressItem.fromJson(Map<String, dynamic> json) =
      _$CourseProgressItemImpl.fromJson;

  @override
  @JsonKey(name: 'course_id')
  String get courseId;
  @override
  @JsonKey(name: 'course_title')
  String get courseTitle;
  @override
  @JsonKey(name: 'course_thumbnail')
  String? get courseThumbnail;
  @override
  @JsonKey(name: 'completed_lessons')
  int get completedLessons;
  @override
  @JsonKey(name: 'total_lessons')
  int get totalLessons;
  @override
  @JsonKey(name: 'progress_percent')
  double get progressPercent;
  @override
  @JsonKey(name: 'last_accessed')
  DateTime? get lastAccessed;
  @override
  @JsonKey(ignore: true)
  _$$CourseProgressItemImplCopyWith<_$CourseProgressItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
