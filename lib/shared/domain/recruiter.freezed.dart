// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recruiter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Recruiter _$RecruiterFromJson(Map<String, dynamic> json) {
  return _Recruiter.fromJson(json);
}

/// @nodoc
mixin _$Recruiter {
  String get id => throw _privateConstructorUsedError;
  String get company => throw _privateConstructorUsedError;
  String get client => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String get recruiterName => throw _privateConstructorUsedError;
  String? get recruiterPhone => throw _privateConstructorUsedError;
  String? get recruiterEmail => throw _privateConstructorUsedError;
  String? get recruiterLinkedin => throw _privateConstructorUsedError;
  String get contactStatus => throw _privateConstructorUsedError;
  String? get contactMethod => throw _privateConstructorUsedError;
  String? get lastContacted => throw _privateConstructorUsedError; // YYYY-MM-DD
  String? get nextFollowUp => throw _privateConstructorUsedError; // YYYY-MM-DD
  String? get priority =>
      throw _privateConstructorUsedError; // 'High' | 'Medium' | 'Low'
  String? get source => throw _privateConstructorUsedError;
  String? get applicationUrl => throw _privateConstructorUsedError;
  String get dbSource =>
      throw _privateConstructorUsedError; // 'inbound' | 'outbound'
  String? get relatedTimelineId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecruiterCopyWith<Recruiter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecruiterCopyWith<$Res> {
  factory $RecruiterCopyWith(Recruiter value, $Res Function(Recruiter) then) =
      _$RecruiterCopyWithImpl<$Res, Recruiter>;
  @useResult
  $Res call(
      {String id,
      String company,
      String client,
      String role,
      String recruiterName,
      String? recruiterPhone,
      String? recruiterEmail,
      String? recruiterLinkedin,
      String contactStatus,
      String? contactMethod,
      String? lastContacted,
      String? nextFollowUp,
      String? priority,
      String? source,
      String? applicationUrl,
      String dbSource,
      String? relatedTimelineId});
}

/// @nodoc
class _$RecruiterCopyWithImpl<$Res, $Val extends Recruiter>
    implements $RecruiterCopyWith<$Res> {
  _$RecruiterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? company = null,
    Object? client = null,
    Object? role = null,
    Object? recruiterName = null,
    Object? recruiterPhone = freezed,
    Object? recruiterEmail = freezed,
    Object? recruiterLinkedin = freezed,
    Object? contactStatus = null,
    Object? contactMethod = freezed,
    Object? lastContacted = freezed,
    Object? nextFollowUp = freezed,
    Object? priority = freezed,
    Object? source = freezed,
    Object? applicationUrl = freezed,
    Object? dbSource = null,
    Object? relatedTimelineId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String,
      client: null == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      recruiterName: null == recruiterName
          ? _value.recruiterName
          : recruiterName // ignore: cast_nullable_to_non_nullable
              as String,
      recruiterPhone: freezed == recruiterPhone
          ? _value.recruiterPhone
          : recruiterPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      recruiterEmail: freezed == recruiterEmail
          ? _value.recruiterEmail
          : recruiterEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      recruiterLinkedin: freezed == recruiterLinkedin
          ? _value.recruiterLinkedin
          : recruiterLinkedin // ignore: cast_nullable_to_non_nullable
              as String?,
      contactStatus: null == contactStatus
          ? _value.contactStatus
          : contactStatus // ignore: cast_nullable_to_non_nullable
              as String,
      contactMethod: freezed == contactMethod
          ? _value.contactMethod
          : contactMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      lastContacted: freezed == lastContacted
          ? _value.lastContacted
          : lastContacted // ignore: cast_nullable_to_non_nullable
              as String?,
      nextFollowUp: freezed == nextFollowUp
          ? _value.nextFollowUp
          : nextFollowUp // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      applicationUrl: freezed == applicationUrl
          ? _value.applicationUrl
          : applicationUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      dbSource: null == dbSource
          ? _value.dbSource
          : dbSource // ignore: cast_nullable_to_non_nullable
              as String,
      relatedTimelineId: freezed == relatedTimelineId
          ? _value.relatedTimelineId
          : relatedTimelineId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecruiterImplCopyWith<$Res>
    implements $RecruiterCopyWith<$Res> {
  factory _$$RecruiterImplCopyWith(
          _$RecruiterImpl value, $Res Function(_$RecruiterImpl) then) =
      __$$RecruiterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String company,
      String client,
      String role,
      String recruiterName,
      String? recruiterPhone,
      String? recruiterEmail,
      String? recruiterLinkedin,
      String contactStatus,
      String? contactMethod,
      String? lastContacted,
      String? nextFollowUp,
      String? priority,
      String? source,
      String? applicationUrl,
      String dbSource,
      String? relatedTimelineId});
}

