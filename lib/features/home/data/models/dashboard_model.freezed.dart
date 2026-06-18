// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DashboardStats _$DashboardStatsFromJson(Map<String, dynamic> json) {
  return _DashboardStats.fromJson(json);
}

/// @nodoc
mixin _$DashboardStats {
  @JsonKey(name: 'enrolled_courses')
  int get enrolledCourses => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_lessons')
  int get completedLessons => throw _privateConstructorUsedError;
  @JsonKey(name: 'certificates_earned')
  int get certificatesEarned => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DashboardStatsCopyWith<DashboardStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardStatsCopyWith<$Res> {
  factory $DashboardStatsCopyWith(
          DashboardStats value, $Res Function(DashboardStats) then) =
      _$DashboardStatsCopyWithImpl<$Res, DashboardStats>;
  @useResult
  $Res call(
      {@JsonKey(name: 'enrolled_courses') int enrolledCourses,
      @JsonKey(name: 'completed_lessons') int completedLessons,
      @JsonKey(name: 'certificates_earned') int certificatesEarned});
}

/// @nodoc
class _$DashboardStatsCopyWithImpl<$Res, $Val extends DashboardStats>
    implements $DashboardStatsCopyWith<$Res> {
  _$DashboardStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enrolledCourses = null,
    Object? completedLessons = null,
    Object? certificatesEarned = null,
  }) {
    return _then(_value.copyWith(
      enrolledCourses: null == enrolledCourses
          ? _value.enrolledCourses
          : enrolledCourses // ignore: cast_nullable_to_non_nullable
              as int,
      completedLessons: null == completedLessons
          ? _value.completedLessons
          : completedLessons // ignore: cast_nullable_to_non_nullable
              as int,
      certificatesEarned: null == certificatesEarned
          ? _value.certificatesEarned
          : certificatesEarned // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardStatsImplCopyWith<$Res>
    implements $DashboardStatsCopyWith<$Res> {
  factory _$$DashboardStatsImplCopyWith(_$DashboardStatsImpl value,
          $Res Function(_$DashboardStatsImpl) then) =
      __$$DashboardStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'enrolled_courses') int enrolledCourses,
      @JsonKey(name: 'completed_lessons') int completedLessons,
      @JsonKey(name: 'certificates_earned') int certificatesEarned});
}

/// @nodoc
class __$$DashboardStatsImplCopyWithImpl<$Res>
    extends _$DashboardStatsCopyWithImpl<$Res, _$DashboardStatsImpl>
    implements _$$DashboardStatsImplCopyWith<$Res> {
  __$$DashboardStatsImplCopyWithImpl(
      _$DashboardStatsImpl _value, $Res Function(_$DashboardStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enrolledCourses = null,
    Object? completedLessons = null,
    Object? certificatesEarned = null,
  }) {
    return _then(_$DashboardStatsImpl(
      enrolledCourses: null == enrolledCourses
          ? _value.enrolledCourses
          : enrolledCourses // ignore: cast_nullable_to_non_nullable
              as int,
      completedLessons: null == completedLessons
          ? _value.completedLessons
          : completedLessons // ignore: cast_nullable_to_non_nullable
              as int,
      certificatesEarned: null == certificatesEarned
          ? _value.certificatesEarned
          : certificatesEarned // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardStatsImpl implements _DashboardStats {
  const _$DashboardStatsImpl(
      {@JsonKey(name: 'enrolled_courses') this.enrolledCourses = 0,
      @JsonKey(name: 'completed_lessons') this.completedLessons = 0,
      @JsonKey(name: 'certificates_earned') this.certificatesEarned = 0});

  factory _$DashboardStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardStatsImplFromJson(json);

  @override
  @JsonKey(name: 'enrolled_courses')
  final int enrolledCourses;
  @override
  @JsonKey(name: 'completed_lessons')
  final int completedLessons;
  @override
  @JsonKey(name: 'certificates_earned')
  final int certificatesEarned;

  @override
  String toString() {
    return 'DashboardStats(enrolledCourses: $enrolledCourses, completedLessons: $completedLessons, certificatesEarned: $certificatesEarned)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardStatsImpl &&
            (identical(other.enrolledCourses, enrolledCourses) ||
                other.enrolledCourses == enrolledCourses) &&
            (identical(other.completedLessons, completedLessons) ||
                other.completedLessons == completedLessons) &&
            (identical(other.certificatesEarned, certificatesEarned) ||
                other.certificatesEarned == certificatesEarned));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, enrolledCourses, completedLessons, certificatesEarned);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardStatsImplCopyWith<_$DashboardStatsImpl> get copyWith =>
      __$$DashboardStatsImplCopyWithImpl<_$DashboardStatsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardStatsImplToJson(
      this,
    );
  }
}

abstract class _DashboardStats implements DashboardStats {
  const factory _DashboardStats(
          {@JsonKey(name: 'enrolled_courses') final int enrolledCourses,
          @JsonKey(name: 'completed_lessons') final int completedLessons,
          @JsonKey(name: 'certificates_earned') final int certificatesEarned}) =
      _$DashboardStatsImpl;

  factory _DashboardStats.fromJson(Map<String, dynamic> json) =
      _$DashboardStatsImpl.fromJson;

  @override
  @JsonKey(name: 'enrolled_courses')
  int get enrolledCourses;
  @override
  @JsonKey(name: 'completed_lessons')
  int get completedLessons;
  @override
  @JsonKey(name: 'certificates_earned')
  int get certificatesEarned;
  @override
  @JsonKey(ignore: true)
  _$$DashboardStatsImplCopyWith<_$DashboardStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContinueLearningItem _$ContinueLearningItemFromJson(Map<String, dynamic> json) {
  return _ContinueLearningItem.fromJson(json);
}

/// @nodoc
mixin _$ContinueLearningItem {
  @JsonKey(name: 'course_id')
  String get courseId => throw _privateConstructorUsedError;
  @JsonKey(name: 'course_title')
  String get courseTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'course_thumbnail')
  String get courseThumbnail => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_lesson_title')
  String get lastLessonTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'progress_percent')
  double get progressPercent => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContinueLearningItemCopyWith<ContinueLearningItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContinueLearningItemCopyWith<$Res> {
  factory $ContinueLearningItemCopyWith(ContinueLearningItem value,
          $Res Function(ContinueLearningItem) then) =
      _$ContinueLearningItemCopyWithImpl<$Res, ContinueLearningItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'course_id') String courseId,
      @JsonKey(name: 'course_title') String courseTitle,
      @JsonKey(name: 'course_thumbnail') String courseThumbnail,
      @JsonKey(name: 'last_lesson_title') String lastLessonTitle,
      @JsonKey(name: 'progress_percent') double progressPercent});
}

