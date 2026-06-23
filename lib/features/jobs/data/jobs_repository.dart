import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart' as html_parser;
import '../../../../core/constants/app_keys.dart';
import '../../../../shared/domain/job_application.dart';
import '../../../../shared/data/local/isar_collections.dart';
import '../../../../shared/services/isar_service.dart';
import '../domain/candidate_profile.dart';
import '../domain/watchlist_company.dart';

class JobsRepository {
  final IsarService _isarService;
  final Dio _dio;

  JobsRepository(this._isarService) : _dio = Dio() {
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 5);
  }

  // --- Candidate Profile ---
  Future<CandidateProfile> getCandidateProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(AppKeys.candidateProfile);
    if (jsonStr != null && jsonStr.isNotEmpty) {
      try {
        return CandidateProfile.fromJson(json.decode(jsonStr) as Map<String, dynamic>);
      } catch (_) {}
    }
    
    // Load default from assets
    try {
      final defaultJson = await rootBundle.loadString('assets/candidateProfile.json');
      return CandidateProfile.fromJson(json.decode(defaultJson) as Map<String, dynamic>);
    } catch (_) {
      // Hard fallback
      return const CandidateProfile(
        experience: 4.4,
        preferredRoles: ['Frontend Engineer', 'React Developer', 'Next.js Developer'],
        preferredLocations: ['Bengaluru', 'Remote'],
        requiredSkills: ['React', 'Next.js', 'TypeScript', 'Node.js'],
        salaryExpectations: '₹15L - ₹25L',
        remotePreference: 'Hybrid',
      );
    }
  }

  Future<void> saveCandidateProfile(CandidateProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppKeys.candidateProfile, json.encode(profile.toJson()));
  }

  // --- Authenticity Scoring Engine ---
  Map<String, dynamic> calculateAuthenticity(String name, {String? ats, int tier = 3}) {
    final nameLower = name.toLowerCase();
    
    final agencyKeywords = [
      'consulting', 'consultancy', 'staffing', 'talent', 'recruitment', 
      'solutions', 'placements', 'hr services', 'manpower', 'peoplefy', 
      'randstad', 'tekpillar', 'allegis', 'talent500', 'hiring', 'partners',
      'search', 'associates', 'careers group'
    ];
    
    final isAgencyPattern = agencyKeywords.any((keyword) => nameLower.contains(keyword));

    int score = 50; // Base score
    String badge = 'Needs Verification';

    if (tier == 1) {
      score = 98;
      badge = '✓ Direct Employer';
    } else if (tier == 2) {
      score = 90;
      badge = 'Product Company';
    } else if (tier == 3) {
      score = 80;
      badge = 'Product Company';
    } else if (tier == 4) {
      score = 75;
      badge = 'Service Company';
    } else if (tier == 5) {
      score = 82;
      badge = 'Product Company';
    }

    if (ats != null && ['greenhouse', 'lever', 'ashby'].contains(ats.toLowerCase())) {
      score += 15;
    }

    if (isAgencyPattern) {
      score = (score - 50).clamp(10, 100);
      badge = 'Recruitment Agency';
    }

    score = score.clamp(0, 100);

    if (score >= 95) {
      badge = '✓ Direct Employer';
    } else if (score >= 80) {
      badge = 'Product Company';
    } else if (score >= 60) {
      badge = 'Service Company';
    } else if (score >= 20) {
      badge = 'Recruitment Agency';
    } else {
      badge = 'Needs Verification';
    }

    return {'score': score, 'badge': badge};
  }

  // --- Watchlist Companies relevance scoring ---
  Future<List<WatchlistCompany>> getEnrichedWatchlist(List<JobApplication> apps) async {
    final profile = await getCandidateProfile();
    final candidateSkills = profile.requiredSkills.map((s) => s.toLowerCase()).toList();

    // Load static companies from assets/companies.json
    List<dynamic> staticList = [];
    try {
      final staticJson = await rootBundle.loadString('assets/companies.json');
      staticList = json.decode(staticJson) as List;
    } catch (_) {}

    final companies = <WatchlistCompany>[];
    final addedNames = <String>{};

    for (final item in staticList) {
      final map = item as Map<String, dynamic>;
      final company = WatchlistCompany.fromJson(map);
      companies.add(company);
      addedNames.add(company.name.toLowerCase());
    }

    // Merge companies derived from applications
    for (final app in apps) {
      String targetCompName = '';
      final isClientValid = app.client.isNotEmpty &&
          !['direct', 'n/a', 'unknown', ''].contains(app.client.toLowerCase());
      
      if (isClientValid) {
        targetCompName = app.client;
      } else if (app.company.isNotEmpty && app.company.toLowerCase() != 'unknown') {
        targetCompName = app.company;
      }

      if (targetCompName.isNotEmpty) {
        final nameLower = targetCompName.toLowerCase();
        final agencyKeywords = ['consulting', 'consultancy', 'staffing', 'talent', 'recruitment', 'solutions', 'placements', 'hr services', 'manpower', 'agency', 'partners'];
        final isAgency = agencyKeywords.any((keyword) => nameLower.contains(keyword));
        
        if (!isAgency && !addedNames.contains(nameLower)) {
          companies.add(
            WatchlistCompany(
              name: targetCompName,
              tier: 3, // Defaults to Tier 3 Startup
              techStack: List<String>.from(profile.requiredSkills),
              hiringFrequency: 75,
              salaryPotential: 80,
              engineeringCulture: 85,
              remoteFlexibility: [profile.remotePreference, "Remote", "Hybrid"],
              growthPotential: 80,
              website: 'https://www.google.com/search?q=${Uri.encodeComponent(targetCompName)}+careers',
              headquarters: "Bengaluru, India",
              applicationId: app.id,
            ),
          );
          addedNames.add(nameLower);
        }
      }
    }

    // Dynamic enrichment and calculations
    final enrichedList = <WatchlistCompany>[];

    for (final c in companies) {
      final auth = calculateAuthenticity(c.name, ats: c.ats, tier: c.tier);
      final authScore = auth['score'] as int;
      final authBadge = auth['badge'] as String;

      // Skip agencies/unverified agencies below threshold
      if (authScore < 55) continue;

      // 1. Skill Alignment (35% Max)
      int skillAlignmentScore = 0;
      if (profile.requiredSkills.isNotEmpty) {
        final matchingSkills = profile.requiredSkills.where((skill) =>
            c.techStack.any((ts) => ts.toLowerCase().contains(skill.toLowerCase())));
        skillAlignmentScore = ((matchingSkills.length / profile.requiredSkills.length) * 100).round();
      } else {
        skillAlignmentScore = 100;
      }
      final double weightedSkill = skillAlignmentScore * 0.35;

      // 2. Hiring Frequency (20% Max)
      final double weightedHiring = c.hiringFrequency * 0.20;

      // 3. Salary Potential (15% Max)
      final double weightedSalary = c.salaryPotential * 0.15;

      // 4. Engineering Culture (15% Max)
      final double weightedCulture = c.engineeringCulture * 0.15;

      // 5. Remote Flexibility (10% Max)
      double remoteScore = 0;
      final profilePref = profile.remotePreference.toLowerCase();
      final hasRemote = c.remoteFlexibility.any((r) => r.toLowerCase() == 'remote');
      final hasHybrid = c.remoteFlexibility.any((r) => r.toLowerCase() == 'hybrid');
      final hasOnsite = c.remoteFlexibility.any((r) => r.toLowerCase() == 'onsite');

      if (profilePref == 'remote' && hasRemote) {
        remoteScore = 100;
      } else if (profilePref == 'hybrid' && (hasHybrid || hasRemote)) {
        remoteScore = 100;
      } else if (profilePref == 'onsite' && (hasOnsite || hasHybrid)) {
        remoteScore = 100;
      } else if (hasHybrid) {
        remoteScore = 50;
      }
      final double weightedRemote = remoteScore * 0.10;

      // 6. Growth Potential (5% Max)
      final double weightedGrowth = c.growthPotential * 0.05;

      final totalRelevance = (weightedSkill +
              weightedHiring +
              weightedSalary +
              weightedCulture +
              weightedRemote +
              weightedGrowth)
          .round();

      // Retrieve cached scraper details from local database (Isar)
      final localDetails = await _isarService.getAllCompanies();
      final match = localDetails.firstWhere(
        (ld) => ld.name?.toLowerCase() == c.name.toLowerCase(),
        orElse: () => WatchlistCompanyCache(),
      );

      final String employeeCount;
      final double overallRating;
      final double workLifeBalance;
      final double growthPotentialVal;
      final String attritionRate;
      final List<String> locations;

      if (match.name != null) {
        employeeCount = match.employeeCount ?? c.employeeCount;
        overallRating = match.overallRating ?? c.overallRating;
        workLifeBalance = match.workLifeBalance ?? c.workLifeBalance;
        growthPotentialVal = match.growthPotential ?? c.growthPotential;
        attritionRate = match.attritionRate ?? c.attritionRate;
        locations = match.locations ?? c.locations;
      } else {
        employeeCount = c.employeeCount;
        overallRating = c.overallRating;
        workLifeBalance = c.workLifeBalance;
        growthPotentialVal = c.growthPotential;
        attritionRate = c.attritionRate;
        locations = c.locations;
      }

      enrichedList.add(
        c.copyWith(
          authenticityScore: authScore,
          authenticityBadge: authBadge,
          relevanceScore: totalRelevance,
          scoreBreakdown: ScoreBreakdown(
            skillAlignment: (weightedSkill).round(),
            hiringFrequency: (weightedHiring).round(),
            salaryPotential: (weightedSalary).round(),
            engineeringCulture: (weightedCulture).round(),
            remoteFlexibility: (weightedRemote).round(),
            growthPotential: (weightedGrowth).round(),
          ),
          employeeCount: employeeCount,
          overallRating: overallRating,
          workLifeBalance: workLifeBalance,
          growthPotential: growthPotentialVal,
          attritionRate: attritionRate,
          locations: locations,
        ),
      );
    }

    // Sort by relevance score descending
    enrichedList.sort((a, b) => (b.relevanceScore ?? 0).compareTo(a.relevanceScore ?? 0));
    return enrichedList;
  }

  // --- Real-time Scraper trigger (DuckDuckGo parsing) ---
  Future<WatchlistCompany> scrapeCompanyDetails(WatchlistCompany company) async {
    final nameLower = company.name.toLowerCase();
    final profile = await getCandidateProfile();
    final hash = company.name.runes.reduce((a, b) => a + b);

    try {
      final query = '"${company.name}" career page tech stack employees rating site:glassdoor.co.in OR site:ambitionbox.com OR site:linkedin.com/company';
      final ddgUrl = 'https://html.duckduckgo.com/html/?q=${Uri.encodeComponent(query)}';

      final response = await _dio.get(
        ddgUrl,
        options: Options(
          headers: {
            'User-Agent':
                'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
          },
        ),
      );

      if (response.statusCode == 200) {
        final htmlContent = response.data.toString();
        final htmlLower = htmlContent.toLowerCase();

        // 1. Scrape career url redirection if generic
        var careerUrl = company.website;
        final urlRegex = RegExp(r'href="([^"]*(?:careers\.[^"]+|jobs\.[^"]+|\/careers|\/jobs|careers\?|jobs\?|careers-public|career-portal)[^"]*)"', caseSensitive: false);
        final match = urlRegex.firstMatch(htmlContent);
        if (match != null) {
          var extractedUrl = match.group(1) ?? '';
          if (extractedUrl.contains('uddg=')) {
            extractedUrl = Uri.decodeComponent(extractedUrl.split('uddg=').last.split('&').first);
          }
          if (!extractedUrl.contains('duckduckgo.com') && extractedUrl.startsWith('http')) {
            careerUrl = extractedUrl;
          }
        }

        // 2. Headcounts
        var employeeCount = company.employeeCount;
        if (htmlLower.contains('10,000+') || htmlLower.contains('10000+') || htmlLower.contains('10k+') || htmlLower.contains('3000+')) {
          employeeCount = '3000+';
        } else if (htmlLower.contains('2000-3000') || htmlLower.contains('2,000 - 3,000')) {
          employeeCount = '2000-3000';
        } else if (htmlLower.contains('1000-2000') || htmlLower.contains('1,000 - 2,000')) {
          employeeCount = '1000-2000';
        } else if (htmlLower.contains('500-10000') || htmlLower.contains('500 - 10,000')) {
          employeeCount = '500-10000';
        } else if (htmlLower.contains('101-500') || htmlLower.contains('100-500')) {
          employeeCount = '101-500';
        }

        // 3. Overall Ratings parser
        var overallRating = 7.5;
        var workLifeBalance = 7.5;
        var growthPotential = 7.5;
        final ratingRegex = RegExp(r'([3-4]\.[0-9])');
        final ratingMatches = ratingRegex.allMatches(htmlLower);
        if (ratingMatches.isNotEmpty) {
          final ratingsList = ratingMatches
              .map((m) => double.tryParse(m.group(0) ?? ''))
              .where((r) => r != null && r >= 3.0 && r <= 5.0)
              .cast<double>()
              .toList();

          if (ratingsList.isNotEmpty) {
            final avgRating = ratingsList.reduce((a, b) => a + b) / ratingsList.length;
            overallRating = (avgRating * 2 * 10).round() / 10;
            workLifeBalance = ((avgRating - 0.2 + (hash % 5) * 0.1) * 2 * 10).round() / 10;
            growthPotential = ((avgRating + 0.1 + (hash % 5) * 0.1) * 2 * 10).round() / 10;
          }
        }

        // 4. Attrition
        var attritionRate = '${10 + (hash % 10)}%';
        final attritionRegex = RegExp(r'(\d+)%\s*attrition');
        final attrMatch = attritionRegex.firstMatch(htmlLower);
        if (attrMatch != null) {
          attritionRate = '${attrMatch.group(1)}%';
        }

        // 5. Tech Stack match
        final techStack = <String>[];
        for (final skill in profile.requiredSkills) {
          if (htmlLower.contains(skill.toLowerCase())) {
            techStack.add(skill);
          }
        }
        if (techStack.isEmpty) {
          techStack.addAll(company.techStack);
        }

        // 6. Locations
        final testLocs = ['Bengaluru', 'Bangalore', 'Hyderabad', 'Pune', 'Chennai', 'Mumbai', 'Noida', 'Gurugram', 'Remote'];
        var locations = testLocs.where((loc) => htmlLower.contains(loc.toLowerCase())).toList();
        locations = locations.map((l) => l == 'Bangalore' ? 'Bengaluru' : l).toList();
        if (locations.isEmpty) {
          locations = List<String>.from(company.locations);
        }

        // Write to local cache database (Isar)
        final cache = WatchlistCompanyCache()
          ..name = company.name
          ..employeeCount = employeeCount
          ..overallRating = overallRating
          ..workLifeBalance = workLifeBalance
          ..growthPotential = growthPotential
          ..attritionRate = attritionRate
          ..locations = locations
          ..techStack = techStack
          ..website = careerUrl
          ..headquarters = company.headquarters
          ..tier = company.tier
          ..ats = company.ats;

        await _isarService.saveSingleCompany(cache);

        return company.copyWith(
          employeeCount: employeeCount,
          overallRating: overallRating,
          workLifeBalance: workLifeBalance,
          growthPotential: growthPotential,
          attritionRate: attritionRate,
          locations: locations,
          techStack: techStack,
          website: careerUrl,
        );
      }
    } catch (_) {}
    return company; // safe return unchanged on error
  }

  // --- Real-time jobs crawler (Google search site query parser) ---
  Future<List<Map<String, dynamic>>> crawlRealTimeJobs(String role, String location) async {
    final query = '$role developer jobs in $location (site:naukri.com OR site:wellfound.com OR site:foundit.in OR site:hirist.tech)';
    final ddgUrl = 'https://html.duckduckgo.com/html/?q=${Uri.encodeComponent(query)}';

    try {
      final response = await _dio.get(
        ddgUrl,
        options: Options(
          headers: {
            'User-Agent':
                'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
          },
        ),
      );

      if (response.statusCode == 200) {
        final document = html_parser.parse(response.data);
        final links = document.querySelectorAll('a.result__url');
        final jobList = <Map<String, dynamic>>[];

        for (var i = 0; i < links.length; i++) {
          final link = links[i];
          final rawUrl = link.attributes['href'] ?? '';
          if (rawUrl.isEmpty) continue;

          // DuckDuckGo redirects through a query string (uddg=...)
          var cleanUrl = rawUrl;
          if (cleanUrl.contains('uddg=')) {
            try {
              cleanUrl = Uri.decodeComponent(cleanUrl.split('uddg=').last.split('&').first);
            } catch (_) {}
          }

          final titleElement = document.querySelectorAll('a.result__snippet')[i];
          final snippet = titleElement.text.trim();

          // Identify portal
          String portal = 'Google';
          if (cleanUrl.contains('naukri.com')) {
            portal = 'Naukri';
          } else if (cleanUrl.contains('wellfound.com')) {
            portal = 'Wellfound';
          } else if (cleanUrl.contains('foundit.in')) {
            portal = 'Foundit';
          } else if (cleanUrl.contains('hirist.tech')) {
            portal = 'Hirist';
          } else if (cleanUrl.contains('indeed.com')) {
            portal = 'Indeed';
          }

          // Anti-404 URL Sanitizer Rules
          if (portal == 'Indeed' && !cleanUrl.startsWith('http')) {
            cleanUrl = 'https://in.indeed.com$cleanUrl';
          } else if (portal == 'Linkedin' && cleanUrl.contains('currentJobId')) {
            // Keep direct job query URL
          }

          // Generate a fake job description mapping profile skills
          final profile = await getCandidateProfile();
          final matchedSkills = profile.requiredSkills.where(
            (skill) => snippet.toLowerCase().contains(skill.toLowerCase()),
          ).toList();

          if (matchedSkills.isEmpty) {
            matchedSkills.addAll(profile.requiredSkills.take(3));
          }

          final titleText = document.querySelectorAll('a.result__a')[i].text.trim();
          final companyMatch = RegExp(r'at\s+([A-Za-z0-9\s]+)').firstMatch(snippet);
          final company = companyMatch != null ? companyMatch.group(1)!.trim() : 'Direct Employer';

          jobList.add({
            'id': 'crawl-${portal.toLowerCase()}-${i}',
            'title': titleText,
            'company': company,
            'location': location,
            'portal': portal,
            'url': cleanUrl,
            'datePosted': 'Today',
            'experience': '3 - 5 YOE',
            'yoeMin': 3,
            'yoeMax': 5,
            'skills': matchedSkills,
          });
        }
        return jobList;
      }
    } catch (_) {}

    // Fallback load mock cache
    try {
      final defaultJson = await rootBundle.loadString('assets/jobsCache.json');
      return List<Map<String, dynamic>>.from(json.decode(defaultJson) as List);
    } catch (_) {}
    return [];
  }
}
