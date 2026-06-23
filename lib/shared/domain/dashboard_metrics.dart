import 'package:freezed_annotation/freezed_annotation.dart';
import 'job_application.dart';
import 'recruiter.dart';

part 'dashboard_metrics.freezed.dart';
part 'dashboard_metrics.g.dart';

@freezed
class WeekCount with _$WeekCount {
  const factory WeekCount({
    required String week,
    required int count,
  }) = _WeekCount;

  factory WeekCount.fromJson(Map<String, dynamic> json) =>
      _$WeekCountFromJson(json);
}

@freezed
class RecruiterResponseCount with _$RecruiterResponseCount {
  const factory RecruiterResponseCount({
    required String name,
    required int count,
  }) = _RecruiterResponseCount;

  factory RecruiterResponseCount.fromJson(Map<String, dynamic> json) =>
      _$RecruiterResponseCountFromJson(json);
}

@freezed
class DateCount with _$DateCount {
  const factory DateCount({
    required String date,
    required int count,
  }) = _DateCount;

  factory DateCount.fromJson(Map<String, dynamic> json) =>
      _$DateCountFromJson(json);
}

@freezed
class DashboardMetrics with _$DashboardMetrics {
  const factory DashboardMetrics({
    required int totalOpportunities,
    required int activeRecruiters,
    required int interviewsCount,
    required int offersCount,
    required double responseRate,
    required int totalApplications,
    required int respondedApplications,
    required List<WeekCount> applicationsPerWeek,
    required List<RecruiterResponseCount> recruiterResponses,
    required List<DateCount> interviewTrend,
    required List<Recruiter> followUpsDue,
    required List<JobApplication> latestActivity,
    required List<JobApplication> upcomingInterviews,
    required List<JobApplication> allApplications,
  }) = _DashboardMetrics;

  factory DashboardMetrics.fromJson(Map<String, dynamic> json) =>
      _$DashboardMetricsFromJson(json);
}
