// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'watchlist_company.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ScoreBreakdown _$ScoreBreakdownFromJson(Map<String, dynamic> json) {
  return _ScoreBreakdown.fromJson(json);
}

/// @nodoc
mixin _$ScoreBreakdown {
  int get skillAlignment => throw _privateConstructorUsedError;
  int get hiringFrequency => throw _privateConstructorUsedError;
  int get salaryPotential => throw _privateConstructorUsedError;
  int get engineeringCulture => throw _privateConstructorUsedError;
  int get remoteFlexibility => throw _privateConstructorUsedError;
  int get growthPotential => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScoreBreakdownCopyWith<ScoreBreakdown> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScoreBreakdownCopyWith<$Res> {
  factory $ScoreBreakdownCopyWith(
          ScoreBreakdown value, $Res Function(ScoreBreakdown) then) =
      _$ScoreBreakdownCopyWithImpl<$Res, ScoreBreakdown>;
  @useResult
  $Res call(
      {int skillAlignment,
      int hiringFrequency,
      int salaryPotential,
      int engineeringCulture,
      int remoteFlexibility,
      int growthPotential});
}

/// @nodoc
class _$ScoreBreakdownCopyWithImpl<$Res, $Val extends ScoreBreakdown>
    implements $ScoreBreakdownCopyWith<$Res> {
  _$ScoreBreakdownCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skillAlignment = null,
    Object? hiringFrequency = null,
    Object? salaryPotential = null,
    Object? engineeringCulture = null,
    Object? remoteFlexibility = null,
    Object? growthPotential = null,
  }) {
    return _then(_value.copyWith(
      skillAlignment: null == skillAlignment
          ? _value.skillAlignment
          : skillAlignment // ignore: cast_nullable_to_non_nullable
              as int,
      hiringFrequency: null == hiringFrequency
          ? _value.hiringFrequency
          : hiringFrequency // ignore: cast_nullable_to_non_nullable
              as int,
      salaryPotential: null == salaryPotential
          ? _value.salaryPotential
          : salaryPotential // ignore: cast_nullable_to_non_nullable
              as int,
      engineeringCulture: null == engineeringCulture
          ? _value.engineeringCulture
          : engineeringCulture // ignore: cast_nullable_to_non_nullable
              as int,
      remoteFlexibility: null == remoteFlexibility
          ? _value.remoteFlexibility
          : remoteFlexibility // ignore: cast_nullable_to_non_nullable
              as int,
      growthPotential: null == growthPotential
          ? _value.growthPotential
          : growthPotential // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScoreBreakdownImplCopyWith<$Res>
    implements $ScoreBreakdownCopyWith<$Res> {
  factory _$$ScoreBreakdownImplCopyWith(_$ScoreBreakdownImpl value,
          $Res Function(_$ScoreBreakdownImpl) then) =
      __$$ScoreBreakdownImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int skillAlignment,
      int hiringFrequency,
      int salaryPotential,
      int engineeringCulture,
      int remoteFlexibility,
      int growthPotential});
}

/// @nodoc
class __$$ScoreBreakdownImplCopyWithImpl<$Res>
    extends _$ScoreBreakdownCopyWithImpl<$Res, _$ScoreBreakdownImpl>
    implements _$$ScoreBreakdownImplCopyWith<$Res> {
  __$$ScoreBreakdownImplCopyWithImpl(
      _$ScoreBreakdownImpl _value, $Res Function(_$ScoreBreakdownImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? skillAlignment = null,
    Object? hiringFrequency = null,
    Object? salaryPotential = null,
    Object? engineeringCulture = null,
    Object? remoteFlexibility = null,
    Object? growthPotential = null,
  }) {
    return _then(_$ScoreBreakdownImpl(
      skillAlignment: null == skillAlignment
          ? _value.skillAlignment
          : skillAlignment // ignore: cast_nullable_to_non_nullable
              as int,
      hiringFrequency: null == hiringFrequency
          ? _value.hiringFrequency
          : hiringFrequency // ignore: cast_nullable_to_non_nullable
              as int,
      salaryPotential: null == salaryPotential
          ? _value.salaryPotential
          : salaryPotential // ignore: cast_nullable_to_non_nullable
              as int,
      engineeringCulture: null == engineeringCulture
          ? _value.engineeringCulture
          : engineeringCulture // ignore: cast_nullable_to_non_nullable
              as int,
      remoteFlexibility: null == remoteFlexibility
          ? _value.remoteFlexibility
          : remoteFlexibility // ignore: cast_nullable_to_non_nullable
              as int,
      growthPotential: null == growthPotential
          ? _value.growthPotential
          : growthPotential // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScoreBreakdownImpl implements _ScoreBreakdown {
  const _$ScoreBreakdownImpl(
      {required this.skillAlignment,
      required this.hiringFrequency,
      required this.salaryPotential,
      required this.engineeringCulture,
      required this.remoteFlexibility,
      required this.growthPotential});

  factory _$ScoreBreakdownImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScoreBreakdownImplFromJson(json);

  @override
  final int skillAlignment;
  @override
  final int hiringFrequency;
  @override
  final int salaryPotential;
  @override
  final int engineeringCulture;
  @override
  final int remoteFlexibility;
  @override
  final int growthPotential;

  @override
  String toString() {
    return 'ScoreBreakdown(skillAlignment: $skillAlignment, hiringFrequency: $hiringFrequency, salaryPotential: $salaryPotential, engineeringCulture: $engineeringCulture, remoteFlexibility: $remoteFlexibility, growthPotential: $growthPotential)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScoreBreakdownImpl &&
            (identical(other.skillAlignment, skillAlignment) ||
                other.skillAlignment == skillAlignment) &&
            (identical(other.hiringFrequency, hiringFrequency) ||
                other.hiringFrequency == hiringFrequency) &&
            (identical(other.salaryPotential, salaryPotential) ||
                other.salaryPotential == salaryPotential) &&
            (identical(other.engineeringCulture, engineeringCulture) ||
                other.engineeringCulture == engineeringCulture) &&
            (identical(other.remoteFlexibility, remoteFlexibility) ||
                other.remoteFlexibility == remoteFlexibility) &&
            (identical(other.growthPotential, growthPotential) ||
                other.growthPotential == growthPotential));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, skillAlignment, hiringFrequency,
      salaryPotential, engineeringCulture, remoteFlexibility, growthPotential);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScoreBreakdownImplCopyWith<_$ScoreBreakdownImpl> get copyWith =>
      __$$ScoreBreakdownImplCopyWithImpl<_$ScoreBreakdownImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScoreBreakdownImplToJson(
      this,
    );
  }
}

abstract class _ScoreBreakdown implements ScoreBreakdown {
  const factory _ScoreBreakdown(
      {required final int skillAlignment,
      required final int hiringFrequency,
      required final int salaryPotential,
      required final int engineeringCulture,
      required final int remoteFlexibility,
      required final int growthPotential}) = _$ScoreBreakdownImpl;

  factory _ScoreBreakdown.fromJson(Map<String, dynamic> json) =
      _$ScoreBreakdownImpl.fromJson;

  @override
  int get skillAlignment;
  @override
  int get hiringFrequency;
  @override
  int get salaryPotential;
  @override
  int get engineeringCulture;
  @override
  int get remoteFlexibility;
  @override
  int get growthPotential;
  @override
  @JsonKey(ignore: true)
  _$$ScoreBreakdownImplCopyWith<_$ScoreBreakdownImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WatchlistCompany _$WatchlistCompanyFromJson(Map<String, dynamic> json) {
  return _WatchlistCompany.fromJson(json);
}

/// @nodoc
mixin _$WatchlistCompany {
  String get name => throw _privateConstructorUsedError;
  int get tier => throw _privateConstructorUsedError;
  List<String> get techStack => throw _privateConstructorUsedError;
  double get hiringFrequency => throw _privateConstructorUsedError;
  double get salaryPotential => throw _privateConstructorUsedError;
  double get engineeringCulture => throw _privateConstructorUsedError;
  List<String> get remoteFlexibility => throw _privateConstructorUsedError;
  double get growthPotential => throw _privateConstructorUsedError;
  String get website => throw _privateConstructorUsedError;
  String get headquarters => throw _privateConstructorUsedError;
  String? get ats => throw _privateConstructorUsedError;
  int? get relevanceScore => throw _privateConstructorUsedError;
  int? get authenticityScore => throw _privateConstructorUsedError;
  String? get authenticityBadge =>
      throw _privateConstructorUsedError; // '✓ Direct Employer' | 'Product Company' etc
  ScoreBreakdown? get scoreBreakdown => throw _privateConstructorUsedError;
  double get overallRating => throw _privateConstructorUsedError;
  double get workLifeBalance => throw _privateConstructorUsedError;
  String get attritionRate => throw _privateConstructorUsedError;
  String get employeeCount => throw _privateConstructorUsedError;
  List<String> get locations => throw _privateConstructorUsedError;
  String? get applicationId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WatchlistCompanyCopyWith<WatchlistCompany> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WatchlistCompanyCopyWith<$Res> {
  factory $WatchlistCompanyCopyWith(
          WatchlistCompany value, $Res Function(WatchlistCompany) then) =
      _$WatchlistCompanyCopyWithImpl<$Res, WatchlistCompany>;
  @useResult
  $Res call(
      {String name,
      int tier,
      List<String> techStack,
      double hiringFrequency,
      double salaryPotential,
      double engineeringCulture,
      List<String> remoteFlexibility,
      double growthPotential,
      String website,
      String headquarters,
      String? ats,
      int? relevanceScore,
      int? authenticityScore,
      String? authenticityBadge,
      ScoreBreakdown? scoreBreakdown,
      double overallRating,
      double workLifeBalance,
      String attritionRate,
      String employeeCount,
      List<String> locations,
      String? applicationId});

  $ScoreBreakdownCopyWith<$Res>? get scoreBreakdown;
}

/// @nodoc
class _$WatchlistCompanyCopyWithImpl<$Res, $Val extends WatchlistCompany>
    implements $WatchlistCompanyCopyWith<$Res> {
  _$WatchlistCompanyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? tier = null,
    Object? techStack = null,
    Object? hiringFrequency = null,
    Object? salaryPotential = null,
    Object? engineeringCulture = null,
    Object? remoteFlexibility = null,
    Object? growthPotential = null,
    Object? website = null,
    Object? headquarters = null,
    Object? ats = freezed,
    Object? relevanceScore = freezed,
    Object? authenticityScore = freezed,
    Object? authenticityBadge = freezed,
    Object? scoreBreakdown = freezed,
    Object? overallRating = null,
    Object? workLifeBalance = null,
    Object? attritionRate = null,
    Object? employeeCount = null,
    Object? locations = null,
    Object? applicationId = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      tier: null == tier
          ? _value.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as int,
      techStack: null == techStack
          ? _value.techStack
          : techStack // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hiringFrequency: null == hiringFrequency
          ? _value.hiringFrequency
          : hiringFrequency // ignore: cast_nullable_to_non_nullable
              as double,
      salaryPotential: null == salaryPotential
          ? _value.salaryPotential
          : salaryPotential // ignore: cast_nullable_to_non_nullable
              as double,
      engineeringCulture: null == engineeringCulture
          ? _value.engineeringCulture
          : engineeringCulture // ignore: cast_nullable_to_non_nullable
              as double,
      remoteFlexibility: null == remoteFlexibility
          ? _value.remoteFlexibility
          : remoteFlexibility // ignore: cast_nullable_to_non_nullable
              as List<String>,
      growthPotential: null == growthPotential
          ? _value.growthPotential
          : growthPotential // ignore: cast_nullable_to_non_nullable
              as double,
      website: null == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String,
      headquarters: null == headquarters
          ? _value.headquarters
          : headquarters // ignore: cast_nullable_to_non_nullable
              as String,
      ats: freezed == ats
          ? _value.ats
          : ats // ignore: cast_nullable_to_non_nullable
              as String?,
      relevanceScore: freezed == relevanceScore
          ? _value.relevanceScore
          : relevanceScore // ignore: cast_nullable_to_non_nullable
              as int?,
      authenticityScore: freezed == authenticityScore
          ? _value.authenticityScore
          : authenticityScore // ignore: cast_nullable_to_non_nullable
              as int?,
      authenticityBadge: freezed == authenticityBadge
          ? _value.authenticityBadge
          : authenticityBadge // ignore: cast_nullable_to_non_nullable
              as String?,
      scoreBreakdown: freezed == scoreBreakdown
          ? _value.scoreBreakdown
          : scoreBreakdown // ignore: cast_nullable_to_non_nullable
              as ScoreBreakdown?,
      overallRating: null == overallRating
          ? _value.overallRating
          : overallRating // ignore: cast_nullable_to_non_nullable
              as double,
      workLifeBalance: null == workLifeBalance
          ? _value.workLifeBalance
          : workLifeBalance // ignore: cast_nullable_to_non_nullable
              as double,
      attritionRate: null == attritionRate
          ? _value.attritionRate
          : attritionRate // ignore: cast_nullable_to_non_nullable
              as String,
      employeeCount: null == employeeCount
          ? _value.employeeCount
          : employeeCount // ignore: cast_nullable_to_non_nullable
              as String,
      locations: null == locations
          ? _value.locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      applicationId: freezed == applicationId
          ? _value.applicationId
          : applicationId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ScoreBreakdownCopyWith<$Res>? get scoreBreakdown {
    if (_value.scoreBreakdown == null) {
      return null;
    }

    return $ScoreBreakdownCopyWith<$Res>(_value.scoreBreakdown!, (value) {
      return _then(_value.copyWith(scoreBreakdown: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WatchlistCompanyImplCopyWith<$Res>
    implements $WatchlistCompanyCopyWith<$Res> {
  factory _$$WatchlistCompanyImplCopyWith(_$WatchlistCompanyImpl value,
          $Res Function(_$WatchlistCompanyImpl) then) =
      __$$WatchlistCompanyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      int tier,
      List<String> techStack,
      double hiringFrequency,
      double salaryPotential,
      double engineeringCulture,
      List<String> remoteFlexibility,
      double growthPotential,
      String website,
      String headquarters,
      String? ats,
      int? relevanceScore,
      int? authenticityScore,
      String? authenticityBadge,
      ScoreBreakdown? scoreBreakdown,
      double overallRating,
      double workLifeBalance,
      String attritionRate,
      String employeeCount,
      List<String> locations,
      String? applicationId});

  @override
  $ScoreBreakdownCopyWith<$Res>? get scoreBreakdown;
}

/// @nodoc
class __$$WatchlistCompanyImplCopyWithImpl<$Res>
    extends _$WatchlistCompanyCopyWithImpl<$Res, _$WatchlistCompanyImpl>
    implements _$$WatchlistCompanyImplCopyWith<$Res> {
  __$$WatchlistCompanyImplCopyWithImpl(_$WatchlistCompanyImpl _value,
      $Res Function(_$WatchlistCompanyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? tier = null,
    Object? techStack = null,
    Object? hiringFrequency = null,
    Object? salaryPotential = null,
    Object? engineeringCulture = null,
    Object? remoteFlexibility = null,
    Object? growthPotential = null,
    Object? website = null,
    Object? headquarters = null,
    Object? ats = freezed,
    Object? relevanceScore = freezed,
    Object? authenticityScore = freezed,
    Object? authenticityBadge = freezed,
    Object? scoreBreakdown = freezed,
    Object? overallRating = null,
    Object? workLifeBalance = null,
    Object? attritionRate = null,
    Object? employeeCount = null,
    Object? locations = null,
    Object? applicationId = freezed,
  }) {
    return _then(_$WatchlistCompanyImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      tier: null == tier
          ? _value.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as int,
      techStack: null == techStack
          ? _value._techStack
          : techStack // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hiringFrequency: null == hiringFrequency
          ? _value.hiringFrequency
          : hiringFrequency // ignore: cast_nullable_to_non_nullable
              as double,
      salaryPotential: null == salaryPotential
          ? _value.salaryPotential
          : salaryPotential // ignore: cast_nullable_to_non_nullable
              as double,
      engineeringCulture: null == engineeringCulture
          ? _value.engineeringCulture
          : engineeringCulture // ignore: cast_nullable_to_non_nullable
              as double,
      remoteFlexibility: null == remoteFlexibility
          ? _value._remoteFlexibility
          : remoteFlexibility // ignore: cast_nullable_to_non_nullable
              as List<String>,
      growthPotential: null == growthPotential
          ? _value.growthPotential
          : growthPotential // ignore: cast_nullable_to_non_nullable
              as double,
      website: null == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String,
      headquarters: null == headquarters
          ? _value.headquarters
          : headquarters // ignore: cast_nullable_to_non_nullable
              as String,
      ats: freezed == ats
          ? _value.ats
          : ats // ignore: cast_nullable_to_non_nullable
              as String?,
      relevanceScore: freezed == relevanceScore
          ? _value.relevanceScore
          : relevanceScore // ignore: cast_nullable_to_non_nullable
              as int?,
      authenticityScore: freezed == authenticityScore
          ? _value.authenticityScore
          : authenticityScore // ignore: cast_nullable_to_non_nullable
              as int?,
      authenticityBadge: freezed == authenticityBadge
          ? _value.authenticityBadge
          : authenticityBadge // ignore: cast_nullable_to_non_nullable
              as String?,
      scoreBreakdown: freezed == scoreBreakdown
          ? _value.scoreBreakdown
          : scoreBreakdown // ignore: cast_nullable_to_non_nullable
              as ScoreBreakdown?,
      overallRating: null == overallRating
          ? _value.overallRating
          : overallRating // ignore: cast_nullable_to_non_nullable
              as double,
      workLifeBalance: null == workLifeBalance
          ? _value.workLifeBalance
          : workLifeBalance // ignore: cast_nullable_to_non_nullable
              as double,
      attritionRate: null == attritionRate
          ? _value.attritionRate
          : attritionRate // ignore: cast_nullable_to_non_nullable
              as String,
      employeeCount: null == employeeCount
          ? _value.employeeCount
          : employeeCount // ignore: cast_nullable_to_non_nullable
              as String,
      locations: null == locations
          ? _value._locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      applicationId: freezed == applicationId
          ? _value.applicationId
          : applicationId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WatchlistCompanyImpl implements _WatchlistCompany {
  const _$WatchlistCompanyImpl(
      {required this.name,
      required this.tier,
      required final List<String> techStack,
      required this.hiringFrequency,
      required this.salaryPotential,
      required this.engineeringCulture,
      required final List<String> remoteFlexibility,
      required this.growthPotential,
      required this.website,
      required this.headquarters,
      this.ats,
      this.relevanceScore,
      this.authenticityScore,
      this.authenticityBadge,
      this.scoreBreakdown,
      this.overallRating = 7.5,
      this.workLifeBalance = 7.5,
      this.attritionRate = '14%',
      this.employeeCount = '101-500',
      final List<String> locations = const [],
      this.applicationId})
      : _techStack = techStack,
        _remoteFlexibility = remoteFlexibility,
        _locations = locations;

  factory _$WatchlistCompanyImpl.fromJson(Map<String, dynamic> json) =>
      _$$WatchlistCompanyImplFromJson(json);

  @override
  final String name;
  @override
  final int tier;
  final List<String> _techStack;
  @override
  List<String> get techStack {
    if (_techStack is EqualUnmodifiableListView) return _techStack;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_techStack);
  }

  @override
  final double hiringFrequency;
  @override
  final double salaryPotential;
  @override
  final double engineeringCulture;
  final List<String> _remoteFlexibility;
  @override
  List<String> get remoteFlexibility {
    if (_remoteFlexibility is EqualUnmodifiableListView)
      return _remoteFlexibility;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_remoteFlexibility);
  }

  @override
  final double growthPotential;
  @override
  final String website;
  @override
  final String headquarters;
  @override
  final String? ats;
  @override
  final int? relevanceScore;
  @override
  final int? authenticityScore;
  @override
  final String? authenticityBadge;
// '✓ Direct Employer' | 'Product Company' etc
  @override
  final ScoreBreakdown? scoreBreakdown;
  @override
  @JsonKey()
  final double overallRating;
  @override
  @JsonKey()
  final double workLifeBalance;
  @override
  @JsonKey()
  final String attritionRate;
  @override
  @JsonKey()
  final String employeeCount;
  final List<String> _locations;
  @override
  @JsonKey()
  List<String> get locations {
    if (_locations is EqualUnmodifiableListView) return _locations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locations);
  }

  @override
  final String? applicationId;

  @override
  String toString() {
    return 'WatchlistCompany(name: $name, tier: $tier, techStack: $techStack, hiringFrequency: $hiringFrequency, salaryPotential: $salaryPotential, engineeringCulture: $engineeringCulture, remoteFlexibility: $remoteFlexibility, growthPotential: $growthPotential, website: $website, headquarters: $headquarters, ats: $ats, relevanceScore: $relevanceScore, authenticityScore: $authenticityScore, authenticityBadge: $authenticityBadge, scoreBreakdown: $scoreBreakdown, overallRating: $overallRating, workLifeBalance: $workLifeBalance, attritionRate: $attritionRate, employeeCount: $employeeCount, locations: $locations, applicationId: $applicationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchlistCompanyImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            const DeepCollectionEquality()
                .equals(other._techStack, _techStack) &&
            (identical(other.hiringFrequency, hiringFrequency) ||
                other.hiringFrequency == hiringFrequency) &&
            (identical(other.salaryPotential, salaryPotential) ||
                other.salaryPotential == salaryPotential) &&
            (identical(other.engineeringCulture, engineeringCulture) ||
                other.engineeringCulture == engineeringCulture) &&
            const DeepCollectionEquality()
                .equals(other._remoteFlexibility, _remoteFlexibility) &&
            (identical(other.growthPotential, growthPotential) ||
                other.growthPotential == growthPotential) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.headquarters, headquarters) ||
                other.headquarters == headquarters) &&
            (identical(other.ats, ats) || other.ats == ats) &&
            (identical(other.relevanceScore, relevanceScore) ||
                other.relevanceScore == relevanceScore) &&
            (identical(other.authenticityScore, authenticityScore) ||
                other.authenticityScore == authenticityScore) &&
            (identical(other.authenticityBadge, authenticityBadge) ||
                other.authenticityBadge == authenticityBadge) &&
            (identical(other.scoreBreakdown, scoreBreakdown) ||
                other.scoreBreakdown == scoreBreakdown) &&
            (identical(other.overallRating, overallRating) ||
                other.overallRating == overallRating) &&
            (identical(other.workLifeBalance, workLifeBalance) ||
                other.workLifeBalance == workLifeBalance) &&
            (identical(other.attritionRate, attritionRate) ||
                other.attritionRate == attritionRate) &&
            (identical(other.employeeCount, employeeCount) ||
                other.employeeCount == employeeCount) &&
            const DeepCollectionEquality()
                .equals(other._locations, _locations) &&
            (identical(other.applicationId, applicationId) ||
                other.applicationId == applicationId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        name,
        tier,
        const DeepCollectionEquality().hash(_techStack),
        hiringFrequency,
        salaryPotential,
        engineeringCulture,
        const DeepCollectionEquality().hash(_remoteFlexibility),
        growthPotential,
        website,
        headquarters,
        ats,
        relevanceScore,
        authenticityScore,
        authenticityBadge,
        scoreBreakdown,
        overallRating,
        workLifeBalance,
        attritionRate,
        employeeCount,
        const DeepCollectionEquality().hash(_locations),
        applicationId
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchlistCompanyImplCopyWith<_$WatchlistCompanyImpl> get copyWith =>
      __$$WatchlistCompanyImplCopyWithImpl<_$WatchlistCompanyImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WatchlistCompanyImplToJson(
      this,
    );
  }
}

abstract class _WatchlistCompany implements WatchlistCompany {
  const factory _WatchlistCompany(
      {required final String name,
      required final int tier,
      required final List<String> techStack,
      required final double hiringFrequency,
      required final double salaryPotential,
      required final double engineeringCulture,
      required final List<String> remoteFlexibility,
      required final double growthPotential,
      required final String website,
      required final String headquarters,
      final String? ats,
      final int? relevanceScore,
      final int? authenticityScore,
      final String? authenticityBadge,
      final ScoreBreakdown? scoreBreakdown,
      final double overallRating,
      final double workLifeBalance,
      final String attritionRate,
      final String employeeCount,
      final List<String> locations,
      final String? applicationId}) = _$WatchlistCompanyImpl;

  factory _WatchlistCompany.fromJson(Map<String, dynamic> json) =
      _$WatchlistCompanyImpl.fromJson;

  @override
  String get name;
  @override
  int get tier;
  @override
  List<String> get techStack;
  @override
  double get hiringFrequency;
  @override
  double get salaryPotential;
  @override
  double get engineeringCulture;
  @override
  List<String> get remoteFlexibility;
  @override
  double get growthPotential;
  @override
  String get website;
  @override
  String get headquarters;
  @override
  String? get ats;
  @override
  int? get relevanceScore;
  @override
  int? get authenticityScore;
  @override
  String? get authenticityBadge;
  @override // '✓ Direct Employer' | 'Product Company' etc
  ScoreBreakdown? get scoreBreakdown;
  @override
  double get overallRating;
  @override
  double get workLifeBalance;
  @override
  String get attritionRate;
  @override
  String get employeeCount;
  @override
  List<String> get locations;
  @override
  String? get applicationId;
  @override
  @JsonKey(ignore: true)
  _$$WatchlistCompanyImplCopyWith<_$WatchlistCompanyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
