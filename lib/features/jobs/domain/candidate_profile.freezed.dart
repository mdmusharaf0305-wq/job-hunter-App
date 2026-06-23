// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'candidate_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CandidateProfile _$CandidateProfileFromJson(Map<String, dynamic> json) {
  return _CandidateProfile.fromJson(json);
}

/// @nodoc
mixin _$CandidateProfile {
  double get experience =>
      throw _privateConstructorUsedError; // Target e.g. 4.4 YOE
  List<String> get preferredRoles => throw _privateConstructorUsedError;
  List<String> get preferredLocations => throw _privateConstructorUsedError;
  List<String> get requiredSkills => throw _privateConstructorUsedError;
  String get salaryExpectations => throw _privateConstructorUsedError;
  String get remotePreference => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CandidateProfileCopyWith<CandidateProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CandidateProfileCopyWith<$Res> {
  factory $CandidateProfileCopyWith(
          CandidateProfile value, $Res Function(CandidateProfile) then) =
      _$CandidateProfileCopyWithImpl<$Res, CandidateProfile>;
  @useResult
  $Res call(
      {double experience,
      List<String> preferredRoles,
      List<String> preferredLocations,
      List<String> requiredSkills,
      String salaryExpectations,
      String remotePreference});
}

/// @nodoc
class _$CandidateProfileCopyWithImpl<$Res, $Val extends CandidateProfile>
    implements $CandidateProfileCopyWith<$Res> {
  _$CandidateProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? experience = null,
    Object? preferredRoles = null,
    Object? preferredLocations = null,
    Object? requiredSkills = null,
    Object? salaryExpectations = null,
    Object? remotePreference = null,
  }) {
    return _then(_value.copyWith(
      experience: null == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as double,
      preferredRoles: null == preferredRoles
          ? _value.preferredRoles
          : preferredRoles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferredLocations: null == preferredLocations
          ? _value.preferredLocations
          : preferredLocations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      requiredSkills: null == requiredSkills
          ? _value.requiredSkills
          : requiredSkills // ignore: cast_nullable_to_non_nullable
              as List<String>,
      salaryExpectations: null == salaryExpectations
          ? _value.salaryExpectations
          : salaryExpectations // ignore: cast_nullable_to_non_nullable
              as String,
      remotePreference: null == remotePreference
          ? _value.remotePreference
          : remotePreference // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CandidateProfileImplCopyWith<$Res>
    implements $CandidateProfileCopyWith<$Res> {
  factory _$$CandidateProfileImplCopyWith(_$CandidateProfileImpl value,
          $Res Function(_$CandidateProfileImpl) then) =
      __$$CandidateProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double experience,
      List<String> preferredRoles,
      List<String> preferredLocations,
      List<String> requiredSkills,
      String salaryExpectations,
      String remotePreference});
}

/// @nodoc
class __$$CandidateProfileImplCopyWithImpl<$Res>
    extends _$CandidateProfileCopyWithImpl<$Res, _$CandidateProfileImpl>
    implements _$$CandidateProfileImplCopyWith<$Res> {
  __$$CandidateProfileImplCopyWithImpl(_$CandidateProfileImpl _value,
      $Res Function(_$CandidateProfileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? experience = null,
    Object? preferredRoles = null,
    Object? preferredLocations = null,
    Object? requiredSkills = null,
    Object? salaryExpectations = null,
    Object? remotePreference = null,
  }) {
    return _then(_$CandidateProfileImpl(
      experience: null == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as double,
      preferredRoles: null == preferredRoles
          ? _value._preferredRoles
          : preferredRoles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      preferredLocations: null == preferredLocations
          ? _value._preferredLocations
          : preferredLocations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      requiredSkills: null == requiredSkills
          ? _value._requiredSkills
          : requiredSkills // ignore: cast_nullable_to_non_nullable
              as List<String>,
      salaryExpectations: null == salaryExpectations
          ? _value.salaryExpectations
          : salaryExpectations // ignore: cast_nullable_to_non_nullable
              as String,
      remotePreference: null == remotePreference
          ? _value.remotePreference
          : remotePreference // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CandidateProfileImpl implements _CandidateProfile {
  const _$CandidateProfileImpl(
      {required this.experience,
      required final List<String> preferredRoles,
      required final List<String> preferredLocations,
      required final List<String> requiredSkills,
      required this.salaryExpectations,
      required this.remotePreference})
      : _preferredRoles = preferredRoles,
        _preferredLocations = preferredLocations,
        _requiredSkills = requiredSkills;

  factory _$CandidateProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$CandidateProfileImplFromJson(json);

  @override
  final double experience;
// Target e.g. 4.4 YOE
  final List<String> _preferredRoles;
// Target e.g. 4.4 YOE
  @override
  List<String> get preferredRoles {
    if (_preferredRoles is EqualUnmodifiableListView) return _preferredRoles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preferredRoles);
  }

  final List<String> _preferredLocations;
  @override
  List<String> get preferredLocations {
    if (_preferredLocations is EqualUnmodifiableListView)
      return _preferredLocations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preferredLocations);
  }

  final List<String> _requiredSkills;
  @override
  List<String> get requiredSkills {
    if (_requiredSkills is EqualUnmodifiableListView) return _requiredSkills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requiredSkills);
  }

  @override
  final String salaryExpectations;
  @override
  final String remotePreference;

  @override
  String toString() {
    return 'CandidateProfile(experience: $experience, preferredRoles: $preferredRoles, preferredLocations: $preferredLocations, requiredSkills: $requiredSkills, salaryExpectations: $salaryExpectations, remotePreference: $remotePreference)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CandidateProfileImpl &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            const DeepCollectionEquality()
                .equals(other._preferredRoles, _preferredRoles) &&
            const DeepCollectionEquality()
                .equals(other._preferredLocations, _preferredLocations) &&
            const DeepCollectionEquality()
                .equals(other._requiredSkills, _requiredSkills) &&
            (identical(other.salaryExpectations, salaryExpectations) ||
                other.salaryExpectations == salaryExpectations) &&
            (identical(other.remotePreference, remotePreference) ||
                other.remotePreference == remotePreference));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      experience,
      const DeepCollectionEquality().hash(_preferredRoles),
      const DeepCollectionEquality().hash(_preferredLocations),
      const DeepCollectionEquality().hash(_requiredSkills),
      salaryExpectations,
      remotePreference);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CandidateProfileImplCopyWith<_$CandidateProfileImpl> get copyWith =>
      __$$CandidateProfileImplCopyWithImpl<_$CandidateProfileImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CandidateProfileImplToJson(
      this,
    );
  }
}

abstract class _CandidateProfile implements CandidateProfile {
  const factory _CandidateProfile(
      {required final double experience,
      required final List<String> preferredRoles,
      required final List<String> preferredLocations,
      required final List<String> requiredSkills,
      required final String salaryExpectations,
      required final String remotePreference}) = _$CandidateProfileImpl;

  factory _CandidateProfile.fromJson(Map<String, dynamic> json) =
      _$CandidateProfileImpl.fromJson;

  @override
  double get experience;
  @override // Target e.g. 4.4 YOE
  List<String> get preferredRoles;
  @override
  List<String> get preferredLocations;
  @override
  List<String> get requiredSkills;
  @override
  String get salaryExpectations;
  @override
  String get remotePreference;
  @override
  @JsonKey(ignore: true)
  _$$CandidateProfileImplCopyWith<_$CandidateProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
