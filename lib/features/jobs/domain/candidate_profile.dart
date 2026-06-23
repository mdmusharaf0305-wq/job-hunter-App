import 'package:freezed_annotation/freezed_annotation.dart';

part 'candidate_profile.freezed.dart';
part 'candidate_profile.g.dart';

@freezed
class CandidateProfile with _$CandidateProfile {
  const factory CandidateProfile({
    required double experience, // Target e.g. 4.4 YOE
    required List<String> preferredRoles,
    required List<String> preferredLocations,
    required List<String> requiredSkills,
    required String salaryExpectations,
    required String remotePreference, // 'Remote' | 'Hybrid' | 'Onsite'
  }) = _CandidateProfile;

  factory CandidateProfile.fromJson(Map<String, dynamic> json) =>
      _$CandidateProfileFromJson(json);
}
