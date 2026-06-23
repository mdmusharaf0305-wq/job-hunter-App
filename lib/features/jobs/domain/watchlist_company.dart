import 'package:freezed_annotation/freezed_annotation.dart';

part 'watchlist_company.freezed.dart';
part 'watchlist_company.g.dart';

@freezed
class ScoreBreakdown with _$ScoreBreakdown {
  const factory ScoreBreakdown({
    required int skillAlignment,
    required int hiringFrequency,
    required int salaryPotential,
    required int engineeringCulture,
    required int remoteFlexibility,
    required int growthPotential,
  }) = _ScoreBreakdown;

  factory ScoreBreakdown.fromJson(Map<String, dynamic> json) =>
      _$ScoreBreakdownFromJson(json);
}

@freezed
class WatchlistCompany with _$WatchlistCompany {
  const factory WatchlistCompany({
    required String name,
    required int tier,
    required List<String> techStack,
    required double hiringFrequency,
    required double salaryPotential,
    required double engineeringCulture,
    required List<String> remoteFlexibility,
    required double growthPotential,
    required String website,
    required String headquarters,
    String? ats,
    int? relevanceScore,
    int? authenticityScore,
    String? authenticityBadge, // '✓ Direct Employer' | 'Product Company' etc
    ScoreBreakdown? scoreBreakdown,
    @Default(7.5) double overallRating,
    @Default(7.5) double workLifeBalance,
    @Default('14%') String attritionRate,
    @Default('101-500') String employeeCount,
    @Default([]) List<String> locations,
    String? applicationId,
  }) = _WatchlistCompany;

  factory WatchlistCompany.fromJson(Map<String, dynamic> json) =>
      _$WatchlistCompanyFromJson(json);
}