/// @nodoc
class __$$RecruiterImplCopyWithImpl<$Res>
    extends _$RecruiterCopyWithImpl<$Res, _$RecruiterImpl>
    implements _$$RecruiterImplCopyWith<$Res> {
  __$$RecruiterImplCopyWithImpl(
      _$RecruiterImpl _value, $Res Function(_$RecruiterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? company = null,
    Object? client = null,
    Object? role = null,
    Object? recruiterName = null,
    Object? recruiterPhone = freezed,
    Object? recruiterEmail = freezed,
    Object? recruiterLinkedin = freezed,
    Object? contactStatus = null,
    Object? contactMethod = freezed,
    Object? lastContacted = freezed,
    Object? nextFollowUp = freezed,
    Object? priority = freezed,
    Object? source = freezed,
    Object? applicationUrl = freezed,
    Object? dbSource = null,
    Object? relatedTimelineId = freezed,
  }) {
    return _then(_$RecruiterImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      company: null == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String,
      client: null == client
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      recruiterName: null == recruiterName
          ? _value.recruiterName
          : recruiterName // ignore: cast_nullable_to_non_nullable
              as String,
      recruiterPhone: freezed == recruiterPhone
          ? _value.recruiterPhone
          : recruiterPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      recruiterEmail: freezed == recruiterEmail
          ? _value.recruiterEmail
          : recruiterEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      recruiterLinkedin: freezed == recruiterLinkedin
          ? _value.recruiterLinkedin
          : recruiterLinkedin // ignore: cast_nullable_to_non_nullable
              as String?,
      contactStatus: null == contactStatus
          ? _value.contactStatus
          : contactStatus // ignore: cast_nullable_to_non_nullable
              as String,
      contactMethod: freezed == contactMethod
          ? _value.contactMethod
          : contactMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      lastContacted: freezed == lastContacted
          ? _value.lastContacted
          : lastContacted // ignore: cast_nullable_to_non_nullable
              as String?,
      nextFollowUp: freezed == nextFollowUp
          ? _value.nextFollowUp
          : nextFollowUp // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      applicationUrl: freezed == applicationUrl
          ? _value.applicationUrl
          : applicationUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      dbSource: null == dbSource
          ? _value.dbSource
          : dbSource // ignore: cast_nullable_to_non_nullable
              as String,
      relatedTimelineId: freezed == relatedTimelineId
          ? _value.relatedTimelineId
          : relatedTimelineId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecruiterImpl implements _Recruiter {
  const _$RecruiterImpl(
      {required this.id,
      required this.company,
      required this.client,
      required this.role,
      required this.recruiterName,
      this.recruiterPhone,
      this.recruiterEmail,
      this.recruiterLinkedin,
      required this.contactStatus,
      this.contactMethod,
      this.lastContacted,
      this.nextFollowUp,
      this.priority,
      this.source,
      this.applicationUrl,
      required this.dbSource,
      this.relatedTimelineId});

  factory _$RecruiterImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecruiterImplFromJson(json);

  @override
  final String id;
  @override
  final String company;
  @override
  final String client;
  @override
  final String role;
  @override
  final String recruiterName;
  @override
  final String? recruiterPhone;
  @override
  final String? recruiterEmail;
  @override
  final String? recruiterLinkedin;
  @override
  final String contactStatus;
  @override
  final String? contactMethod;
  @override
  final String? lastContacted;
// YYYY-MM-DD
  @override
  final String? nextFollowUp;
// YYYY-MM-DD
  @override
  final String? priority;
// 'High' | 'Medium' | 'Low'
  @override
  final String? source;
  @override
  final String? applicationUrl;
  @override
  final String dbSource;
// 'inbound' | 'outbound'
  @override
  final String? relatedTimelineId;

  @override
  String toString() {
    return 'Recruiter(id: $id, company: $company, client: $client, role: $role, recruiterName: $recruiterName, recruiterPhone: $recruiterPhone, recruiterEmail: $recruiterEmail, recruiterLinkedin: $recruiterLinkedin, contactStatus: $contactStatus, contactMethod: $contactMethod, lastContacted: $lastContacted, nextFollowUp: $nextFollowUp, priority: $priority, source: $source, applicationUrl: $applicationUrl, dbSource: $dbSource, relatedTimelineId: $relatedTimelineId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecruiterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.recruiterName, recruiterName) ||
                other.recruiterName == recruiterName) &&
            (identical(other.recruiterPhone, recruiterPhone) ||
                other.recruiterPhone == recruiterPhone) &&
            (identical(other.recruiterEmail, recruiterEmail) ||
                other.recruiterEmail == recruiterEmail) &&
            (identical(other.recruiterLinkedin, recruiterLinkedin) ||
                other.recruiterLinkedin == recruiterLinkedin) &&
            (identical(other.contactStatus, contactStatus) ||
                other.contactStatus == contactStatus) &&
            (identical(other.contactMethod, contactMethod) ||
                other.contactMethod == contactMethod) &&
            (identical(other.lastContacted, lastContacted) ||
                other.lastContacted == lastContacted) &&
            (identical(other.nextFollowUp, nextFollowUp) ||
                other.nextFollowUp == nextFollowUp) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.applicationUrl, applicationUrl) ||
                other.applicationUrl == applicationUrl) &&
            (identical(other.dbSource, dbSource) ||
                other.dbSource == dbSource) &&
            (identical(other.relatedTimelineId, relatedTimelineId) ||
                other.relatedTimelineId == relatedTimelineId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      company,
      client,
      role,
      recruiterName,
      recruiterPhone,
      recruiterEmail,
      recruiterLinkedin,
      contactStatus,
      contactMethod,
      lastContacted,
      nextFollowUp,
      priority,
      source,
      applicationUrl,
      dbSource,
      relatedTimelineId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecruiterImplCopyWith<_$RecruiterImpl> get copyWith =>
      __$$RecruiterImplCopyWithImpl<_$RecruiterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecruiterImplToJson(
      this,
    );
  }
}

abstract class _Recruiter implements Recruiter {
  const factory _Recruiter(
      {required final String id,
      required final String company,
      required final String client,
      required final String role,
      required final String recruiterName,
      final String? recruiterPhone,
      final String? recruiterEmail,
      final String? recruiterLinkedin,
      required final String contactStatus,
      final String? contactMethod,
      final String? lastContacted,
      final String? nextFollowUp,
      final String? priority,
      final String? source,
      final String? applicationUrl,
      required final String dbSource,
      final String? relatedTimelineId}) = _$RecruiterImpl;

  factory _Recruiter.fromJson(Map<String, dynamic> json) =
      _$RecruiterImpl.fromJson;

  @override
  String get id;
  @override
  String get company;
  @override
  String get client;
  @override
  String get role;
  @override
  String get recruiterName;
  @override
  String? get recruiterPhone;
  @override
  String? get recruiterEmail;
  @override
  String? get recruiterLinkedin;
  @override
  String get contactStatus;
  @override
  String? get contactMethod;
  @override
  String? get lastContacted;
  @override // YYYY-MM-DD
  String? get nextFollowUp;
  @override // YYYY-MM-DD
  String? get priority;
  @override // 'High' | 'Medium' | 'Low'
  String? get source;
  @override
  String? get applicationUrl;
  @override
  String get dbSource;
  @override // 'inbound' | 'outbound'
  String? get relatedTimelineId;
  @override
  @JsonKey(ignore: true)
  _$$RecruiterImplCopyWith<_$RecruiterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
