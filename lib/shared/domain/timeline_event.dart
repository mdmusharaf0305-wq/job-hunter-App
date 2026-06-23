import 'package:freezed_annotation/freezed_annotation.dart';

part 'timeline_event.freezed.dart';
part 'timeline_event.g.dart';

@freezed
class TimelineEvent with _$TimelineEvent {
  const factory TimelineEvent({
    required String id,
    required String opportunity, // ID of related Opportunity Page
    required String title,
    required String date, // YYYY-MM-DD
    required String category, // 'Interview' | 'Assignment' | 'Follow-up'
    required String virtualMode, // 'Google Meet' | 'Zoom' | 'Teams' etc
    required String notes,
  }) = _TimelineEvent;

  factory TimelineEvent.fromJson(Map<String, dynamic> json) =>
      _$TimelineEventFromJson(json);
}
