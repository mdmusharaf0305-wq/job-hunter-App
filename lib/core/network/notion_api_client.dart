import 'package:dio/dio.dart';
import '../../shared/services/secure_storage_service.dart';
import '../../shared/domain/job_application.dart';
import '../../shared/domain/timeline_event.dart';

class NotionApiClient {
  final Dio _dio;
  final SecureStorageService _storageService;

  NotionApiClient(this._storageService) : _dio = Dio() {
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  Future<Map<String, String>> _headers() async {
    final token = await _storageService.getNotionToken();
    return {
      'Authorization': 'Bearer $token',
      'Notion-Version': '2022-06-28',
      'Content-Type': 'application/json',
    };
  }

  // Helper: Strip emojis and clean strings for fuzzy matching
  static String stripEmoji(String str) {
    // Basic regex targeting emojis and special character symbols
    return str
        .replaceAll(
          RegExp(
            r'[\u{1F300}-\u{1FAFF}\u{2600}-\u{27BF}\u{FE00}-\u{FE0F}\u{1F900}-\u{1F9FF}\u{200D}\u{20E3}\u{E0020}-\u{E007F}]',
            unicode: true,
          ),
          '',
        )
        .trim()
        .toLowerCase();
  }

  // Helper: Find property in Notion properties map by exact/fuzzy candidate matches
  static Map<String, dynamic>? findProp(
      Map<String, dynamic> props, List<String> candidates) {
    // 1. Try exact match
    for (final c in candidates) {
      if (props.containsKey(c)) {
        return props[c] as Map<String, dynamic>?;
      }
    }
    // 2. Try fuzzy match
    final needleCandidates = candidates.map((c) => stripEmoji(c)).toList();
    for (final needle in needleCandidates) {
      for (final entry in props.entries) {
        if (stripEmoji(entry.key) == needle) {
          return entry.value as Map<String, dynamic>?;
        }
      }
    }
    return null;
  }

  // Helper: Extract plain text value from Notion property JSON
  static String getPropertyValue(Map<String, dynamic>? prop) {
    if (prop == null) return '';
    final type = prop['type'] as String?;
    if (type == null) return '';

    switch (type) {
      case 'title':
        final titleArr = prop['title'] as List?;
        if (titleArr != null && titleArr.isNotEmpty) {
          return (titleArr.first as Map)['plain_text']?.toString() ?? '';
        }
        return '';
      case 'rich_text':
        final richTextArr = prop['rich_text'] as List?;
        if (richTextArr != null && richTextArr.isNotEmpty) {
          return (richTextArr.first as Map)['plain_text']?.toString() ?? '';
        }
        return '';
      case 'select':
        final selectObj = prop['select'] as Map?;
        return selectObj?['name']?.toString() ?? '';
      case 'status':
        final statusObj = prop['status'] as Map?;
        return statusObj?['name']?.toString() ?? '';
      case 'multi_select':
        final list = prop['multi_select'] as List?;
        if (list == null) return '';
        return list.map((item) => (item as Map)['name']?.toString() ?? '').join(', ');
      case 'date':
        final dateObj = prop['date'] as Map?;
        return dateObj?['start']?.toString() ?? '';
      case 'url':
        return prop['url']?.toString() ?? '';
      case 'number':
        return prop['number']?.toString() ?? '';
      case 'phone_number':
        return prop['phone_number']?.toString() ?? '';
      case 'email':
        return prop['email']?.toString() ?? '';
      case 'relation':
        final relationArr = prop['relation'] as List?;
        if (relationArr != null && relationArr.isNotEmpty) {
          return (relationArr.first as Map)['id']?.toString() ?? '';
        }
        return '';
      case 'formula':
        final formulaObj = prop['formula'] as Map?;
        if (formulaObj == null) return '';
        final formulaType = formulaObj['type'] as String?;
        if (formulaType == 'string') {
          return formulaObj['string']?.toString() ?? '';
        }
        if (formulaType == 'number') {
          return formulaObj['number']?.toString() ?? '';
        }
        return '';
      case 'checkbox':
        final isChecked = prop['checkbox'] as bool?;
        return isChecked == true ? 'true' : 'false';
      default:
        return '';
    }
  }

  // Map JSON to JobApplication
  static JobApplication mapPageToApplication(Map<String, dynamic> page) {
    final props = page['properties'] as Map<String, dynamic>? ?? {};
    final id = page['id'] as String? ?? '';

    // Title is the Company name
    String company = '';
    for (final entry in props.entries) {
      final value = entry.value as Map<String, dynamic>?;
      if (value != null && value['type'] == 'title') {
        company = getPropertyValue(value);
        break;
      }
    }

    final role = getPropertyValue(findProp(props, ['Role', 'role'])) ;
    final client = getPropertyValue(findProp(props, ['Client', 'client']));
    final recruiterType = getPropertyValue(findProp(props, ['Recruiter Type', 'Type', 'Source Type'])).toLowerCase();
    final type = recruiterType.contains('inbound') ? 'inbound' : 'outbound';

    final lastUpdated = getPropertyValue(findProp(props, ['Last Updated', 'Last Contacted', 'last_updated']));
    final location = getPropertyValue(findProp(props, ['Location', 'location']));
    final workMode = getPropertyValue(findProp(props, ['Work Mode', 'work_mode']));
    final salary = getPropertyValue(findProp(props, ['Salary', 'salary']));
    final interviewRounds = getPropertyValue(findProp(props, ['Interview Rounds', 'Total Rounds', 'interviewRounds']));
    final roundPlan = getPropertyValue(findProp(props, ['Round Plan', 'roundPlan']));
    final applicationUrl = getPropertyValue(findProp(props, ['Application URL', 'applicationUrl', 'Url']));
    final priority = getPropertyValue(findProp(props, ['Priority', 'priority']));

    final recruiterName = getPropertyValue(findProp(props, ['Recruiter Name', 'recruiterName', 'Recruiter']));
    final recruiterCompany = getPropertyValue(findProp(props, ['Recruiter Company', 'recruiter_company', 'Vendor']));
    final recruiterPhone = getPropertyValue(findProp(props, ['Recruiter Contact', 'Recruiter Phone', 'Phone', 'Number', 'phone']));
    final recruiterEmail = getPropertyValue(findProp(props, ['Recruiter Email', 'Email', 'Mail', 'email']));
    final recruiterLinkedin = getPropertyValue(findProp(props, ['LinkedIn URL', 'LinkedIn', 'Linkedin', 'LinkedIn Link', 'LinkedIn Profile', 'linkedin']));

    final status = getPropertyValue(findProp(props, ['Status', 'status']));
    final relationProp = findProp(props, ['Application Timeline', 'Timeline', 'timeline']);
    final relatedTimelineId = getPropertyValue(relationProp);

    final callStatus = getPropertyValue(findProp(props, ['Call Status', 'callStatus', 'call_status']));
    final resumeSentStr = getPropertyValue(findProp(props, ['📤 Resume Sent', 'Resume Sent', 'resumeSent', 'resume_sent']));
    final resumeSent = resumeSentStr == 'true';
    final resumeSentOn = getPropertyValue(findProp(props, ['Resume Sent On', 'resumeSentOn']));
    final receivedCallOn = getPropertyValue(findProp(props, ['📞 Received Call On', 'Received Call On', 'receivedCallOn']));
    final interviewMode = getPropertyValue(findProp(props, ['Interview Mode', 'interviewMode', 'interview_mode']));
    final employmentType = getPropertyValue(findProp(props, ['Employment Type', 'employmentType', 'employment_type']));
    final lastContactedDate = getPropertyValue(findProp(props, ['⏳ Last Contacted', 'Last Contacted', 'lastContactedDate', 'last_contacted']));
    final companyType = getPropertyValue(findProp(props, ['🏛️ Company Type', 'Company Type', 'companyType', 'company_type']));
    final companySize = getPropertyValue(findProp(props, ['Company Count', '🏢 Company Size', 'Company Size', 'companySize', 'company_size']));
    final followupChannel = getPropertyValue(findProp(props, ['Followup Channel', 'Follow-up Channel', 'followup_channel']));
    final notes = getPropertyValue(findProp(props, ['📚 Notes', 'Notes', 'notes']));

    return JobApplication(
      id: id,
      role: role.isEmpty ? 'Unknown Role' : role,
      company: company.isEmpty ? 'Unknown Company' : company,
      client: client.isEmpty ? 'Direct' : client,
      type: type,
      status: status.isEmpty ? '⚪ Not Started' : status,
      lastUpdated: lastUpdated.isEmpty ? DateTime.now().toIso8601String().split('T')[0] : lastUpdated,
      location: location.isEmpty ? null : location,
      workMode: workMode.isEmpty ? null : workMode,
      salary: salary.isEmpty ? null : salary,
      interviewRounds: interviewRounds.isEmpty ? null : interviewRounds,
      roundPlan: roundPlan.isEmpty ? null : roundPlan,
      applicationUrl: applicationUrl.isEmpty ? null : applicationUrl,
      priority: priority.isEmpty ? 'Medium' : priority,
      recruiterName: recruiterName.isEmpty ? null : recruiterName,
      recruiterCompany: recruiterCompany.isEmpty ? null : recruiterCompany,
      recruiterPhone: recruiterPhone.isEmpty ? null : recruiterPhone,
      recruiterEmail: recruiterEmail.isEmpty ? null : recruiterEmail,
      recruiterLinkedin: recruiterLinkedin.isEmpty ? null : recruiterLinkedin,
      relatedTimelineId: relatedTimelineId.isEmpty ? null : relatedTimelineId,
      callStatus: callStatus.isEmpty ? null : callStatus,
      resumeSentOn: resumeSentOn.isEmpty ? null : resumeSentOn,
      receivedCallOn: receivedCallOn.isEmpty ? null : receivedCallOn,
      interviewMode: interviewMode.isEmpty ? null : interviewMode,
      employmentType: employmentType.isEmpty ? null : employmentType,
      lastContactedDate: lastContactedDate.isEmpty ? null : lastContactedDate,
      companyType: companyType.isEmpty ? null : companyType,
      companySize: companySize.isEmpty ? null : companySize,
      resumeSent: resumeSent,
      followupChannel: followupChannel.isEmpty ? null : followupChannel,
      notes: notes.isEmpty ? null : notes,
    );
  }

  // Fetch all applications
  Future<List<JobApplication>> fetchApplications() async {
    final dbId = await _storageService.getOpportunitiesDbId();
    if (dbId == null || dbId.isEmpty) return [];

    final headers = await _headers();
    final results = <dynamic>[];
    String? cursor;
    bool hasMore = true;

    try {
      while (hasMore) {
        final data = <String, dynamic>{'page_size': 100};
        if (cursor != null) data['start_cursor'] = cursor;

        final response = await _dio.post(
          'https://api.notion.com/v1/databases/$dbId/query',
          data: data,
          options: Options(headers: headers),
        );

        if (response.statusCode == 200) {
          final body = response.data as Map<String, dynamic>;
          final pages = body['results'] as List? ?? [];
          results.addAll(pages);
          hasMore = body['has_more'] as bool? ?? false;
          cursor = body['next_cursor'] as String?;
        } else {
          hasMore = false;
        }
      }

      return results
          .map((p) => mapPageToApplication(p as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Notion API query failed: $e');
    }
  }

  // Fetch schema options
  Future<Map<String, List<String>>> fetchDatabaseSchemaOptions() async {
    final dbId = await _storageService.getOpportunitiesDbId();
    if (dbId == null || dbId.isEmpty) return {};

    final headers = await _headers();
    try {
      final response = await _dio.get(
        'https://api.notion.com/v1/databases/$dbId',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        final body = response.data as Map<String, dynamic>;
        final props = body['properties'] as Map<String, dynamic>? ?? {};

        final result = <String, List<String>>{};

        List<String> extractOptions(String propName) {
          final prop = findProp(props, [propName]);
          if (prop == null) return [];
          final type = prop['type'] as String?;
          if (type == 'select') {
            final select = prop['select'] as Map?;
            final options = select?['options'] as List?;
            return options?.map((o) => (o as Map)['name']?.toString() ?? '').toList() ?? [];
          }
          if (type == 'multi_select') {
            final multiSelect = prop['multi_select'] as Map?;
            final options = multiSelect?['options'] as List?;
            return options?.map((o) => (o as Map)['name']?.toString() ?? '').toList() ?? [];
          }
          if (type == 'status') {
            final statusObj = prop['status'] as Map?;
            final options = statusObj?['options'] as List?;
            return options?.map((o) => (o as Map)['name']?.toString() ?? '').toList() ?? [];
          }
          return [];
        }

        result['roles'] = extractOptions('💼 Role');
        result['salaries'] = extractOptions('💸 Salary');
        result['roundPlans'] = extractOptions('🗺️ Round Plan');
        result['totalRounds'] = extractOptions('🪜 Total Rounds');
        result['employmentTypes'] = extractOptions('📑 Employment Type');
        result['companyTypes'] = extractOptions('🏛️ Company Type');
        result['companySizes'] = extractOptions('🏢 Company Size');
        result['locations'] = extractOptions('📍 Location');
        result['clients'] = extractOptions('🤝 Client');
        result['statuses'] = extractOptions('Status');
        result['callStatuses'] = extractOptions('Call Status');
        result['interviewModes'] = extractOptions('🎥 Interview Mode');
        result['followupChannels'] = extractOptions('Follow-up Channel');

        return result;
      }
      return {};
    } catch (_) {
      return {};
    }
  }

  // Update application stage/status
  Future<JobApplication> updateApplicationStage(String pageId, String newStage) async {
    final headers = await _headers();
    final data = {
      'properties': {
        'Status': {
          'status': {'name': newStage}
        }
      }
    };

    try {
      final response = await _dio.patch(
        'https://api.notion.com/v1/pages/$pageId',
        data: data,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return mapPageToApplication(response.data as Map<String, dynamic>);
      }
      throw Exception('Failed to update stage');
    } catch (e) {
      throw Exception('Notion API update stage failed: $e');
    }
  }

  // Update application properties
  Future<JobApplication> updateApplication(String pageId, Map<String, dynamic> updateProps) async {
    final headers = await _headers();
    
    // Parse key-value properties into Notion's format
    final properties = <String, dynamic>{};

    void addProperty(String name, dynamic value, String type) {
      if (value == null) return;
      if (type == 'status') {
        properties[name] = {'status': {'name': value}};
      } else if (type == 'select') {
        properties[name] = {'select': {'name': value}};
      } else if (type == 'rich_text') {
        properties[name] = {'rich_text': [{'text': {'content': value}}]};
      } else if (type == 'title') {
        properties[name] = {'title': [{'text': {'content': value}}]};
      } else if (type == 'url') {
        properties[name] = {'url': value};
      } else if (type == 'date') {
        properties[name] = {'date': {'start': value}};
      } else if (type == 'checkbox') {
        properties[name] = {'checkbox': value == true};
      }
    }

    addProperty('Status', updateProps['status'], 'status');
    addProperty('Priority', updateProps['priority'], 'select');
    addProperty('💼 Role', updateProps['role'], 'select');
    addProperty('🤝 Client', updateProps['client'], 'select');
    addProperty('Work Mode', updateProps['workMode'], 'select');
    addProperty('📍 Location', updateProps['location'], 'select');
    addProperty('💸 Salary', updateProps['salary'], 'select');
    addProperty('Recruiter Name', updateProps['recruiterName'], 'rich_text');
    addProperty('Recruiter Company', updateProps['recruiterCompany'], 'rich_text');
    addProperty('Recruiter Phone', updateProps['recruiterPhone'], 'rich_text');
    addProperty('Recruiter Email', updateProps['recruiterEmail'], 'rich_text');
    addProperty('LinkedIn URL', updateProps['recruiterLinkedin'], 'url');
    addProperty('Call Status', updateProps['callStatus'], 'status');
    addProperty('📤 Resume Sent', updateProps['resumeSent'], 'checkbox');
    addProperty('Resume Sent On', updateProps['resumeSentOn'], 'date');
    addProperty('📞 Received Call On', updateProps['receivedCallOn'], 'date');
    addProperty('Interview Mode', updateProps['interviewMode'], 'select');
    addProperty('Employment Type', updateProps['employmentType'], 'select');
    addProperty('⏳ Last Contacted', updateProps['lastContactedDate'], 'date');
    addProperty('🏛️ Company Type', updateProps['companyType'], 'select');
    addProperty('🏢 Company Size', updateProps['companySize'], 'select');
    addProperty('Follow-up Channel', updateProps['followupChannel'], 'select');
    addProperty('📚 Notes', updateProps['notes'], 'rich_text');

    final requestBody = {'properties': properties};

    try {
      final response = await _dio.patch(
        'https://api.notion.com/v1/pages/$pageId',
        data: requestBody,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return mapPageToApplication(response.data as Map<String, dynamic>);
      }
      throw Exception('Failed to update page');
    } catch (e) {
      throw Exception('Notion API update application failed: $e');
    }
  }

  // Create new application page
  Future<JobApplication> createApplication(Map<String, dynamic> insertProps) async {
    final dbId = await _storageService.getOpportunitiesDbId();
    if (dbId == null || dbId.isEmpty) throw Exception('Opportunities DB ID not configured');

    final headers = await _headers();
    final properties = <String, dynamic>{};

    void addProperty(String name, dynamic value, String type) {
      if (value == null) return;
      if (type == 'status') {
        properties[name] = {'status': {'name': value}};
      } else if (type == 'select') {
        properties[name] = {'select': {'name': value}};
      } else if (type == 'rich_text') {
        properties[name] = {'rich_text': [{'text': {'content': value}}]};
      } else if (type == 'title') {
        properties[name] = {'title': [{'text': {'content': value}}]};
      } else if (type == 'url') {
        properties[name] = {'url': value};
      } else if (type == 'date') {
        properties[name] = {'date': {'start': value}};
      } else if (type == 'checkbox') {
        properties[name] = {'checkbox': value == true};
      }
    }

    addProperty('Company', insertProps['company'], 'title');
    addProperty('💼 Role', insertProps['role'], 'select');
    addProperty('🤝 Client', insertProps['client'] ?? 'Direct', 'select');
    addProperty('Recruiter Type', insertProps['type'] == 'inbound' ? 'Inbound' : 'Outbound', 'select');
    addProperty('Status', insertProps['status'] ?? '📄 Applied', 'status');
    addProperty('Priority', insertProps['priority'] ?? 'Medium', 'select');
    addProperty('Work Mode', insertProps['workMode'] ?? 'Hybrid', 'select');
    addProperty('📍 Location', insertProps['location'], 'select');
    addProperty('💸 Salary', insertProps['salary'], 'select');
    addProperty('Recruiter Name', insertProps['recruiterName'], 'rich_text');
    addProperty('Recruiter Company', insertProps['recruiterCompany'], 'rich_text');
    addProperty('Recruiter Phone', insertProps['recruiterPhone'], 'rich_text');
    addProperty('Recruiter Email', insertProps['recruiterEmail'], 'rich_text');
    addProperty('LinkedIn URL', insertProps['recruiterLinkedin'], 'url');
    addProperty('Call Status', insertProps['callStatus'], 'status');
    addProperty('📤 Resume Sent', insertProps['resumeSent'] == true, 'checkbox');
    addProperty('Resume Sent On', insertProps['resumeSentOn'], 'date');
    addProperty('📚 Notes', insertProps['notes'], 'rich_text');

    final requestBody = {
      'parent': {'database_id': dbId},
      'properties': properties
    };

    try {
      final response = await _dio.post(
        'https://api.notion.com/v1/pages',
        data: requestBody,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return mapPageToApplication(response.data as Map<String, dynamic>);
      }
      throw Exception('Failed to create page');
    } catch (e) {
      throw Exception('Notion API create application failed: $e');
    }
  }

  // --- TIMELINE EVENTS ---
  Future<List<TimelineEvent>> fetchTimelineEvents() async {
    final dbId = await _storageService.getTimelineDbId();
    if (dbId == null || dbId.isEmpty) return [];

    final headers = await _headers();
    final requestBody = {
      'sorts': [
        {'property': '📅 Event Date', 'direction': 'descending'}
      ]
    };

    try {
      final response = await _dio.post(
        'https://api.notion.com/v1/databases/$dbId/query',
        data: requestBody,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        final body = response.data as Map<String, dynamic>;
        final results = body['results'] as List? ?? [];
        return results.map((page) {
          final props = page['properties'] as Map<String, dynamic>? ?? {};
          final id = page['id'] as String? ?? '';
          
          final relationArr = findProp(props, ['Oppurtunity'])?['relation'] as List?;
          final opportunity = relationArr != null && relationArr.isNotEmpty
              ? (relationArr.first as Map)['id']?.toString() ?? ''
              : '';
              
          final category = getPropertyValue(findProp(props, ['🎯 Event Category']));
          final date = getPropertyValue(findProp(props, ['📅 Event Date']));
          
          final titleFromSelect = getPropertyValue(findProp(props, ['📝 ET']));
          final titleFromText = getPropertyValue(findProp(props, ['📝 Event Title 1']));
          final title = titleFromSelect.isNotEmpty ? titleFromSelect : (titleFromText.isNotEmpty ? titleFromText : 'Untitled Event');
          
          final virtualMode = getPropertyValue(findProp(props, ['Interview Mode']));
          final notes = getPropertyValue(findProp(props, ['📋 Notes']));

          return TimelineEvent(
            id: id,
            opportunity: opportunity,
            title: title,
            date: date,
            category: category,
            virtualMode: virtualMode,
            notes: notes,
          );
        }).toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  // Create timeline event
  Future<bool> createTimelineEvent(TimelineEvent event) async {
    final dbId = await _storageService.getTimelineDbId();
    if (dbId == null || dbId.isEmpty) return false;

    final headers = await _headers();
    final properties = <String, dynamic>{
      '📝 Event Title 1': {
        'title': [
          {
            'text': {'content': event.title}
          }
        ]
      },
      '🎯 Event Category': {
        'select': {'name': event.category}
      },
      '📅 Event Date': {
        'date': {'start': event.date}
      }
    };

    if (event.title.isNotEmpty) {
      properties['📝 ET'] = {
        'select': {'name': event.title}
      };
    }
    if (event.opportunity.isNotEmpty) {
      properties['Oppurtunity'] = {
        'relation': [
          {'id': event.opportunity}
        ]
      };
    }
    if (event.virtualMode.isNotEmpty) {
      properties['Interview Mode'] = {
        'status': {'name': event.virtualMode}
      };
    }
    if (event.notes.isNotEmpty) {
      properties['📋 Notes'] = {
        'rich_text': [
          {
            'text': {'content': event.notes}
          }
        ]
      };
    }

    final requestBody = {
      'parent': {'database_id': dbId},
      'properties': properties
    };

    try {
      final response = await _dio.post(
        'https://api.notion.com/v1/pages',
        data: requestBody,
        options: Options(headers: headers),
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
