// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recruiter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecruiterImpl _$$RecruiterImplFromJson(Map<String, dynamic> json) =>
    _$RecruiterImpl(
      id: json['id'] as String,
      company: json['company'] as String,
      client: json['client'] as String,
      role: json['role'] as String,
      recruiterName: json['recruiterName'] as String,
      recruiterPhone: json['recruiterPhone'] as String?,
      recruiterEmail: json['recruiterEmail'] as String?,
      recruiterLinkedin: json['recruiterLinkedin'] as String?,
      contactStatus: json['contactStatus'] as String,
      contactMethod: json['contactMethod'] as String?,
      lastContacted: json['lastContacted'] as String?,
      nextFollowUp: json['nextFollowUp'] as String?,
      priority: json['priority'] as String?,
      source: json['source'] as String?,
      applicationUrl: json['applicationUrl'] as String?,
      dbSource: json['dbSource'] as String,
      relatedTimelineId: json['relatedTimelineId'] as String?,
    );

Map<String, dynamic> _$$RecruiterImplToJson(_$RecruiterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company': instance.company,
      'client': instance.client,
      'role': instance.role,
      'recruiterName': instance.recruiterName,
      'recruiterPhone': instance.recruiterPhone,
      'recruiterEmail': instance.recruiterEmail,
      'recruiterLinkedin': instance.recruiterLinkedin,
      'contactStatus': instance.contactStatus,
      'contactMethod': instance.contactMethod,
      'lastContacted': instance.lastContacted,
      'nextFollowUp': instance.nextFollowUp,
      'priority': instance.priority,
      'source': instance.source,
      'applicationUrl': instance.applicationUrl,
      'dbSource': instance.dbSource,
      'relatedTimelineId': instance.relatedTimelineId,
    };
