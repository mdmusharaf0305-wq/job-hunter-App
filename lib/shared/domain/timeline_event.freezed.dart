// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timeline_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TimelineEvent _$TimelineEventFromJson(Map<String, dynamic> json) {
  return _TimelineEvent.fromJson(json);
}

/// @nodoc
mixin _$TimelineEvent {
  String get id => throw _privateConstructorUsedError;
  String get opportunity =>
      throw _privateConstructorUsedError; // ID of related Opportunity Page
  String get title => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError; // YYYY-MM-DD
  String get category =>
      throw _privateConstructorUsedError; // 'Interview' | 'Assignment' | 'Follow-up'
  String get virtualMode =>
      throw _privateConstructorUsedError; // 'Google Meet' | 'Zoom' | 'Teams' etc
  String get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimelineEventCopyWith<TimelineEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimelineEventCopyWith<$Res> {
  factory $TimelineEventCopyWith(
          TimelineEvent value, $Res Function(TimelineEvent) then) =
      _$TimelineEventCopyWithImpl<$Res, TimelineEvent>;
  @useResult
  $Res call(
      {String id,
      String opportunity,
      String title,
      String date,
      String category,
      String virtualMode,
      String notes});
}

/// @nodoc
class _$TimelineEventCopyWithImpl<$Res, $Val extends TimelineEvent>
    implements $TimelineEventCopyWith<$Res> {
  _$TimelineEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? opportunity = null,
    Object? title = null,
    Object? date = null,
    Object? category = null,
    Object? virtualMode = null,
    Object? notes = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      opportunity: null == opportunity
          ? _value.opportunity
          : opportunity // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      virtualMode: null == virtualMode
          ? _value.virtualMode
          : virtualMode // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimelineEventImplCopyWith<$Res>
    implements $TimelineEventCopyWith<$Res> {
  factory _$$TimelineEventImplCopyWith(
          _$TimelineEventImpl value, $Res Function(_$TimelineEventImpl) then) =
      __$$TimelineEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String opportunity,
      String title,
      String date,
      String category,
      String virtualMode,
      String notes});
}

/// @nodoc
class __$$TimelineEventImplCopyWithImpl<$Res>
    extends _$TimelineEventCopyWithImpl<$Res, _$TimelineEventImpl>
    implements _$$TimelineEventImplCopyWith<$Res> {
  __$$TimelineEventImplCopyWithImpl(
      _$TimelineEventImpl _value, $Res Function(_$TimelineEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? opportunity = null,
    Object? title = null,
    Object? date = null,
    Object? category = null,
    Object? virtualMode = null,
    Object? notes = null,
  }) {
    return _then(_$TimelineEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      opportunity: null == opportunity
          ? _value.opportunity
          : opportunity // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      virtualMode: null == virtualMode
          ? _value.virtualMode
          : virtualMode // ignore: cast_nullable_to_non_nullable
              as String,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimelineEventImpl implements _TimelineEvent {
  const _$TimelineEventImpl(
      {required this.id,
      required this.opportunity,
      required this.title,
      required this.date,
      required this.category,
      required this.virtualMode,
      required this.notes});

  factory _$TimelineEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimelineEventImplFromJson(json);

  @override
  final String id;
  @override
  final String opportunity;
// ID of related Opportunity Page
  @override
  final String title;
  @override
  final String date;
// YYYY-MM-DD
  @override
  final String category;
// 'Interview' | 'Assignment' | 'Follow-up'
  @override
  final String virtualMode;
// 'Google Meet' | 'Zoom' | 'Teams' etc
  @override
  final String notes;

  @override
  String toString() {
    return 'TimelineEvent(id: $id, opportunity: $opportunity, title: $title, date: $date, category: $category, virtualMode: $virtualMode, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimelineEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.opportunity, opportunity) ||
                other.opportunity == opportunity) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.virtualMode, virtualMode) ||
                other.virtualMode == virtualMode) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, opportunity, title, date, category, virtualMode, notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimelineEventImplCopyWith<_$TimelineEventImpl> get copyWith =>
      __$$TimelineEventImplCopyWithImpl<_$TimelineEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimelineEventImplToJson(
      this,
    );
  }
}

abstract class _TimelineEvent implements TimelineEvent {
  const factory _TimelineEvent(
      {required final String id,
      required final String opportunity,
      required final String title,
      required final String date,
      required final String category,
      required final String virtualMode,
      required final String notes}) = _$TimelineEventImpl;

  factory _TimelineEvent.fromJson(Map<String, dynamic> json) =
      _$TimelineEventImpl.fromJson;

  @override
  String get id;
  @override
  String get opportunity;
  @override // ID of related Opportunity Page
  String get title;
  @override
  String get date;
  @override // YYYY-MM-DD
  String get category;
  @override // 'Interview' | 'Assignment' | 'Follow-up'
  String get virtualMode;
  @override // 'Google Meet' | 'Zoom' | 'Teams' etc
  String get notes;
  @override
  @JsonKey(ignore: true)
  _$$TimelineEventImplCopyWith<_$TimelineEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
