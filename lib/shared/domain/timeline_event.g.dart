// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimelineEventImpl _$$TimelineEventImplFromJson(Map<String, dynamic> json) =>
    _$TimelineEventImpl(
      id: json['id'] as String,
      opportunity: json['opportunity'] as String,
      title: json['title'] as String,
      date: json['date'] as String,
      category: json['category'] as String,
      virtualMode: json['virtualMode'] as String,
      notes: json['notes'] as String,
    );

Map<String, dynamic> _$$TimelineEventImplToJson(_$TimelineEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'opportunity': instance.opportunity,
      'title': instance.title,
      'date': instance.date,
      'category': instance.category,
      'virtualMode': instance.virtualMode,
      'notes': instance.notes,
    };