/// @nodoc
class _$ContinueLearningItemCopyWithImpl<$Res,
        $Val extends ContinueLearningItem>
    implements $ContinueLearningItemCopyWith<$Res> {
  _$ContinueLearningItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courseId = null,
    Object? courseTitle = null,
    Object? courseThumbnail = null,
    Object? lastLessonTitle = null,
    Object? progressPercent = null,
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
      courseThumbnail: null == courseThumbnail
          ? _value.courseThumbnail
          : courseThumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      lastLessonTitle: null == lastLessonTitle
          ? _value.lastLessonTitle
          : lastLessonTitle // ignore: cast_nullable_to_non_nullable
              as String,
      progressPercent: null == progressPercent
          ? _value.progressPercent
          : progressPercent // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContinueLearningItemImplCopyWith<$Res>
    implements $ContinueLearningItemCopyWith<$Res> {
  factory _$$ContinueLearningItemImplCopyWith(_$ContinueLearningItemImpl value,
          $Res Function(_$ContinueLearningItemImpl) then) =
      __$$ContinueLearningItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'course_id') String courseId,
      @JsonKey(name: 'course_title') String courseTitle,
      @JsonKey(name: 'course_thumbnail') String courseThumbnail,
      @JsonKey(name: 'last_lesson_title') String lastLessonTitle,
      @JsonKey(name: 'progress_percent') double progressPercent});
}

