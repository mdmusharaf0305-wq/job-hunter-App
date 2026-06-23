// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JobApplicationImpl _$$JobApplicationImplFromJson(Map<String, dynamic> json) =>
    _$JobApplicationImpl(
      id: json['id'] as String,
      role: json['role'] as String,
      company: json['company'] as String,
      client: json['client'] as String? ?? 'Direct',
      type: json['type'] as String,
      status: json['status'] as String,
      lastUpdated: json['lastUpdated'] as String,
      location: json['location'] as String?,
      workMode: json['workMode'] as String?,
      salary: json['salary'] as String?,
      interviewRounds: json['interviewRounds'] as String?,
      roundPlan: json['roundPlan'] as String?,
      applicationUrl: json['applicationUrl'] as String?,
      priority: json['priority'] as String?,
      recruiterName: json['recruiterName'] as String?,
      recruiterCompany: json['recruiterCompany'] as String?,
      recruiterPhone: json['recruiterPhone'] as String?,
      recruiterEmail: json['recruiterEmail'] as String?,
      recruiterLinkedin: json['recruiterLinkedin'] as String?,
      relatedTimelineId: json['relatedTimelineId'] as String?,
      callStatus: json['callStatus'] as String?,
      resumeSentOn: json['resumeSentOn'] as String?,
      receivedCallOn: json['receivedCallOn'] as String?,
      interviewMode: json['interviewMode'] as String?,
      employmentType: json['employmentType'] as String?,
      lastContactedDate: json['lastContactedDate'] as String?,
      companyType: json['companyType'] as String?,
      companySize: json['companySize'] as String?,
      resumeSent: json['resumeSent'] as bool? ?? false,
      followupChannel: json['followupChannel'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$JobApplicationImplToJson(
        _$JobApplicationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'company': instance.company,
      'client': instance.client,
      'type': instance.type,
      'status': instance.status,
      'lastUpdated': instance.lastUpdated,
      'location': instance.location,
      'workMode': instance.workMode,
      'salary': instance.salary,
      'interviewRounds': instance.interviewRounds,
      'roundPlan': instance.roundPlan,
      'applicationUrl': instance.applicationUrl,
      'priority': instance.priority,
      'recruiterName': instance.recruiterName,
      'recruiterCompany': instance.recruiterCompany,
      'recruiterPhone': instance.recruiterPhone,
      'recruiterEmail': instance.recruiterEmail,
      'recruiterLinkedin': instance.recruiterLinkedin,
      'relatedTimelineId': instance.relatedTimelineId,
      'callStatus': instance.callStatus,
      'resumeSentOn': instance.resumeSentOn,
      'receivedCallOn': instance.receivedCallOn,
      'interviewMode': instance.interviewMode,
      'employmentType': instance.employmentType,
      'lastContactedDate': instance.lastContactedDate,
      'companyType': instance.companyType,
      'companySize': instance.companySize,
      'resumeSent': instance.resumeSent,
      'followupChannel': instance.followupChannel,
      'notes': instance.notes,
    };
