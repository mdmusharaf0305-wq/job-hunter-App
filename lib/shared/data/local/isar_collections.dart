import 'package:isar/isar.dart';

part 'isar_collections.g.dart';

@collection
class JobApplicationCache {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String notionId;

  late String role;
  late String company;
  late String client;
  late String type;
  late String status;
  late String lastUpdated;
  
  String? location;
  String? workMode;
  String? salary;
  String? interviewRounds;
  String? roundPlan;
  String? applicationUrl;
  String? priority;
  
  String? recruiterName;
  String? recruiterCompany;
  String? recruiterPhone;
  String? recruiterEmail;
  String? recruiterLinkedin;
  
  String? relatedTimelineId;
  String? callStatus;
  String? resumeSentOn;
  String? receivedCallOn;
  String? interviewMode;
  String? employmentType;
  String? lastContactedDate;
  String? companyType;
  String? companySize;
  late bool resumeSent;
  String? followupChannel;
  String? notes;
}

@collection
class TimelineEventCache {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String notionId;

  late String opportunity; // Related application Notion page ID
  late String title;
  late String date;
  late String category;
  late String virtualMode;
  late String notes;
}

@collection
class WatchlistCompanyCache {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String? name;

  int? tier;
  List<String>? techStack;
  double? hiringFrequency;
  double? salaryPotential;
  double? engineeringCulture;
  List<String>? remoteFlexibility;
  double? growthPotential;
  String? website;
  String? headquarters;
  String? ats;

  String? employeeCount;
  double? overallRating;
  double? workLifeBalance;
  String? attritionRate;
  List<String>? locations;
}
