// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScoreBreakdownImpl _$$ScoreBreakdownImplFromJson(Map<String, dynamic> json) =>
    _$ScoreBreakdownImpl(
      skillAlignment: (json['skillAlignment'] as num).toInt(),
      hiringFrequency: (json['hiringFrequency'] as num).toInt(),
      salaryPotential: (json['salaryPotential'] as num).toInt(),
      engineeringCulture: (json['engineeringCulture'] as num).toInt(),
      remoteFlexibility: (json['remoteFlexibility'] as num).toInt(),
      growthPotential: (json['growthPotential'] as num).toInt(),
    );

Map<String, dynamic> _$$ScoreBreakdownImplToJson(
        _$ScoreBreakdownImpl instance) =>
    <String, dynamic>{
      'skillAlignment': instance.skillAlignment,
      'hiringFrequency': instance.hiringFrequency,
      'salaryPotential': instance.salaryPotential,
      'engineeringCulture': instance.engineeringCulture,
      'remoteFlexibility': instance.remoteFlexibility,
      'growthPotential': instance.growthPotential,
    };

_$WatchlistCompanyImpl _$$WatchlistCompanyImplFromJson(
        Map<String, dynamic> json) =>
    _$WatchlistCompanyImpl(
      name: json['name'] as String,
      tier: (json['tier'] as num).toInt(),
      techStack:
          (json['techStack'] as List<dynamic>).map((e) => e as String).toList(),
      hiringFrequency: (json['hiringFrequency'] as num).toDouble(),
      salaryPotential: (json['salaryPotential'] as num).toDouble(),
      engineeringCulture: (json['engineeringCulture'] as num).toDouble(),
      remoteFlexibility: (json['remoteFlexibility'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      growthPotential: (json['growthPotential'] as num).toDouble(),
      website: json['website'] as String,
      headquarters: json['headquarters'] as String,
      ats: json['ats'] as String?,
      relevanceScore: (json['relevanceScore'] as num?)?.toInt(),
      authenticityScore: (json['authenticityScore'] as num?)?.toInt(),
      authenticityBadge: json['authenticityBadge'] as String?,
      scoreBreakdown: json['scoreBreakdown'] == null
          ? null
          : ScoreBreakdown.fromJson(
              json['scoreBreakdown'] as Map<String, dynamic>),
      overallRating: (json['overallRating'] as num?)?.toDouble() ?? 7.5,
      workLifeBalance: (json['workLifeBalance'] as num?)?.toDouble() ?? 7.5,
      attritionRate: json['attritionRate'] as String? ?? '14%',
      employeeCount: json['employeeCount'] as String? ?? '101-500',
      locations: (json['locations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      applicationId: json['applicationId'] as String?,
    );

Map<String, dynamic> _$$WatchlistCompanyImplToJson(
        _$WatchlistCompanyImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'tier': instance.tier,
      'techStack': instance.techStack,
      'hiringFrequency': instance.hiringFrequency,
      'salaryPotential': instance.salaryPotential,
      'engineeringCulture': instance.engineeringCulture,
      'remoteFlexibility': instance.remoteFlexibility,
      'growthPotential': instance.growthPotential,
      'website': instance.website,
      'headquarters': instance.headquarters,
      'ats': instance.ats,
      'relevanceScore': instance.relevanceScore,
      'authenticityScore': instance.authenticityScore,
      'authenticityBadge': instance.authenticityBadge,
      'scoreBreakdown': instance.scoreBreakdown,
      'overallRating': instance.overallRating,
      'workLifeBalance': instance.workLifeBalance,
      'attritionRate': instance.attritionRate,
      'employeeCount': instance.employeeCount,
      'locations': instance.locations,
      'applicationId': instance.applicationId,
    };
