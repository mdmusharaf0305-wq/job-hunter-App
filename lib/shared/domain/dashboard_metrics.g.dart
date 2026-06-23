// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_metrics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeekCountImpl _$$WeekCountImplFromJson(Map<String, dynamic> json) =>
    _$WeekCountImpl(
      week: json['week'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$$WeekCountImplToJson(_$WeekCountImpl instance) =>
    <String, dynamic>{
      'week': instance.week,
      'count': instance.count,
    };

_$RecruiterResponseCountImpl _$$RecruiterResponseCountImplFromJson(
        Map<String, dynamic> json) =>
    _$RecruiterResponseCountImpl(
      name: json['name'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$$RecruiterResponseCountImplToJson(
        _$RecruiterResponseCountImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'count': instance.count,
    };

_$DateCountImpl _$$DateCountImplFromJson(Map<String, dynamic> json) =>
    _$DateCountImpl(
      date: json['date'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$$DateCountImplToJson(_$DateCountImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'count': instance.count,
    };

_$DashboardMetricsImpl _$$DashboardMetricsImplFromJson(
        Map<String, dynamic> json) =>
    _$DashboardMetricsImpl(
      totalOpportunities: (json['totalOpportunities'] as num).toInt(),
      activeRecruiters: (json['activeRecruiters'] as num).toInt(),
      interviewsCount: (json['interviewsCount'] as num).toInt(),
      offersCount: (json['offersCount'] as num).toInt(),
      responseRate: (json['responseRate'] as num).toDouble(),
      totalApplications: (json['totalApplications'] as num).toInt(),
      respondedApplications: (json['respondedApplications'] as num).toInt(),
      applicationsPerWeek: (json['applicationsPerWeek'] as List<dynamic>)
          .map((e) => WeekCount.fromJson(e as Map<String, dynamic>))
          .toList(),
      recruiterResponses: (json['recruiterResponses'] as List<dynamic>)
          .map(
              (e) => RecruiterResponseCount.fromJson(e as Map<String, dynamic>))
          .toList(),
      interviewTrend: (json['interviewTrend'] as List<dynamic>)
          .map((e) => DateCount.fromJson(e as Map<String, dynamic>))
          .toList(),
      followUpsDue: (json['followUpsDue'] as List<dynamic>)
          .map((e) => Recruiter.fromJson(e as Map<String, dynamic>))
          .toList(),
      latestActivity: (json['latestActivity'] as List<dynamic>)
          .map((e) => JobApplication.fromJson(e as Map<String, dynamic>))
          .toList(),
      upcomingInterviews: (json['upcomingInterviews'] as List<dynamic>)
          .map((e) => JobApplication.fromJson(e as Map<String, dynamic>))
          .toList(),
      allApplications: (json['allApplications'] as List<dynamic>)
          .map((e) => JobApplication.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DashboardMetricsImplToJson(
        _$DashboardMetricsImpl instance) =>
    <String, dynamic>{
      'totalOpportunities': instance.totalOpportunities,
      'activeRecruiters': instance.activeRecruiters,
      'interviewsCount': instance.interviewsCount,
      'offersCount': instance.offersCount,
      'responseRate': instance.responseRate,
      'totalApplications': instance.totalApplications,
      'respondedApplications': instance.respondedApplications,
      'applicationsPerWeek': instance.applicationsPerWeek,
      'recruiterResponses': instance.recruiterResponses,
      'interviewTrend': instance.interviewTrend,
      'followUpsDue': instance.followUpsDue,
      'latestActivity': instance.latestActivity,
      'upcomingInterviews': instance.upcomingInterviews,
      'allApplications': instance.allApplications,
    };
