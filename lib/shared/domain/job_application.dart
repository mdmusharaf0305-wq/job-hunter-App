import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_application.freezed.dart';
part 'job_application.g.dart';

@freezed
class JobApplication with _$JobApplication {
  const factory JobApplication({
    required String id,
    required String role,
    required String company,
    @Default('Direct') String client,
    required String type, // 'inbound' | 'outbound'
    required String status,
    required String lastUpdated, // YYYY-MM-DD
    String? location,
    String? workMode,
    String? salary,
    String? interviewRounds,
    String? roundPlan,
    String? applicationUrl,
    String? priority, // 'High' | 'Medium' | 'Low'
    String? recruiterName,
    String? recruiterCompany,
    String? recruiterPhone,
    String? recruiterEmail,
    String? recruiterLinkedin,
    String? relatedTimelineId,
    String? callStatus,
    String? resumeSentOn,
    String? receivedCallOn,
    String? interviewMode,
    String? employmentType,
    String? lastContactedDate,
    String? companyType,
    String? companySize,
    @Default(false) bool resumeSent,
    String? followupChannel,
    String? notes,
  }) = _JobApplication;

  factory JobApplication.fromJson(Map<String, dynamic> json) =>
      _$JobApplicationFromJson(json);
}
