// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidate_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CandidateProfileImpl _$$CandidateProfileImplFromJson(
        Map<String, dynamic> json) =>
    _$CandidateProfileImpl(
      experience: (json['experience'] as num).toDouble(),
      preferredRoles: (json['preferredRoles'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      preferredLocations: (json['preferredLocations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      requiredSkills: (json['requiredSkills'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      salaryExpectations: json['salaryExpectations'] as String,
      remotePreference: json['remotePreference'] as String,
    );

Map<String, dynamic> _$$CandidateProfileImplToJson(
        _$CandidateProfileImpl instance) =>
    <String, dynamic>{
      'experience': instance.experience,
      'preferredRoles': instance.preferredRoles,
      'preferredLocations': instance.preferredLocations,
      'requiredSkills': instance.requiredSkills,
      'salaryExpectations': instance.salaryExpectations,
      'remotePreference': instance.remotePreference,
    };
