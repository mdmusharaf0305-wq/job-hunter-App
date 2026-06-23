// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_metrics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeekCount _$WeekCountFromJson(Map<String, dynamic> json) {
  return _WeekCount.fromJson(json);
}

/// @nodoc
mixin _$WeekCount {
  String get week => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeekCountCopyWith<WeekCount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeekCountCopyWith<$Res> {
  factory $WeekCountCopyWith(WeekCount value, $Res Function(WeekCount) then) =
      _$WeekCountCopyWithImpl<$Res, WeekCount>;
  @useResult
  $Res call({String week, int count});
}

/// @nodoc
class _$WeekCountCopyWithImpl<$Res, $Val extends WeekCount>
    implements $WeekCountCopyWith<$Res> {
  _$WeekCountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? week = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      week: null == week
          ? _value.week
          : week // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeekCountImplCopyWith<$Res>
    implements $WeekCountCopyWith<$Res> {
  factory _$$WeekCountImplCopyWith(
          _$WeekCountImpl value, $Res Function(_$WeekCountImpl) then) =
      __$$WeekCountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String week, int count});
}

/// @nodoc
class __$$WeekCountImplCopyWithImpl<$Res>
    extends _$WeekCountCopyWithImpl<$Res, _$WeekCountImpl>
    implements _$$WeekCountImplCopyWith<$Res> {
  __$$WeekCountImplCopyWithImpl(
      _$WeekCountImpl _value, $Res Function(_$WeekCountImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? week = null,
    Object? count = null,
  }) {
    return _then(_$WeekCountImpl(
      week: null == week
          ? _value.week
          : week // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeekCountImpl implements _WeekCount {
  const _$WeekCountImpl({required this.week, required this.count});

  factory _$WeekCountImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeekCountImplFromJson(json);

  @override
  final String week;
  @override
  final int count;

  @override
  String toString() {
    return 'WeekCount(week: $week, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeekCountImpl &&
            (identical(other.week, week) || other.week == week) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, week, count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeekCountImplCopyWith<_$WeekCountImpl> get copyWith =>
      __$$WeekCountImplCopyWithImpl<_$WeekCountImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeekCountImplToJson(
      this,
    );
  }
}

abstract class _WeekCount implements WeekCount {
  const factory _WeekCount(
      {required final String week, required final int count}) = _$WeekCountImpl;

  factory _WeekCount.fromJson(Map<String, dynamic> json) =
      _$WeekCountImpl.fromJson;

  @override
  String get week;
  @override
  int get count;
  @override
  @JsonKey(ignore: true)
  _$$WeekCountImplCopyWith<_$WeekCountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecruiterResponseCount _$RecruiterResponseCountFromJson(
    Map<String, dynamic> json) {
  return _RecruiterResponseCount.fromJson(json);
}

/// @nodoc
mixin _$RecruiterResponseCount {
  String get name => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecruiterResponseCountCopyWith<RecruiterResponseCount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecruiterResponseCountCopyWith<$Res> {
  factory $RecruiterResponseCountCopyWith(RecruiterResponseCount value,
          $Res Function(RecruiterResponseCount) then) =
      _$RecruiterResponseCountCopyWithImpl<$Res, RecruiterResponseCount>;
  @useResult
  $Res call({String name, int count});
}

/// @nodoc
class _$RecruiterResponseCountCopyWithImpl<$Res,
        $Val extends RecruiterResponseCount>
    implements $RecruiterResponseCountCopyWith<$Res> {
  _$RecruiterResponseCountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecruiterResponseCountImplCopyWith<$Res>
    implements $RecruiterResponseCountCopyWith<$Res> {
  factory _$$RecruiterResponseCountImplCopyWith(
          _$RecruiterResponseCountImpl value,
          $Res Function(_$RecruiterResponseCountImpl) then) =
      __$$RecruiterResponseCountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int count});
}

/// @nodoc
class __$$RecruiterResponseCountImplCopyWithImpl<$Res>
    extends _$RecruiterResponseCountCopyWithImpl<$Res,
        _$RecruiterResponseCountImpl>
    implements _$$RecruiterResponseCountImplCopyWith<$Res> {
  __$$RecruiterResponseCountImplCopyWithImpl(
      _$RecruiterResponseCountImpl _value,
      $Res Function(_$RecruiterResponseCountImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? count = null,
  }) {
    return _then(_$RecruiterResponseCountImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecruiterResponseCountImpl implements _RecruiterResponseCount {
  const _$RecruiterResponseCountImpl({required this.name, required this.count});

  factory _$RecruiterResponseCountImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecruiterResponseCountImplFromJson(json);

  @override
  final String name;
  @override
  final int count;

  @override
  String toString() {
    return 'RecruiterResponseCount(name: $name, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecruiterResponseCountImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecruiterResponseCountImplCopyWith<_$RecruiterResponseCountImpl>
      get copyWith => __$$RecruiterResponseCountImplCopyWithImpl<
          _$RecruiterResponseCountImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecruiterResponseCountImplToJson(
      this,
    );
  }
}

abstract class _RecruiterResponseCount implements RecruiterResponseCount {
  const factory _RecruiterResponseCount(
      {required final String name,
      required final int count}) = _$RecruiterResponseCountImpl;

  factory _RecruiterResponseCount.fromJson(Map<String, dynamic> json) =
      _$RecruiterResponseCountImpl.fromJson;

  @override
  String get name;
  @override
  int get count;
  @override
  @JsonKey(ignore: true)
  _$$RecruiterResponseCountImplCopyWith<_$RecruiterResponseCountImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DateCount _$DateCountFromJson(Map<String, dynamic> json) {
  return _DateCount.fromJson(json);
}

/// @nodoc
mixin _$DateCount {
  String get date => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DateCountCopyWith<DateCount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DateCountCopyWith<$Res> {
  factory $DateCountCopyWith(DateCount value, $Res Function(DateCount) then) =
      _$DateCountCopyWithImpl<$Res, DateCount>;
  @useResult
  $Res call({String date, int count});
}

/// @nodoc
class _$DateCountCopyWithImpl<$Res, $Val extends DateCount>
    implements $DateCountCopyWith<$Res> {
  _$DateCountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DateCountImplCopyWith<$Res>
    implements $DateCountCopyWith<$Res> {
  factory _$$DateCountImplCopyWith(
          _$DateCountImpl value, $Res Function(_$DateCountImpl) then) =
      __$$DateCountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String date, int count});
}

/// @nodoc
class __$$DateCountImplCopyWithImpl<$Res>
    extends _$DateCountCopyWithImpl<$Res, _$DateCountImpl>
    implements _$$DateCountImplCopyWith<$Res> {
  __$$DateCountImplCopyWithImpl(
      _$DateCountImpl _value, $Res Function(_$DateCountImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? count = null,
  }) {
    return _then(_$DateCountImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DateCountImpl implements _DateCount {
  const _$DateCountImpl({required this.date, required this.count});

  factory _$DateCountImpl.fromJson(Map<String, dynamic> json) =>
      _$$DateCountImplFromJson(json);

  @override
  final String date;
  @override
  final int count;

  @override
  String toString() {
    return 'DateCount(date: $date, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DateCountImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, date, count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DateCountImplCopyWith<_$DateCountImpl> get copyWith =>
      __$$DateCountImplCopyWithImpl<_$DateCountImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DateCountImplToJson(
      this,
    );
  }
}

abstract class _DateCount implements DateCount {
  const factory _DateCount(
      {required final String date, required final int count}) = _$DateCountImpl;

  factory _DateCount.fromJson(Map<String, dynamic> json) =
      _$DateCountImpl.fromJson;

  @override
  String get date;
  @override
  int get count;
  @override
  @JsonKey(ignore: true)
  _$$DateCountImplCopyWith<_$DateCountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DashboardMetrics _$DashboardMetricsFromJson(Map<String, dynamic> json) {
  return _DashboardMetrics.fromJson(json);
}

/// @nodoc
mixin _$DashboardMetrics {
  int get totalOpportunities => throw _privateConstructorUsedError;
  int get activeRecruiters => throw _privateConstructorUsedError;
  int get interviewsCount => throw _privateConstructorUsedError;
  int get offersCount => throw _privateConstructorUsedError;
  double get responseRate => throw _privateConstructorUsedError;
  int get totalApplications => throw _privateConstructorUsedError;
  int get respondedApplications => throw _privateConstructorUsedError;
  List<WeekCount> get applicationsPerWeek => throw _privateConstructorUsedError;
  List<RecruiterResponseCount> get recruiterResponses =>
      throw _privateConstructorUsedError;
  List<DateCount> get interviewTrend => throw _privateConstructorUsedError;
  List<Recruiter> get followUpsDue => throw _privateConstructorUsedError;
  List<JobApplication> get latestActivity => throw _privateConstructorUsedError;
  List<JobApplication> get upcomingInterviews =>
      throw _privateConstructorUsedError;
  List<JobApplication> get allApplications =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DashboardMetricsCopyWith<DashboardMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardMetricsCopyWith<$Res> {
  factory $DashboardMetricsCopyWith(
          DashboardMetrics value, $Res Function(DashboardMetrics) then) =
      _$DashboardMetricsCopyWithImpl<$Res, DashboardMetrics>;
  @useResult
  $Res call(
      {int totalOpportunities,
      int activeRecruiters,
      int interviewsCount,
      int offersCount,
      double responseRate,
      int totalApplications,
      int respondedApplications,
      List<WeekCount> applicationsPerWeek,
      List<RecruiterResponseCount> recruiterResponses,
      List<DateCount> interviewTrend,
      List<Recruiter> followUpsDue,
      List<JobApplication> latestActivity,
      List<JobApplication> upcomingInterviews,
      List<JobApplication> allApplications});
}

/// @nodoc
class _$DashboardMetricsCopyWithImpl<$Res, $Val extends DashboardMetrics>
    implements $DashboardMetricsCopyWith<$Res> {
  _$DashboardMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalOpportunities = null,
    Object? activeRecruiters = null,
    Object? interviewsCount = null,
    Object? offersCount = null,
    Object? responseRate = null,
    Object? totalApplications = null,
    Object? respondedApplications = null,
    Object? applicationsPerWeek = null,
    Object? recruiterResponses = null,
    Object? interviewTrend = null,
    Object? followUpsDue = null,
    Object? latestActivity = null,
    Object? upcomingInterviews = null,
    Object? allApplications = null,
  }) {
    return _then(_value.copyWith(
      totalOpportunities: null == totalOpportunities
          ? _value.totalOpportunities
          : totalOpportunities // ignore: cast_nullable_to_non_nullable
              as int,
      activeRecruiters: null == activeRecruiters
          ? _value.activeRecruiters
          : activeRecruiters // ignore: cast_nullable_to_non_nullable
              as int,
      interviewsCount: null == interviewsCount
          ? _value.interviewsCount
          : interviewsCount // ignore: cast_nullable_to_non_nullable
              as int,
      offersCount: null == offersCount
          ? _value.offersCount
          : offersCount // ignore: cast_nullable_to_non_nullable
              as int,
      responseRate: null == responseRate
          ? _value.responseRate
          : responseRate // ignore: cast_nullable_to_non_nullable
              as double,
      totalApplications: null == totalApplications
          ? _value.totalApplications
          : totalApplications // ignore: cast_nullable_to_non_nullable
              as int,
      respondedApplications: null == respondedApplications
          ? _value.respondedApplications
          : respondedApplications // ignore: cast_nullable_to_non_nullable
              as int,
      applicationsPerWeek: null == applicationsPerWeek
          ? _value.applicationsPerWeek
          : applicationsPerWeek // ignore: cast_nullable_to_non_nullable
              as List<WeekCount>,
      recruiterResponses: null == recruiterResponses
          ? _value.recruiterResponses
          : recruiterResponses // ignore: cast_nullable_to_non_nullable
              as List<RecruiterResponseCount>,
      interviewTrend: null == interviewTrend
          ? _value.interviewTrend
          : interviewTrend // ignore: cast_nullable_to_non_nullable
              as List<DateCount>,
      followUpsDue: null == followUpsDue
          ? _value.followUpsDue
          : followUpsDue // ignore: cast_nullable_to_non_nullable
              as List<Recruiter>,
      latestActivity: null == latestActivity
          ? _value.latestActivity
          : latestActivity // ignore: cast_nullable_to_non_nullable
              as List<JobApplication>,
      upcomingInterviews: null == upcomingInterviews
          ? _value.upcomingInterviews
          : upcomingInterviews // ignore: cast_nullable_to_non_nullable
              as List<JobApplication>,
      allApplications: null == allApplications
          ? _value.allApplications
          : allApplications // ignore: cast_nullable_to_non_nullable
              as List<JobApplication>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardMetricsImplCopyWith<$Res>
    implements $DashboardMetricsCopyWith<$Res> {
  factory _$$DashboardMetricsImplCopyWith(_$DashboardMetricsImpl value,
          $Res Function(_$DashboardMetricsImpl) then) =
      __$$DashboardMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalOpportunities,
      int activeRecruiters,
      int interviewsCount,
      int offersCount,
      double responseRate,
      int totalApplications,
      int respondedApplications,
      List<WeekCount> applicationsPerWeek,
      List<RecruiterResponseCount> recruiterResponses,
      List<DateCount> interviewTrend,
      List<Recruiter> followUpsDue,
      List<JobApplication> latestActivity,
      List<JobApplication> upcomingInterviews,
      List<JobApplication> allApplications});
}

/// @nodoc
class __$$DashboardMetricsImplCopyWithImpl<$Res>
    extends _$DashboardMetricsCopyWithImpl<$Res, _$DashboardMetricsImpl>
    implements _$$DashboardMetricsImplCopyWith<$Res> {
  __$$DashboardMetricsImplCopyWithImpl(_$DashboardMetricsImpl _value,
      $Res Function(_$DashboardMetricsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalOpportunities = null,
    Object? activeRecruiters = null,
    Object? interviewsCount = null,
    Object? offersCount = null,
    Object? responseRate = null,
    Object? totalApplications = null,
    Object? respondedApplications = null,
    Object? applicationsPerWeek = null,
    Object? recruiterResponses = null,
    Object? interviewTrend = null,
    Object? followUpsDue = null,
    Object? latestActivity = null,
    Object? upcomingInterviews = null,
    Object? allApplications = null,
  }) {
    return _then(_$DashboardMetricsImpl(
      totalOpportunities: null == totalOpportunities
          ? _value.totalOpportunities
          : totalOpportunities // ignore: cast_nullable_to_non_nullable
              as int,
      activeRecruiters: null == activeRecruiters
          ? _value.activeRecruiters
          : activeRecruiters // ignore: cast_nullable_to_non_nullable
              as int,
      interviewsCount: null == interviewsCount
          ? _value.interviewsCount
          : interviewsCount // ignore: cast_nullable_to_non_nullable
              as int,
      offersCount: null == offersCount
          ? _value.offersCount
          : offersCount // ignore: cast_nullable_to_non_nullable
              as int,
      responseRate: null == responseRate
          ? _value.responseRate
          : responseRate // ignore: cast_nullable_to_non_nullable
              as double,
      totalApplications: null == totalApplications
          ? _value.totalApplications
          : totalApplications // ignore: cast_nullable_to_non_nullable
              as int,
      respondedApplications: null == respondedApplications
          ? _value.respondedApplications
          : respondedApplications // ignore: cast_nullable_to_non_nullable
              as int,
      applicationsPerWeek: null == applicationsPerWeek
          ? _value._applicationsPerWeek
          : applicationsPerWeek // ignore: cast_nullable_to_non_nullable
              as List<WeekCount>,
      recruiterResponses: null == recruiterResponses
          ? _value._recruiterResponses
          : recruiterResponses // ignore: cast_nullable_to_non_nullable
              as List<RecruiterResponseCount>,
      interviewTrend: null == interviewTrend
          ? _value._interviewTrend
          : interviewTrend // ignore: cast_nullable_to_non_nullable
              as List<DateCount>,
      followUpsDue: null == followUpsDue
          ? _value._followUpsDue
          : followUpsDue // ignore: cast_nullable_to_non_nullable
              as List<Recruiter>,
      latestActivity: null == latestActivity
          ? _value._latestActivity
          : latestActivity // ignore: cast_nullable_to_non_nullable
              as List<JobApplication>,
      upcomingInterviews: null == upcomingInterviews
          ? _value._upcomingInterviews
          : upcomingInterviews // ignore: cast_nullable_to_non_nullable
              as List<JobApplication>,
      allApplications: null == allApplications
          ? _value._allApplications
          : allApplications // ignore: cast_nullable_to_non_nullable
              as List<JobApplication>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardMetricsImpl implements _DashboardMetrics {
  const _$DashboardMetricsImpl(
      {required this.totalOpportunities,
      required this.activeRecruiters,
      required this.interviewsCount,
      required this.offersCount,
      required this.responseRate,
      required this.totalApplications,
      required this.respondedApplications,
      required final List<WeekCount> applicationsPerWeek,
      required final List<RecruiterResponseCount> recruiterResponses,
      required final List<DateCount> interviewTrend,
      required final List<Recruiter> followUpsDue,
      required final List<JobApplication> latestActivity,
      required final List<JobApplication> upcomingInterviews,
      required final List<JobApplication> allApplications})
      : _applicationsPerWeek = applicationsPerWeek,
        _recruiterResponses = recruiterResponses,
        _interviewTrend = interviewTrend,
        _followUpsDue = followUpsDue,
        _latestActivity = latestActivity,
        _upcomingInterviews = upcomingInterviews,
        _allApplications = allApplications;

  factory _$DashboardMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardMetricsImplFromJson(json);

  @override
  final int totalOpportunities;
  @override
  final int activeRecruiters;
  @override
  final int interviewsCount;
  @override
  final int offersCount;
  @override
  final double responseRate;
  @override
  final int totalApplications;
  @override
  final int respondedApplications;
  final List<WeekCount> _applicationsPerWeek;
  @override
  List<WeekCount> get applicationsPerWeek {
    if (_applicationsPerWeek is EqualUnmodifiableListView)
      return _applicationsPerWeek;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_applicationsPerWeek);
  }

  final List<RecruiterResponseCount> _recruiterResponses;
  @override
  List<RecruiterResponseCount> get recruiterResponses {
    if (_recruiterResponses is EqualUnmodifiableListView)
      return _recruiterResponses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recruiterResponses);
  }

  final List<DateCount> _interviewTrend;
  @override
  List<DateCount> get interviewTrend {
    if (_interviewTrend is EqualUnmodifiableListView) return _interviewTrend;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interviewTrend);
  }

  final List<Recruiter> _followUpsDue;
  @override
  List<Recruiter> get followUpsDue {
    if (_followUpsDue is EqualUnmodifiableListView) return _followUpsDue;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_followUpsDue);
  }

  final List<JobApplication> _latestActivity;
  @override
  List<JobApplication> get latestActivity {
    if (_latestActivity is EqualUnmodifiableListView) return _latestActivity;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_latestActivity);
  }

  final List<JobApplication> _upcomingInterviews;
  @override
  List<JobApplication> get upcomingInterviews {
    if (_upcomingInterviews is EqualUnmodifiableListView)
      return _upcomingInterviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_upcomingInterviews);
  }

  final List<JobApplication> _allApplications;
  @override
  List<JobApplication> get allApplications {
    if (_allApplications is EqualUnmodifiableListView) return _allApplications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allApplications);
  }

  @override
  String toString() {
    return 'DashboardMetrics(totalOpportunities: $totalOpportunities, activeRecruiters: $activeRecruiters, interviewsCount: $interviewsCount, offersCount: $offersCount, responseRate: $responseRate, totalApplications: $totalApplications, respondedApplications: $respondedApplications, applicationsPerWeek: $applicationsPerWeek, recruiterResponses: $recruiterResponses, interviewTrend: $interviewTrend, followUpsDue: $followUpsDue, latestActivity: $latestActivity, upcomingInterviews: $upcomingInterviews, allApplications: $allApplications)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardMetricsImpl &&
            (identical(other.totalOpportunities, totalOpportunities) ||
                other.totalOpportunities == totalOpportunities) &&
            (identical(other.activeRecruiters, activeRecruiters) ||
                other.activeRecruiters == activeRecruiters) &&
            (identical(other.interviewsCount, interviewsCount) ||
                other.interviewsCount == interviewsCount) &&
            (identical(other.offersCount, offersCount) ||
                other.offersCount == offersCount) &&
            (identical(other.responseRate, responseRate) ||
                other.responseRate == responseRate) &&
            (identical(other.totalApplications, totalApplications) ||
                other.totalApplications == totalApplications) &&
            (identical(other.respondedApplications, respondedApplications) ||
                other.respondedApplications == respondedApplications) &&
            const DeepCollectionEquality()
                .equals(other._applicationsPerWeek, _applicationsPerWeek) &&
            const DeepCollectionEquality()
                .equals(other._recruiterResponses, _recruiterResponses) &&
            const DeepCollectionEquality()
                .equals(other._interviewTrend, _interviewTrend) &&
            const DeepCollectionEquality()
                .equals(other._followUpsDue, _followUpsDue) &&
            const DeepCollectionEquality()
                .equals(other._latestActivity, _latestActivity) &&
            const DeepCollectionEquality()
                .equals(other._upcomingInterviews, _upcomingInterviews) &&
            const DeepCollectionEquality()
                .equals(other._allApplications, _allApplications));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalOpportunities,
      activeRecruiters,
      interviewsCount,
      offersCount,
      responseRate,
      totalApplications,
      respondedApplications,
      const DeepCollectionEquality().hash(_applicationsPerWeek),
      const DeepCollectionEquality().hash(_recruiterResponses),
      const DeepCollectionEquality().hash(_interviewTrend),
      const DeepCollectionEquality().hash(_followUpsDue),
      const DeepCollectionEquality().hash(_latestActivity),
      const DeepCollectionEquality().hash(_upcomingInterviews),
      const DeepCollectionEquality().hash(_allApplications));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardMetricsImplCopyWith<_$DashboardMetricsImpl> get copyWith =>
      __$$DashboardMetricsImplCopyWithImpl<_$DashboardMetricsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardMetricsImplToJson(
      this,
    );
  }
}

abstract class _DashboardMetrics implements DashboardMetrics {
  const factory _DashboardMetrics(
          {required final int totalOpportunities,
          required final int activeRecruiters,
          required final int interviewsCount,
          required final int offersCount,
          required final double responseRate,
          required final int totalApplications,
          required final int respondedApplications,
          required final List<WeekCount> applicationsPerWeek,
          required final List<RecruiterResponseCount> recruiterResponses,
          required final List<DateCount> interviewTrend,
          required final List<Recruiter> followUpsDue,
          required final List<JobApplication> latestActivity,
          required final List<JobApplication> upcomingInterviews,
          required final List<JobApplication> allApplications}) =
      _$DashboardMetricsImpl;

  factory _DashboardMetrics.fromJson(Map<String, dynamic> json) =
      _$DashboardMetricsImpl.fromJson;

  @override
  int get totalOpportunities;
  @override
  int get activeRecruiters;
  @override
  int get interviewsCount;
  @override
  int get offersCount;
  @override
  double get responseRate;
  @override
  int get totalApplications;
  @override
  int get respondedApplications;
  @override
  List<WeekCount> get applicationsPerWeek;
  @override
  List<RecruiterResponseCount> get recruiterResponses;
  @override
  List<DateCount> get interviewTrend;
  @override
  List<Recruiter> get followUpsDue;
  @override
  List<JobApplication> get latestActivity;
  @override
  List<JobApplication> get upcomingInterviews;
  @override
  List<JobApplication> get allApplications;
  @override
  @JsonKey(ignore: true)
  _$$DashboardMetricsImplCopyWith<_$DashboardMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