/// @nodoc
class __$$ContinueLearningItemImplCopyWithImpl<$Res>
    extends _$ContinueLearningItemCopyWithImpl<$Res, _$ContinueLearningItemImpl>
    implements _$$ContinueLearningItemImplCopyWith<$Res> {
  __$$ContinueLearningItemImplCopyWithImpl(_$ContinueLearningItemImpl _value,
      $Res Function(_$ContinueLearningItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courseId = null,
    Object? courseTitle = null,
    Object? courseThumbnail = null,
    Object? lastLessonTitle = null,
    Object? progressPercent = null,
  }) {
    return _then(_$ContinueLearningItemImpl(
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      courseTitle: null == courseTitle
          ? _value.courseTitle
          : courseTitle // ignore: cast_nullable_to_non_nullable
              as String,
      courseThumbnail: null == courseThumbnail
          ? _value.courseThumbnail
          : courseThumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      lastLessonTitle: null == lastLessonTitle
          ? _value.lastLessonTitle
          : lastLessonTitle // ignore: cast_nullable_to_non_nullable
              as String,
      progressPercent: null == progressPercent
          ? _value.progressPercent
          : progressPercent // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContinueLearningItemImpl implements _ContinueLearningItem {
  const _$ContinueLearningItemImpl(
      {@JsonKey(name: 'course_id') required this.courseId,
      @JsonKey(name: 'course_title') required this.courseTitle,
      @JsonKey(name: 'course_thumbnail') this.courseThumbnail = '',
      @JsonKey(name: 'last_lesson_title') this.lastLessonTitle = '',
      @JsonKey(name: 'progress_percent') this.progressPercent = 0.0});

  factory _$ContinueLearningItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContinueLearningItemImplFromJson(json);

  @override
  @JsonKey(name: 'course_id')
  final String courseId;
  @override
  @JsonKey(name: 'course_title')
  final String courseTitle;
  @override
  @JsonKey(name: 'course_thumbnail')
  final String courseThumbnail;
  @override
  @JsonKey(name: 'last_lesson_title')
  final String lastLessonTitle;
  @override
  @JsonKey(name: 'progress_percent')
  final double progressPercent;

  @override
  String toString() {
    return 'ContinueLearningItem(courseId: $courseId, courseTitle: $courseTitle, courseThumbnail: $courseThumbnail, lastLessonTitle: $lastLessonTitle, progressPercent: $progressPercent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContinueLearningItemImpl &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.courseTitle, courseTitle) ||
                other.courseTitle == courseTitle) &&
            (identical(other.courseThumbnail, courseThumbnail) ||
                other.courseThumbnail == courseThumbnail) &&
            (identical(other.lastLessonTitle, lastLessonTitle) ||
                other.lastLessonTitle == lastLessonTitle) &&
            (identical(other.progressPercent, progressPercent) ||
                other.progressPercent == progressPercent));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, courseId, courseTitle,
      courseThumbnail, lastLessonTitle, progressPercent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContinueLearningItemImplCopyWith<_$ContinueLearningItemImpl>
      get copyWith =>
          __$$ContinueLearningItemImplCopyWithImpl<_$ContinueLearningItemImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContinueLearningItemImplToJson(
      this,
    );
  }
}

abstract class _ContinueLearningItem implements ContinueLearningItem {
  const factory _ContinueLearningItem(
          {@JsonKey(name: 'course_id') required final String courseId,
          @JsonKey(name: 'course_title') required final String courseTitle,
          @JsonKey(name: 'course_thumbnail') final String courseThumbnail,
          @JsonKey(name: 'last_lesson_title') final String lastLessonTitle,
          @JsonKey(name: 'progress_percent') final double progressPercent}) =
      _$ContinueLearningItemImpl;

  factory _ContinueLearningItem.fromJson(Map<String, dynamic> json) =
      _$ContinueLearningItemImpl.fromJson;

  @override
  @JsonKey(name: 'course_id')
  String get courseId;
  @override
  @JsonKey(name: 'course_title')
  String get courseTitle;
  @override
  @JsonKey(name: 'course_thumbnail')
  String get courseThumbnail;
  @override
  @JsonKey(name: 'last_lesson_title')
  String get lastLessonTitle;
  @override
  @JsonKey(name: 'progress_percent')
  double get progressPercent;
  @override
  @JsonKey(ignore: true)
  _$$ContinueLearningItemImplCopyWith<_$ContinueLearningItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}

FeaturedCourse _$FeaturedCourseFromJson(Map<String, dynamic> json) {
  return _FeaturedCourse.fromJson(json);
}

/// @nodoc
mixin _$FeaturedCourse {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get thumbnail => throw _privateConstructorUsedError;
  @JsonKey(name: 'instructor_name')
  String get instructorName => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  @JsonKey(name: 'students_count')
  int get studentsCount => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_free')
  bool get isFree => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeaturedCourseCopyWith<FeaturedCourse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeaturedCourseCopyWith<$Res> {
  factory $FeaturedCourseCopyWith(
          FeaturedCourse value, $Res Function(FeaturedCourse) then) =
      _$FeaturedCourseCopyWithImpl<$Res, FeaturedCourse>;
  @useResult
  $Res call(
      {String id,
      String title,
      String thumbnail,
      @JsonKey(name: 'instructor_name') String instructorName,
      double rating,
      @JsonKey(name: 'students_count') int studentsCount,
      double? price,
      @JsonKey(name: 'is_free') bool isFree,
      String category});
}

/// @nodoc
class _$FeaturedCourseCopyWithImpl<$Res, $Val extends FeaturedCourse>
    implements $FeaturedCourseCopyWith<$Res> {
  _$FeaturedCourseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? thumbnail = null,
    Object? instructorName = null,
    Object? rating = null,
    Object? studentsCount = null,
    Object? price = freezed,
    Object? isFree = null,
    Object? category = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      instructorName: null == instructorName
          ? _value.instructorName
          : instructorName // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      studentsCount: null == studentsCount
          ? _value.studentsCount
          : studentsCount // ignore: cast_nullable_to_non_nullable
              as int,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      isFree: null == isFree
          ? _value.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeaturedCourseImplCopyWith<$Res>
    implements $FeaturedCourseCopyWith<$Res> {
  factory _$$FeaturedCourseImplCopyWith(_$FeaturedCourseImpl value,
          $Res Function(_$FeaturedCourseImpl) then) =
      __$$FeaturedCourseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String thumbnail,
      @JsonKey(name: 'instructor_name') String instructorName,
      double rating,
      @JsonKey(name: 'students_count') int studentsCount,
      double? price,
      @JsonKey(name: 'is_free') bool isFree,
      String category});
}

/// @nodoc
class __$$FeaturedCourseImplCopyWithImpl<$Res>
    extends _$FeaturedCourseCopyWithImpl<$Res, _$FeaturedCourseImpl>
    implements _$$FeaturedCourseImplCopyWith<$Res> {
  __$$FeaturedCourseImplCopyWithImpl(
      _$FeaturedCourseImpl _value, $Res Function(_$FeaturedCourseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? thumbnail = null,
    Object? instructorName = null,
    Object? rating = null,
    Object? studentsCount = null,
    Object? price = freezed,
    Object? isFree = null,
    Object? category = null,
  }) {
    return _then(_$FeaturedCourseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      instructorName: null == instructorName
          ? _value.instructorName
          : instructorName // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      studentsCount: null == studentsCount
          ? _value.studentsCount
          : studentsCount // ignore: cast_nullable_to_non_nullable
              as int,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      isFree: null == isFree
          ? _value.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeaturedCourseImpl implements _FeaturedCourse {
  const _$FeaturedCourseImpl(
      {required this.id,
      required this.title,
      this.thumbnail = '',
      @JsonKey(name: 'instructor_name') this.instructorName = '',
      this.rating = 0.0,
      @JsonKey(name: 'students_count') this.studentsCount = 0,
      this.price,
      @JsonKey(name: 'is_free') this.isFree = false,
      this.category = ''});

  factory _$FeaturedCourseImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeaturedCourseImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  @JsonKey()
  final String thumbnail;
  @override
  @JsonKey(name: 'instructor_name')
  final String instructorName;
  @override
  @JsonKey()
  final double rating;
  @override
  @JsonKey(name: 'students_count')
  final int studentsCount;
  @override
  final double? price;
  @override
  @JsonKey(name: 'is_free')
  final bool isFree;
  @override
  @JsonKey()
  final String category;

  @override
  String toString() {
    return 'FeaturedCourse(id: $id, title: $title, thumbnail: $thumbnail, instructorName: $instructorName, rating: $rating, studentsCount: $studentsCount, price: $price, isFree: $isFree, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeaturedCourseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.instructorName, instructorName) ||
                other.instructorName == instructorName) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.studentsCount, studentsCount) ||
                other.studentsCount == studentsCount) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.isFree, isFree) || other.isFree == isFree) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, thumbnail,
      instructorName, rating, studentsCount, price, isFree, category);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeaturedCourseImplCopyWith<_$FeaturedCourseImpl> get copyWith =>
      __$$FeaturedCourseImplCopyWithImpl<_$FeaturedCourseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeaturedCourseImplToJson(
      this,
    );
  }
}

abstract class _FeaturedCourse implements FeaturedCourse {
  const factory _FeaturedCourse(
      {required final String id,
      required final String title,
      final String thumbnail,
      @JsonKey(name: 'instructor_name') final String instructorName,
      final double rating,
      @JsonKey(name: 'students_count') final int studentsCount,
      final double? price,
      @JsonKey(name: 'is_free') final bool isFree,
      final String category}) = _$FeaturedCourseImpl;

  factory _FeaturedCourse.fromJson(Map<String, dynamic> json) =
      _$FeaturedCourseImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get thumbnail;
  @override
  @JsonKey(name: 'instructor_name')
  String get instructorName;
  @override
  double get rating;
  @override
  @JsonKey(name: 'students_count')
  int get studentsCount;
  @override
  double? get price;
  @override
  @JsonKey(name: 'is_free')
  bool get isFree;
  @override
  String get category;
  @override
  @JsonKey(ignore: true)
  _$$FeaturedCourseImplCopyWith<_$FeaturedCourseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
