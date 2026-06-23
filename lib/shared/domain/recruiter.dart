import 'package:freezed_annotation/freezed_annotation.dart';

part 'recruiter.freezed.dart';
part 'recruiter.g.dart';

@freezed
class Recruiter with _$Recruiter {
  const factory Recruiter({
    required String id,
    required String company,
    required String client,
    required String role,
    required String recruiterName,
    String? recruiterPhone,
    String? recruiterEmail,
    String? recruiterLinkedin,
    required String contactStatus,
    String? contactMethod,
    String? lastContacted, // YYYY-MM-DD
    String? nextFollowUp,  // YYYY-MM-DD
    String? priority,      // 'High' | 'Medium' | 'Low'
    String? source,
    String? applicationUrl,
    required String dbSource, // 'inbound' | 'outbound'
    String? relatedTimelineId,
  }) = _Recruiter;

  factory Recruiter.fromJson(Map<String, dynamic> json) =>
      _$RecruiterFromJson(json);
}
