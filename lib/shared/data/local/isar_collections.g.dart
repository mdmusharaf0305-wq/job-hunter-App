// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_collections.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetJobApplicationCacheCollection on Isar {
  IsarCollection<JobApplicationCache> get jobApplicationCaches =>
      this.collection();
}

const JobApplicationCacheSchema = CollectionSchema(
  name: r'JobApplicationCache',
  id: -4795916143009098495,
  properties: {
    r'applicationUrl': PropertySchema(
      id: 0,
      name: r'applicationUrl',
      type: IsarType.string,
    ),
    r'callStatus': PropertySchema(
      id: 1,
      name: r'callStatus',
      type: IsarType.string,
    ),
    r'client': PropertySchema(
      id: 2,
      name: r'client',
      type: IsarType.string,
    ),
    r'company': PropertySchema(
      id: 3,
      name: r'company',
      type: IsarType.string,
    ),
    r'companySize': PropertySchema(
      id: 4,
      name: r'companySize',
      type: IsarType.string,
    ),
    r'companyType': PropertySchema(
      id: 5,
      name: r'companyType',
      type: IsarType.string,
    ),
    r'employmentType': PropertySchema(
      id: 6,
      name: r'employmentType',
      type: IsarType.string,
    ),
    r'followupChannel': PropertySchema(
      id: 7,
      name: r'followupChannel',
      type: IsarType.string,
    ),
    r'interviewMode': PropertySchema(
      id: 8,
      name: r'interviewMode',
      type: IsarType.string,
    ),
    r'interviewRounds': PropertySchema(
      id: 9,
      name: r'interviewRounds',
      type: IsarType.string,
    ),
    r'lastContactedDate': PropertySchema(
      id: 10,
      name: r'lastContactedDate',
      type: IsarType.string,
    ),
    r'lastUpdated': PropertySchema(
      id: 11,
      name: r'lastUpdated',
      type: IsarType.string,
    ),
    r'location': PropertySchema(
      id: 12,
      name: r'location',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(
      id: 13,
      name: r'notes',
      type: IsarType.string,
    ),
    r'notionId': PropertySchema(
      id: 14,
      name: r'notionId',
      type: IsarType.string,
    ),
    r'priority': PropertySchema(
      id: 15,
      name: r'priority',
      type: IsarType.string,
    ),
    r'receivedCallOn': PropertySchema(
      id: 16,
      name: r'receivedCallOn',
      type: IsarType.string,
    ),
    r'recruiterCompany': PropertySchema(
      id: 17,
      name: r'recruiterCompany',
      type: IsarType.string,
    ),
    r'recruiterEmail': PropertySchema(
      id: 18,
      name: r'recruiterEmail',
      type: IsarType.string,
    ),
    r'recruiterLinkedin': PropertySchema(
      id: 19,
      name: r'recruiterLinkedin',
      type: IsarType.string,
    ),
    r'recruiterName': PropertySchema(
      id: 20,
      name: r'recruiterName',
      type: IsarType.string,
    ),
    r'recruiterPhone': PropertySchema(
      id: 21,
      name: r'recruiterPhone',
      type: IsarType.string,
    ),
    r'relatedTimelineId': PropertySchema(
      id: 22,
      name: r'relatedTimelineId',
      type: IsarType.string,
    ),
    r'resumeSent': PropertySchema(
      id: 23,
      name: r'resumeSent',
      type: IsarType.bool,
    ),
    r'resumeSentOn': PropertySchema(
      id: 24,
      name: r'resumeSentOn',
      type: IsarType.string,
    ),
    r'role': PropertySchema(
      id: 25,
      name: r'role',
      type: IsarType.string,
    ),
    r'roundPlan': PropertySchema(
      id: 26,
      name: r'roundPlan',
      type: IsarType.string,
    ),
    r'salary': PropertySchema(
      id: 27,
      name: r'salary',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 28,
      name: r'status',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 29,
      name: r'type',
      type: IsarType.string,
    ),
    r'workMode': PropertySchema(
      id: 30,
      name: r'workMode',
      type: IsarType.string,
    )
  },
  estimateSize: _jobApplicationCacheEstimateSize,
  serialize: _jobApplicationCacheSerialize,
  deserialize: _jobApplicationCacheDeserialize,
  deserializeProp: _jobApplicationCacheDeserializeProp,
  idName: r'id',
  indexes: {
    r'notionId': IndexSchema(
      id: -4908929967007327399,
      name: r'notionId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'notionId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _jobApplicationCacheGetId,
  getLinks: _jobApplicationCacheGetLinks,
  attach: _jobApplicationCacheAttach,
  version: '3.1.0+1',
);

int _jobApplicationCacheEstimateSize(
  JobApplicationCache object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.applicationUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.callStatus;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.client.length * 3;
  bytesCount += 3 + object.company.length * 3;
  {
    final value = object.companySize;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.companyType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.employmentType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.followupChannel;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.interviewMode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.interviewRounds;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lastContactedDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.lastUpdated.length * 3;
  {
    final value = object.location;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.notionId.length * 3;
  {
    final value = object.priority;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.receivedCallOn;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.recruiterCompany;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.recruiterEmail;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.recruiterLinkedin;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.recruiterName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.recruiterPhone;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.relatedTimelineId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.resumeSentOn;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.role.length * 3;
  {
    final value = object.roundPlan;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.salary;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.status.length * 3;
  bytesCount += 3 + object.type.length * 3;
  {
    final value = object.workMode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _jobApplicationCacheSerialize(
  JobApplicationCache object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.applicationUrl);
  writer.writeString(offsets[1], object.callStatus);
  writer.writeString(offsets[2], object.client);
  writer.writeString(offsets[3], object.company);
  writer.writeString(offsets[4], object.companySize);
  writer.writeString(offsets[5], object.companyType);
  writer.writeString(offsets[6], object.employmentType);
  writer.writeString(offsets[7], object.followupChannel);
  writer.writeString(offsets[8], object.interviewMode);
  writer.writeString(offsets[9], object.interviewRounds);
  writer.writeString(offsets[10], object.lastContactedDate);
  writer.writeString(offsets[11], object.lastUpdated);
  writer.writeString(offsets[12], object.location);
  writer.writeString(offsets[13], object.notes);
  writer.writeString(offsets[14], object.notionId);
  writer.writeString(offsets[15], object.priority);
  writer.writeString(offsets[16], object.receivedCallOn);
  writer.writeString(offsets[17], object.recruiterCompany);
  writer.writeString(offsets[18], object.recruiterEmail);
  writer.writeString(offsets[19], object.recruiterLinkedin);
  writer.writeString(offsets[20], object.recruiterName);
  writer.writeString(offsets[21], object.recruiterPhone);
  writer.writeString(offsets[22], object.relatedTimelineId);
  writer.writeBool(offsets[23], object.resumeSent);
  writer.writeString(offsets[24], object.resumeSentOn);
  writer.writeString(offsets[25], object.role);
  writer.writeString(offsets[26], object.roundPlan);
  writer.writeString(offsets[27], object.salary);
  writer.writeString(offsets[28], object.status);
  writer.writeString(offsets[29], object.type);
  writer.writeString(offsets[30], object.workMode);
}

JobApplicationCache _jobApplicationCacheDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = JobApplicationCache();
  object.applicationUrl = reader.readStringOrNull(offsets[0]);
  object.callStatus = reader.readStringOrNull(offsets[1]);
  object.client = reader.readString(offsets[2]);
  object.company = reader.readString(offsets[3]);
  object.companySize = reader.readStringOrNull(offsets[4]);
  object.companyType = reader.readStringOrNull(offsets[5]);
  object.employmentType = reader.readStringOrNull(offsets[6]);
  object.followupChannel = reader.readStringOrNull(offsets[7]);
  object.id = id;
  object.interviewMode = reader.readStringOrNull(offsets[8]);
  object.interviewRounds = reader.readStringOrNull(offsets[9]);
  object.lastContactedDate = reader.readStringOrNull(offsets[10]);
  object.lastUpdated = reader.readString(offsets[11]);
  object.location = reader.readStringOrNull(offsets[12]);
  object.notes = reader.readStringOrNull(offsets[13]);
  object.notionId = reader.readString(offsets[14]);
  object.priority = reader.readStringOrNull(offsets[15]);
  object.receivedCallOn = reader.readStringOrNull(offsets[16]);
  object.recruiterCompany = reader.readStringOrNull(offsets[17]);
  object.recruiterEmail = reader.readStringOrNull(offsets[18]);
  object.recruiterLinkedin = reader.readStringOrNull(offsets[19]);
  object.recruiterName = reader.readStringOrNull(offsets[20]);
  object.recruiterPhone = reader.readStringOrNull(offsets[21]);
  object.relatedTimelineId = reader.readStringOrNull(offsets[22]);
  object.resumeSent = reader.readBool(offsets[23]);
  object.resumeSentOn = reader.readStringOrNull(offsets[24]);
  object.role = reader.readString(offsets[25]);
  object.roundPlan = reader.readStringOrNull(offsets[26]);
  object.salary = reader.readStringOrNull(offsets[27]);
  object.status = reader.readString(offsets[28]);
  object.type = reader.readString(offsets[29]);
  object.workMode = reader.readStringOrNull(offsets[30]);
  return object;
}

P _jobApplicationCacheDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    case 21:
      return (reader.readStringOrNull(offset)) as P;
    case 22:
      return (reader.readStringOrNull(offset)) as P;
    case 23:
      return (reader.readBool(offset)) as P;
    case 24:
      return (reader.readStringOrNull(offset)) as P;
    case 25:
      return (reader.readString(offset)) as P;
    case 26:
      return (reader.readStringOrNull(offset)) as P;
    case 27:
      return (reader.readStringOrNull(offset)) as P;
    case 28:
      return (reader.readString(offset)) as P;
    case 29:
      return (reader.readString(offset)) as P;
    case 30:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _jobApplicationCacheGetId(JobApplicationCache object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _jobApplicationCacheGetLinks(
    JobApplicationCache object) {
  return [];
}

void _jobApplicationCacheAttach(
    IsarCollection<dynamic> col, Id id, JobApplicationCache object) {
  object.id = id;
}

extension JobApplicationCacheByIndex on IsarCollection<JobApplicationCache> {
  Future<JobApplicationCache?> getByNotionId(String notionId) {
    return getByIndex(r'notionId', [notionId]);
  }

  JobApplicationCache? getByNotionIdSync(String notionId) {
    return getByIndexSync(r'notionId', [notionId]);
  }

  Future<bool> deleteByNotionId(String notionId) {
    return deleteByIndex(r'notionId', [notionId]);
  }

  bool deleteByNotionIdSync(String notionId) {
    return deleteByIndexSync(r'notionId', [notionId]);
  }

  Future<List<JobApplicationCache?>> getAllByNotionId(
      List<String> notionIdValues) {
    final values = notionIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'notionId', values);
  }

  List<JobApplicationCache?> getAllByNotionIdSync(List<String> notionIdValues) {
    final values = notionIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'notionId', values);
  }

  Future<int> deleteAllByNotionId(List<String> notionIdValues) {
    final values = notionIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'notionId', values);
  }

  int deleteAllByNotionIdSync(List<String> notionIdValues) {
    final values = notionIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'notionId', values);
  }

  Future<Id> putByNotionId(JobApplicationCache object) {
    return putByIndex(r'notionId', object);
  }

  Id putByNotionIdSync(JobApplicationCache object, {bool saveLinks = true}) {
    return putByIndexSync(r'notionId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByNotionId(List<JobApplicationCache> objects) {
    return putAllByIndex(r'notionId', objects);
  }

  List<Id> putAllByNotionIdSync(List<JobApplicationCache> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'notionId', objects, saveLinks: saveLinks);
  }
}

extension JobApplicationCacheQueryWhereSort
    on QueryBuilder<JobApplicationCache, JobApplicationCache, QWhere> {
  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension JobApplicationCacheQueryWhere
    on QueryBuilder<JobApplicationCache, JobApplicationCache, QWhereClause> {
  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterWhereClause>
      notionIdEqualTo(String notionId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'notionId',
        value: [notionId],
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterWhereClause>
      notionIdNotEqualTo(String notionId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'notionId',
              lower: [],
              upper: [notionId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'notionId',
              lower: [notionId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'notionId',
              lower: [notionId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'notionId',
              lower: [],
              upper: [notionId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension JobApplicationCacheQueryFilter on QueryBuilder<JobApplicationCache,
    JobApplicationCache, QFilterCondition> {
  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      applicationUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'applicationUrl',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      applicationUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'applicationUrl',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      applicationUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'applicationUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      applicationUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'applicationUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      applicationUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'applicationUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      applicationUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'applicationUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      applicationUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'applicationUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      applicationUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'applicationUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      applicationUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'applicationUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      applicationUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'applicationUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      applicationUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'applicationUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      applicationUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'applicationUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      callStatusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'callStatus',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      callStatusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'callStatus',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      callStatusEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'callStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      callStatusGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'callStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      callStatusLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'callStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      callStatusBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'callStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      callStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'callStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      callStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'callStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      callStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'callStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      callStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'callStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      callStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'callStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      callStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'callStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      clientEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'client',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      clientGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'client',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      clientLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'client',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      clientBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'client',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      clientStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'client',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      clientEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'client',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      clientContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'client',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      clientMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'client',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      clientIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'client',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      clientIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'client',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'company',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'company',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'company',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'company',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'company',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'company',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'company',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'company',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'company',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'company',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companySizeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'companySize',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companySizeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'companySize',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companySizeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companySize',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companySizeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'companySize',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companySizeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'companySize',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companySizeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'companySize',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companySizeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'companySize',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companySizeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'companySize',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companySizeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'companySize',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companySizeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'companySize',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companySizeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companySize',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companySizeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'companySize',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companyTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'companyType',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companyTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'companyType',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companyTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companyTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'companyType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companyTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'companyType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companyTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'companyType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companyTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'companyType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companyTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'companyType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companyTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'companyType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companyTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'companyType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companyTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyType',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      companyTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'companyType',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      employmentTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'employmentType',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      employmentTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'employmentType',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      employmentTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      employmentTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'employmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      employmentTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'employmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      employmentTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'employmentType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      employmentTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'employmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      employmentTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'employmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      employmentTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'employmentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      employmentTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'employmentType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      employmentTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employmentType',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      employmentTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'employmentType',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      followupChannelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'followupChannel',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      followupChannelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'followupChannel',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      followupChannelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'followupChannel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      followupChannelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'followupChannel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      followupChannelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'followupChannel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      followupChannelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'followupChannel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      followupChannelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'followupChannel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      followupChannelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'followupChannel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      followupChannelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'followupChannel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      followupChannelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'followupChannel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      followupChannelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'followupChannel',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      followupChannelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'followupChannel',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewModeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'interviewMode',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewModeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'interviewMode',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewModeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interviewMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewModeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'interviewMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewModeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'interviewMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewModeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'interviewMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewModeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'interviewMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewModeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'interviewMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewModeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'interviewMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewModeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'interviewMode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewModeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interviewMode',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewModeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'interviewMode',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewRoundsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'interviewRounds',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewRoundsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'interviewRounds',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewRoundsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interviewRounds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewRoundsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'interviewRounds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewRoundsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'interviewRounds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewRoundsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'interviewRounds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewRoundsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'interviewRounds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewRoundsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'interviewRounds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewRoundsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'interviewRounds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewRoundsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'interviewRounds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewRoundsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'interviewRounds',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      interviewRoundsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'interviewRounds',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      lastContactedDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastContactedDate',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      lastContactedDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastContactedDate',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      lastContactedDateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastContactedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      lastContactedDateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastContactedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      lastContactedDateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastContactedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      lastContactedDateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastContactedDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      lastContactedDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastContactedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      lastContactedDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastContactedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      lastContactedDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastContactedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      lastContactedDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastContactedDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      lastContactedDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastContactedDate',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      lastContactedDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastContactedDate',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      lastUpdatedEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      lastUpdatedGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUpdated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      lastUpdatedLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUpdated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      lastUpdatedBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUpdated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      lastUpdatedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastUpdated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      lastUpdatedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastUpdated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      lastUpdatedContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastUpdated',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      lastUpdatedMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastUpdated',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      lastUpdatedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdated',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      lastUpdatedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastUpdated',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      locationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'location',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      locationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'location',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      locationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      locationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      locationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      locationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'location',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      locationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      locationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      locationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      locationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'location',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      locationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'location',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      locationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'location',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      notionIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      notionIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      notionIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      notionIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      notionIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      notionIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      notionIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      notionIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notionId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      notionIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notionId',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      notionIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notionId',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      priorityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'priority',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      priorityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'priority',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      priorityEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'priority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      priorityGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'priority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      priorityLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'priority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      priorityBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'priority',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      priorityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'priority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      priorityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'priority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      priorityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'priority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      priorityMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'priority',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      priorityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'priority',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      priorityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'priority',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      receivedCallOnIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'receivedCallOn',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      receivedCallOnIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'receivedCallOn',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      receivedCallOnEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'receivedCallOn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      receivedCallOnGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'receivedCallOn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      receivedCallOnLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'receivedCallOn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      receivedCallOnBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'receivedCallOn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      receivedCallOnStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'receivedCallOn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      receivedCallOnEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'receivedCallOn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      receivedCallOnContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'receivedCallOn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      receivedCallOnMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'receivedCallOn',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      receivedCallOnIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'receivedCallOn',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      receivedCallOnIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'receivedCallOn',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterCompanyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recruiterCompany',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterCompanyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recruiterCompany',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterCompanyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recruiterCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterCompanyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recruiterCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterCompanyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recruiterCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterCompanyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recruiterCompany',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterCompanyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'recruiterCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterCompanyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'recruiterCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterCompanyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'recruiterCompany',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterCompanyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'recruiterCompany',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterCompanyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recruiterCompany',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterCompanyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'recruiterCompany',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterEmailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recruiterEmail',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterEmailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recruiterEmail',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterEmailEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recruiterEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterEmailGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recruiterEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterEmailLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recruiterEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterEmailBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recruiterEmail',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterEmailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'recruiterEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterEmailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'recruiterEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterEmailContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'recruiterEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterEmailMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'recruiterEmail',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterEmailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recruiterEmail',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterEmailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'recruiterEmail',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterLinkedinIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recruiterLinkedin',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterLinkedinIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recruiterLinkedin',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterLinkedinEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recruiterLinkedin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterLinkedinGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recruiterLinkedin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterLinkedinLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recruiterLinkedin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterLinkedinBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recruiterLinkedin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterLinkedinStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'recruiterLinkedin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterLinkedinEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'recruiterLinkedin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterLinkedinContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'recruiterLinkedin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterLinkedinMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'recruiterLinkedin',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterLinkedinIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recruiterLinkedin',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterLinkedinIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'recruiterLinkedin',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recruiterName',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recruiterName',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recruiterName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recruiterName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recruiterName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recruiterName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'recruiterName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'recruiterName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'recruiterName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'recruiterName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recruiterName',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'recruiterName',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterPhoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recruiterPhone',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterPhoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recruiterPhone',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterPhoneEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recruiterPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterPhoneGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recruiterPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterPhoneLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recruiterPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterPhoneBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recruiterPhone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterPhoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'recruiterPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterPhoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'recruiterPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterPhoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'recruiterPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterPhoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'recruiterPhone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterPhoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recruiterPhone',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      recruiterPhoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'recruiterPhone',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      relatedTimelineIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'relatedTimelineId',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      relatedTimelineIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'relatedTimelineId',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      relatedTimelineIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'relatedTimelineId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      relatedTimelineIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'relatedTimelineId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      relatedTimelineIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'relatedTimelineId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      relatedTimelineIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'relatedTimelineId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      relatedTimelineIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'relatedTimelineId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      relatedTimelineIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'relatedTimelineId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      relatedTimelineIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'relatedTimelineId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      relatedTimelineIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'relatedTimelineId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      relatedTimelineIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'relatedTimelineId',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      relatedTimelineIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'relatedTimelineId',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      resumeSentEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'resumeSent',
        value: value,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      resumeSentOnIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'resumeSentOn',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      resumeSentOnIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'resumeSentOn',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      resumeSentOnEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'resumeSentOn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      resumeSentOnGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'resumeSentOn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      resumeSentOnLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'resumeSentOn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      resumeSentOnBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'resumeSentOn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      resumeSentOnStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'resumeSentOn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      resumeSentOnEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'resumeSentOn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      resumeSentOnContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'resumeSentOn',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      resumeSentOnMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'resumeSentOn',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      resumeSentOnIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'resumeSentOn',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      resumeSentOnIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'resumeSentOn',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      roleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      roleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      roleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      roleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'role',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      roleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      roleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      roleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'role',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      roleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'role',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      roleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'role',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      roleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'role',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      roundPlanIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roundPlan',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      roundPlanIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roundPlan',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      roundPlanEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roundPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      roundPlanGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'roundPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      roundPlanLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'roundPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      roundPlanBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'roundPlan',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      roundPlanStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'roundPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      roundPlanEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'roundPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      roundPlanContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'roundPlan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      roundPlanMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'roundPlan',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      roundPlanIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roundPlan',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      roundPlanIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'roundPlan',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      salaryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'salary',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      salaryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'salary',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      salaryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'salary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      salaryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'salary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      salaryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'salary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      salaryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'salary',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      salaryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'salary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      salaryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'salary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      salaryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'salary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      salaryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'salary',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      salaryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'salary',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      salaryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'salary',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      workModeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'workMode',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      workModeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'workMode',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      workModeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'workMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      workModeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'workMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      workModeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'workMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      workModeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'workMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      workModeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'workMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      workModeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'workMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      workModeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'workMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      workModeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'workMode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      workModeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'workMode',
        value: '',
      ));
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterFilterCondition>
      workModeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'workMode',
        value: '',
      ));
    });
  }
}

extension JobApplicationCacheQueryObject on QueryBuilder<JobApplicationCache,
    JobApplicationCache, QFilterCondition> {}

extension JobApplicationCacheQueryLinks on QueryBuilder<JobApplicationCache,
    JobApplicationCache, QFilterCondition> {}

extension JobApplicationCacheQuerySortBy
    on QueryBuilder<JobApplicationCache, JobApplicationCache, QSortBy> {
  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByApplicationUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationUrl', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByApplicationUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationUrl', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByCallStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callStatus', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByCallStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callStatus', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByClient() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'client', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByClientDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'client', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByCompany() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'company', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByCompanyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'company', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByCompanySize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companySize', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByCompanySizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companySize', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByCompanyType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyType', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByCompanyTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyType', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByEmploymentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employmentType', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByEmploymentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employmentType', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByFollowupChannel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'followupChannel', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByFollowupChannelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'followupChannel', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByInterviewMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interviewMode', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByInterviewModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interviewMode', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByInterviewRounds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interviewRounds', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByInterviewRoundsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interviewRounds', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByLastContactedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastContactedDate', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByLastContactedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastContactedDate', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByNotionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notionId', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByNotionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notionId', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByReceivedCallOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedCallOn', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByReceivedCallOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedCallOn', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByRecruiterCompany() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recruiterCompany', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByRecruiterCompanyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recruiterCompany', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByRecruiterEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recruiterEmail', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByRecruiterEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recruiterEmail', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByRecruiterLinkedin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recruiterLinkedin', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByRecruiterLinkedinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recruiterLinkedin', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByRecruiterName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recruiterName', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByRecruiterNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recruiterName', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByRecruiterPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recruiterPhone', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByRecruiterPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recruiterPhone', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByRelatedTimelineId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedTimelineId', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByRelatedTimelineIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedTimelineId', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByResumeSent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resumeSent', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByResumeSentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resumeSent', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByResumeSentOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resumeSentOn', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByResumeSentOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resumeSentOn', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByRoleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByRoundPlan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roundPlan', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByRoundPlanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roundPlan', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortBySalary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salary', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortBySalaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salary', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByWorkMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workMode', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      sortByWorkModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workMode', Sort.desc);
    });
  }
}

extension JobApplicationCacheQuerySortThenBy
    on QueryBuilder<JobApplicationCache, JobApplicationCache, QSortThenBy> {
  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByApplicationUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationUrl', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByApplicationUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationUrl', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByCallStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callStatus', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByCallStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'callStatus', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByClient() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'client', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByClientDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'client', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByCompany() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'company', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByCompanyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'company', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByCompanySize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companySize', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByCompanySizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companySize', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByCompanyType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyType', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByCompanyTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyType', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByEmploymentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employmentType', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByEmploymentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employmentType', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByFollowupChannel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'followupChannel', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByFollowupChannelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'followupChannel', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByInterviewMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interviewMode', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByInterviewModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interviewMode', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByInterviewRounds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interviewRounds', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByInterviewRoundsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'interviewRounds', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByLastContactedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastContactedDate', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByLastContactedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastContactedDate', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByNotionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notionId', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByNotionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notionId', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByReceivedCallOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedCallOn', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByReceivedCallOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedCallOn', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByRecruiterCompany() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recruiterCompany', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByRecruiterCompanyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recruiterCompany', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByRecruiterEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recruiterEmail', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByRecruiterEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recruiterEmail', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByRecruiterLinkedin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recruiterLinkedin', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByRecruiterLinkedinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recruiterLinkedin', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByRecruiterName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recruiterName', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByRecruiterNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recruiterName', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByRecruiterPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recruiterPhone', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByRecruiterPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recruiterPhone', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByRelatedTimelineId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedTimelineId', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByRelatedTimelineIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'relatedTimelineId', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByResumeSent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resumeSent', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByResumeSentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resumeSent', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByResumeSentOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resumeSentOn', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByResumeSentOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resumeSentOn', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByRoleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'role', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByRoundPlan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roundPlan', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByRoundPlanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roundPlan', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenBySalary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salary', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenBySalaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salary', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByWorkMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workMode', Sort.asc);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QAfterSortBy>
      thenByWorkModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workMode', Sort.desc);
    });
  }
}

extension JobApplicationCacheQueryWhereDistinct
    on QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct> {
  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByApplicationUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'applicationUrl',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByCallStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'callStatus', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByClient({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'client', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByCompany({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'company', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByCompanySize({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'companySize', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByCompanyType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'companyType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByEmploymentType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'employmentType',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByFollowupChannel({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'followupChannel',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByInterviewMode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'interviewMode',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByInterviewRounds({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'interviewRounds',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByLastContactedDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastContactedDate',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByLastUpdated({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdated', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByLocation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'location', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByNotes({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByNotionId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notionId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByPriority({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'priority', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByReceivedCallOn({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'receivedCallOn',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByRecruiterCompany({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recruiterCompany',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByRecruiterEmail({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recruiterEmail',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByRecruiterLinkedin({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recruiterLinkedin',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByRecruiterName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recruiterName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByRecruiterPhone({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recruiterPhone',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByRelatedTimelineId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'relatedTimelineId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByResumeSent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'resumeSent');
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByResumeSentOn({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'resumeSentOn', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByRole({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'role', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByRoundPlan({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roundPlan', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctBySalary({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'salary', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JobApplicationCache, JobApplicationCache, QDistinct>
      distinctByWorkMode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workMode', caseSensitive: caseSensitive);
    });
  }
}

extension JobApplicationCacheQueryProperty
    on QueryBuilder<JobApplicationCache, JobApplicationCache, QQueryProperty> {
  QueryBuilder<JobApplicationCache, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<JobApplicationCache, String?, QQueryOperations>
      applicationUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'applicationUrl');
    });
  }

  QueryBuilder<JobApplicationCache, String?, QQueryOperations>
      callStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'callStatus');
    });
  }

  QueryBuilder<JobApplicationCache, String, QQueryOperations> clientProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'client');
    });
  }

  QueryBuilder<JobApplicationCache, String, QQueryOperations>
      companyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'company');
    });
  }

  QueryBuilder<JobApplicationCache, String?, QQueryOperations>
      companySizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'companySize');
    });
  }

  QueryBuilder<JobApplicationCache, String?, QQueryOperations>
      companyTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'companyType');
    });
  }

  QueryBuilder<JobApplicationCache, String?, QQueryOperations>
      employmentTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'employmentType');
    });
  }

  QueryBuilder<JobApplicationCache, String?, QQueryOperations>
      followupChannelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'followupChannel');
    });
  }

  QueryBuilder<JobApplicationCache, String?, QQueryOperations>
      interviewModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'interviewMode');
    });
  }

  QueryBuilder<JobApplicationCache, String?, QQueryOperations>
      interviewRoundsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'interviewRounds');
    });
  }

  QueryBuilder<JobApplicationCache, String?, QQueryOperations>
      lastContactedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastContactedDate');
    });
  }

  QueryBuilder<JobApplicationCache, String, QQueryOperations>
      lastUpdatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdated');
    });
  }

  QueryBuilder<JobApplicationCache, String?, QQueryOperations>
      locationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'location');
    });
  }

  QueryBuilder<JobApplicationCache, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<JobApplicationCache, String, QQueryOperations>
      notionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notionId');
    });
  }

  QueryBuilder<JobApplicationCache, String?, QQueryOperations>
      priorityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'priority');
    });
  }

  QueryBuilder<JobApplicationCache, String?, QQueryOperations>
      receivedCallOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'receivedCallOn');
    });
  }

  QueryBuilder<JobApplicationCache, String?, QQueryOperations>
      recruiterCompanyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recruiterCompany');
    });
  }

  QueryBuilder<JobApplicationCache, String?, QQueryOperations>
      recruiterEmailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recruiterEmail');
    });
  }

  QueryBuilder<JobApplicationCache, String?, QQueryOperations>
      recruiterLinkedinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recruiterLinkedin');
    });
  }

  QueryBuilder<JobApplicationCache, String?, QQueryOperations>
      recruiterNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recruiterName');
    });
  }

  QueryBuilder<JobApplicationCache, String?, QQueryOperations>
      recruiterPhoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recruiterPhone');
    });
  }

  QueryBuilder<JobApplicationCache, String?, QQueryOperations>
      relatedTimelineIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'relatedTimelineId');
    });
  }

  QueryBuilder<JobApplicationCache, bool, QQueryOperations>
      resumeSentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'resumeSent');
    });
  }

  QueryBuilder<JobApplicationCache, String?, QQueryOperations>
      resumeSentOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'resumeSentOn');
    });
  }

  QueryBuilder<JobApplicationCache, String, QQueryOperations> roleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'role');
    });
  }

  QueryBuilder<JobApplicationCache, String?, QQueryOperations>
      roundPlanProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roundPlan');
    });
  }

  QueryBuilder<JobApplicationCache, String?, QQueryOperations>
      salaryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'salary');
    });
  }

  QueryBuilder<JobApplicationCache, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<JobApplicationCache, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<JobApplicationCache, String?, QQueryOperations>
      workModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workMode');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTimelineEventCacheCollection on Isar {
  IsarCollection<TimelineEventCache> get timelineEventCaches =>
      this.collection();
}

const TimelineEventCacheSchema = CollectionSchema(
  name: r'TimelineEventCache',
  id: 7049917515229227651,
  properties: {
    r'category': PropertySchema(
      id: 0,
      name: r'category',
      type: IsarType.string,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(
      id: 2,
      name: r'notes',
      type: IsarType.string,
    ),
    r'notionId': PropertySchema(
      id: 3,
      name: r'notionId',
      type: IsarType.string,
    ),
    r'opportunity': PropertySchema(
      id: 4,
      name: r'opportunity',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 5,
      name: r'title',
      type: IsarType.string,
    ),
    r'virtualMode': PropertySchema(
      id: 6,
      name: r'virtualMode',
      type: IsarType.string,
    )
  },
  estimateSize: _timelineEventCacheEstimateSize,
  serialize: _timelineEventCacheSerialize,
  deserialize: _timelineEventCacheDeserialize,
  deserializeProp: _timelineEventCacheDeserializeProp,
  idName: r'id',
  indexes: {
    r'notionId': IndexSchema(
      id: -4908929967007327399,
      name: r'notionId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'notionId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _timelineEventCacheGetId,
  getLinks: _timelineEventCacheGetLinks,
  attach: _timelineEventCacheAttach,
  version: '3.1.0+1',
);

int _timelineEventCacheEstimateSize(
  TimelineEventCache object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.category.length * 3;
  bytesCount += 3 + object.date.length * 3;
  bytesCount += 3 + object.notes.length * 3;
  bytesCount += 3 + object.notionId.length * 3;
  bytesCount += 3 + object.opportunity.length * 3;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.virtualMode.length * 3;
  return bytesCount;
}

void _timelineEventCacheSerialize(
  TimelineEventCache object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.category);
  writer.writeString(offsets[1], object.date);
  writer.writeString(offsets[2], object.notes);
  writer.writeString(offsets[3], object.notionId);
  writer.writeString(offsets[4], object.opportunity);
  writer.writeString(offsets[5], object.title);
  writer.writeString(offsets[6], object.virtualMode);
}

TimelineEventCache _timelineEventCacheDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TimelineEventCache();
  object.category = reader.readString(offsets[0]);
  object.date = reader.readString(offsets[1]);
  object.id = id;
  object.notes = reader.readString(offsets[2]);
  object.notionId = reader.readString(offsets[3]);
  object.opportunity = reader.readString(offsets[4]);
  object.title = reader.readString(offsets[5]);
  object.virtualMode = reader.readString(offsets[6]);
  return object;
}

P _timelineEventCacheDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _timelineEventCacheGetId(TimelineEventCache object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _timelineEventCacheGetLinks(
    TimelineEventCache object) {
  return [];
}

void _timelineEventCacheAttach(
    IsarCollection<dynamic> col, Id id, TimelineEventCache object) {
  object.id = id;
}

extension TimelineEventCacheByIndex on IsarCollection<TimelineEventCache> {
  Future<TimelineEventCache?> getByNotionId(String notionId) {
    return getByIndex(r'notionId', [notionId]);
  }

  TimelineEventCache? getByNotionIdSync(String notionId) {
    return getByIndexSync(r'notionId', [notionId]);
  }

  Future<bool> deleteByNotionId(String notionId) {
    return deleteByIndex(r'notionId', [notionId]);
  }

  bool deleteByNotionIdSync(String notionId) {
    return deleteByIndexSync(r'notionId', [notionId]);
  }

  Future<List<TimelineEventCache?>> getAllByNotionId(
      List<String> notionIdValues) {
    final values = notionIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'notionId', values);
  }

  List<TimelineEventCache?> getAllByNotionIdSync(List<String> notionIdValues) {
    final values = notionIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'notionId', values);
  }

  Future<int> deleteAllByNotionId(List<String> notionIdValues) {
    final values = notionIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'notionId', values);
  }

  int deleteAllByNotionIdSync(List<String> notionIdValues) {
    final values = notionIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'notionId', values);
  }

  Future<Id> putByNotionId(TimelineEventCache object) {
    return putByIndex(r'notionId', object);
  }

  Id putByNotionIdSync(TimelineEventCache object, {bool saveLinks = true}) {
    return putByIndexSync(r'notionId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByNotionId(List<TimelineEventCache> objects) {
    return putAllByIndex(r'notionId', objects);
  }

  List<Id> putAllByNotionIdSync(List<TimelineEventCache> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'notionId', objects, saveLinks: saveLinks);
  }
}

extension TimelineEventCacheQueryWhereSort
    on QueryBuilder<TimelineEventCache, TimelineEventCache, QWhere> {
  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TimelineEventCacheQueryWhere
    on QueryBuilder<TimelineEventCache, TimelineEventCache, QWhereClause> {
  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterWhereClause>
      notionIdEqualTo(String notionId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'notionId',
        value: [notionId],
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterWhereClause>
      notionIdNotEqualTo(String notionId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'notionId',
              lower: [],
              upper: [notionId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'notionId',
              lower: [notionId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'notionId',
              lower: [notionId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'notionId',
              lower: [],
              upper: [notionId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension TimelineEventCacheQueryFilter
    on QueryBuilder<TimelineEventCache, TimelineEventCache, QFilterCondition> {
  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      categoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      categoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      categoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      categoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      dateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      dateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      dateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      dateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      dateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      dateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      dateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      dateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'date',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      dateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: '',
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      dateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'date',
        value: '',
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      notesEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      notesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      notesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      notesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      notionIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      notionIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      notionIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      notionIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      notionIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      notionIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      notionIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      notionIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notionId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      notionIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notionId',
        value: '',
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      notionIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notionId',
        value: '',
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      opportunityEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'opportunity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      opportunityGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'opportunity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      opportunityLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'opportunity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      opportunityBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'opportunity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      opportunityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'opportunity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      opportunityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'opportunity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      opportunityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'opportunity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      opportunityMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'opportunity',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      opportunityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'opportunity',
        value: '',
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      opportunityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'opportunity',
        value: '',
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      virtualModeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'virtualMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      virtualModeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'virtualMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      virtualModeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'virtualMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      virtualModeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'virtualMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      virtualModeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'virtualMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      virtualModeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'virtualMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      virtualModeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'virtualMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      virtualModeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'virtualMode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      virtualModeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'virtualMode',
        value: '',
      ));
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterFilterCondition>
      virtualModeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'virtualMode',
        value: '',
      ));
    });
  }
}

extension TimelineEventCacheQueryObject
    on QueryBuilder<TimelineEventCache, TimelineEventCache, QFilterCondition> {}

extension TimelineEventCacheQueryLinks
    on QueryBuilder<TimelineEventCache, TimelineEventCache, QFilterCondition> {}

extension TimelineEventCacheQuerySortBy
    on QueryBuilder<TimelineEventCache, TimelineEventCache, QSortBy> {
  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      sortByNotionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notionId', Sort.asc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      sortByNotionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notionId', Sort.desc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      sortByOpportunity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'opportunity', Sort.asc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      sortByOpportunityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'opportunity', Sort.desc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      sortByVirtualMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'virtualMode', Sort.asc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      sortByVirtualModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'virtualMode', Sort.desc);
    });
  }
}

extension TimelineEventCacheQuerySortThenBy
    on QueryBuilder<TimelineEventCache, TimelineEventCache, QSortThenBy> {
  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      thenByNotionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notionId', Sort.asc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      thenByNotionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notionId', Sort.desc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      thenByOpportunity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'opportunity', Sort.asc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      thenByOpportunityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'opportunity', Sort.desc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      thenByVirtualMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'virtualMode', Sort.asc);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QAfterSortBy>
      thenByVirtualModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'virtualMode', Sort.desc);
    });
  }
}

extension TimelineEventCacheQueryWhereDistinct
    on QueryBuilder<TimelineEventCache, TimelineEventCache, QDistinct> {
  QueryBuilder<TimelineEventCache, TimelineEventCache, QDistinct>
      distinctByCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QDistinct>
      distinctByDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QDistinct>
      distinctByNotes({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QDistinct>
      distinctByNotionId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notionId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QDistinct>
      distinctByOpportunity({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'opportunity', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QDistinct>
      distinctByTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TimelineEventCache, TimelineEventCache, QDistinct>
      distinctByVirtualMode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'virtualMode', caseSensitive: caseSensitive);
    });
  }
}

extension TimelineEventCacheQueryProperty
    on QueryBuilder<TimelineEventCache, TimelineEventCache, QQueryProperty> {
  QueryBuilder<TimelineEventCache, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TimelineEventCache, String, QQueryOperations>
      categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<TimelineEventCache, String, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<TimelineEventCache, String, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<TimelineEventCache, String, QQueryOperations>
      notionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notionId');
    });
  }

  QueryBuilder<TimelineEventCache, String, QQueryOperations>
      opportunityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'opportunity');
    });
  }

  QueryBuilder<TimelineEventCache, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<TimelineEventCache, String, QQueryOperations>
      virtualModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'virtualMode');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWatchlistCompanyCacheCollection on Isar {
  IsarCollection<WatchlistCompanyCache> get watchlistCompanyCaches =>
      this.collection();
}

const WatchlistCompanyCacheSchema = CollectionSchema(
  name: r'WatchlistCompanyCache',
  id: 2278529408664899395,
  properties: {
    r'ats': PropertySchema(
      id: 0,
      name: r'ats',
      type: IsarType.string,
    ),
    r'attritionRate': PropertySchema(
      id: 1,
      name: r'attritionRate',
      type: IsarType.string,
    ),
    r'employeeCount': PropertySchema(
      id: 2,
      name: r'employeeCount',
      type: IsarType.string,
    ),
    r'engineeringCulture': PropertySchema(
      id: 3,
      name: r'engineeringCulture',
      type: IsarType.double,
    ),
    r'growthPotential': PropertySchema(
      id: 4,
      name: r'growthPotential',
      type: IsarType.double,
    ),
    r'headquarters': PropertySchema(
      id: 5,
      name: r'headquarters',
      type: IsarType.string,
    ),
    r'hiringFrequency': PropertySchema(
      id: 6,
      name: r'hiringFrequency',
      type: IsarType.double,
    ),
    r'locations': PropertySchema(
      id: 7,
      name: r'locations',
      type: IsarType.stringList,
    ),
    r'name': PropertySchema(
      id: 8,
      name: r'name',
      type: IsarType.string,
    ),
    r'overallRating': PropertySchema(
      id: 9,
      name: r'overallRating',
      type: IsarType.double,
    ),
    r'remoteFlexibility': PropertySchema(
      id: 10,
      name: r'remoteFlexibility',
      type: IsarType.stringList,
    ),
    r'salaryPotential': PropertySchema(
      id: 11,
      name: r'salaryPotential',
      type: IsarType.double,
    ),
    r'techStack': PropertySchema(
      id: 12,
      name: r'techStack',
      type: IsarType.stringList,
    ),
    r'tier': PropertySchema(
      id: 13,
      name: r'tier',
      type: IsarType.long,
    ),
    r'website': PropertySchema(
      id: 14,
      name: r'website',
      type: IsarType.string,
    ),
    r'workLifeBalance': PropertySchema(
      id: 15,
      name: r'workLifeBalance',
      type: IsarType.double,
    )
  },
  estimateSize: _watchlistCompanyCacheEstimateSize,
  serialize: _watchlistCompanyCacheSerialize,
  deserialize: _watchlistCompanyCacheDeserialize,
  deserializeProp: _watchlistCompanyCacheDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _watchlistCompanyCacheGetId,
  getLinks: _watchlistCompanyCacheGetLinks,
  attach: _watchlistCompanyCacheAttach,
  version: '3.1.0+1',
);

int _watchlistCompanyCacheEstimateSize(
  WatchlistCompanyCache object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.ats;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.attritionRate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.employeeCount;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.headquarters;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.locations;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.remoteFlexibility;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final list = object.techStack;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final value = object.website;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _watchlistCompanyCacheSerialize(
  WatchlistCompanyCache object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.ats);
  writer.writeString(offsets[1], object.attritionRate);
  writer.writeString(offsets[2], object.employeeCount);
  writer.writeDouble(offsets[3], object.engineeringCulture);
  writer.writeDouble(offsets[4], object.growthPotential);
  writer.writeString(offsets[5], object.headquarters);
  writer.writeDouble(offsets[6], object.hiringFrequency);
  writer.writeStringList(offsets[7], object.locations);
  writer.writeString(offsets[8], object.name);
  writer.writeDouble(offsets[9], object.overallRating);
  writer.writeStringList(offsets[10], object.remoteFlexibility);
  writer.writeDouble(offsets[11], object.salaryPotential);
  writer.writeStringList(offsets[12], object.techStack);
  writer.writeLong(offsets[13], object.tier);
  writer.writeString(offsets[14], object.website);
  writer.writeDouble(offsets[15], object.workLifeBalance);
}

WatchlistCompanyCache _watchlistCompanyCacheDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WatchlistCompanyCache();
  object.ats = reader.readStringOrNull(offsets[0]);
  object.attritionRate = reader.readStringOrNull(offsets[1]);
  object.employeeCount = reader.readStringOrNull(offsets[2]);
  object.engineeringCulture = reader.readDoubleOrNull(offsets[3]);
  object.growthPotential = reader.readDoubleOrNull(offsets[4]);
  object.headquarters = reader.readStringOrNull(offsets[5]);
  object.hiringFrequency = reader.readDoubleOrNull(offsets[6]);
  object.id = id;
  object.locations = reader.readStringList(offsets[7]);
  object.name = reader.readStringOrNull(offsets[8]);
  object.overallRating = reader.readDoubleOrNull(offsets[9]);
  object.remoteFlexibility = reader.readStringList(offsets[10]);
  object.salaryPotential = reader.readDoubleOrNull(offsets[11]);
  object.techStack = reader.readStringList(offsets[12]);
  object.tier = reader.readLongOrNull(offsets[13]);
  object.website = reader.readStringOrNull(offsets[14]);
  object.workLifeBalance = reader.readDoubleOrNull(offsets[15]);
  return object;
}

P _watchlistCompanyCacheDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    case 7:
      return (reader.readStringList(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readDoubleOrNull(offset)) as P;
    case 10:
      return (reader.readStringList(offset)) as P;
    case 11:
      return (reader.readDoubleOrNull(offset)) as P;
    case 12:
      return (reader.readStringList(offset)) as P;
    case 13:
      return (reader.readLongOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _watchlistCompanyCacheGetId(WatchlistCompanyCache object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _watchlistCompanyCacheGetLinks(
    WatchlistCompanyCache object) {
  return [];
}

void _watchlistCompanyCacheAttach(
    IsarCollection<dynamic> col, Id id, WatchlistCompanyCache object) {
  object.id = id;
}

extension WatchlistCompanyCacheByIndex
    on IsarCollection<WatchlistCompanyCache> {
  Future<WatchlistCompanyCache?> getByName(String? name) {
    return getByIndex(r'name', [name]);
  }

  WatchlistCompanyCache? getByNameSync(String? name) {
    return getByIndexSync(r'name', [name]);
  }

  Future<bool> deleteByName(String? name) {
    return deleteByIndex(r'name', [name]);
  }

  bool deleteByNameSync(String? name) {
    return deleteByIndexSync(r'name', [name]);
  }

  Future<List<WatchlistCompanyCache?>> getAllByName(List<String?> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return getAllByIndex(r'name', values);
  }

  List<WatchlistCompanyCache?> getAllByNameSync(List<String?> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'name', values);
  }

  Future<int> deleteAllByName(List<String?> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'name', values);
  }

  int deleteAllByNameSync(List<String?> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'name', values);
  }

  Future<Id> putByName(WatchlistCompanyCache object) {
    return putByIndex(r'name', object);
  }

  Id putByNameSync(WatchlistCompanyCache object, {bool saveLinks = true}) {
    return putByIndexSync(r'name', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByName(List<WatchlistCompanyCache> objects) {
    return putAllByIndex(r'name', objects);
  }

  List<Id> putAllByNameSync(List<WatchlistCompanyCache> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'name', objects, saveLinks: saveLinks);
  }
}

extension WatchlistCompanyCacheQueryWhereSort
    on QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QWhere> {
  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WatchlistCompanyCacheQueryWhere on QueryBuilder<WatchlistCompanyCache,
    WatchlistCompanyCache, QWhereClause> {
  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterWhereClause>
      nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [null],
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterWhereClause>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'name',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterWhereClause>
      nameEqualTo(String? name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterWhereClause>
      nameNotEqualTo(String? name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }
}

extension WatchlistCompanyCacheQueryFilter on QueryBuilder<
    WatchlistCompanyCache, WatchlistCompanyCache, QFilterCondition> {
  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> atsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ats',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> atsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ats',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> atsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ats',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> atsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ats',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> atsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ats',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> atsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ats',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> atsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ats',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> atsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ats',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
          QAfterFilterCondition>
      atsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ats',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
          QAfterFilterCondition>
      atsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ats',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> atsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ats',
        value: '',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> atsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ats',
        value: '',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> attritionRateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'attritionRate',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> attritionRateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'attritionRate',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> attritionRateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'attritionRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> attritionRateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'attritionRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> attritionRateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'attritionRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> attritionRateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'attritionRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> attritionRateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'attritionRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> attritionRateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'attritionRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
          QAfterFilterCondition>
      attritionRateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'attritionRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
          QAfterFilterCondition>
      attritionRateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'attritionRate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> attritionRateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'attritionRate',
        value: '',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> attritionRateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'attritionRate',
        value: '',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> employeeCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'employeeCount',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> employeeCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'employeeCount',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> employeeCountEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> employeeCountGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'employeeCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> employeeCountLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'employeeCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> employeeCountBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'employeeCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> employeeCountStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'employeeCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> employeeCountEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'employeeCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
          QAfterFilterCondition>
      employeeCountContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'employeeCount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
          QAfterFilterCondition>
      employeeCountMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'employeeCount',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> employeeCountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeCount',
        value: '',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> employeeCountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'employeeCount',
        value: '',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> engineeringCultureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'engineeringCulture',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> engineeringCultureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'engineeringCulture',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> engineeringCultureEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'engineeringCulture',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> engineeringCultureGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'engineeringCulture',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> engineeringCultureLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'engineeringCulture',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> engineeringCultureBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'engineeringCulture',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> growthPotentialIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'growthPotential',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> growthPotentialIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'growthPotential',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> growthPotentialEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'growthPotential',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> growthPotentialGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'growthPotential',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> growthPotentialLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'growthPotential',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> growthPotentialBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'growthPotential',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> headquartersIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'headquarters',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> headquartersIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'headquarters',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> headquartersEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'headquarters',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> headquartersGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'headquarters',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> headquartersLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'headquarters',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> headquartersBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'headquarters',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> headquartersStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'headquarters',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> headquartersEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'headquarters',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
          QAfterFilterCondition>
      headquartersContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'headquarters',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
          QAfterFilterCondition>
      headquartersMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'headquarters',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> headquartersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'headquarters',
        value: '',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> headquartersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'headquarters',
        value: '',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> hiringFrequencyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hiringFrequency',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> hiringFrequencyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hiringFrequency',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> hiringFrequencyEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hiringFrequency',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> hiringFrequencyGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hiringFrequency',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> hiringFrequencyLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hiringFrequency',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> hiringFrequencyBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hiringFrequency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> locationsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'locations',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> locationsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'locations',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> locationsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> locationsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'locations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> locationsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'locations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> locationsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'locations',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> locationsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'locations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> locationsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'locations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
          QAfterFilterCondition>
      locationsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'locations',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
          QAfterFilterCondition>
      locationsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'locations',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> locationsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locations',
        value: '',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> locationsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'locations',
        value: '',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> locationsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'locations',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> locationsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'locations',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> locationsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'locations',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> locationsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'locations',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> locationsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'locations',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> locationsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'locations',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
          QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
          QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> overallRatingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'overallRating',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> overallRatingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'overallRating',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> overallRatingEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'overallRating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> overallRatingGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'overallRating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> overallRatingLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'overallRating',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> overallRatingBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'overallRating',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> remoteFlexibilityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'remoteFlexibility',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> remoteFlexibilityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'remoteFlexibility',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> remoteFlexibilityElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteFlexibility',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> remoteFlexibilityElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remoteFlexibility',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> remoteFlexibilityElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remoteFlexibility',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> remoteFlexibilityElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remoteFlexibility',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> remoteFlexibilityElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'remoteFlexibility',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> remoteFlexibilityElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'remoteFlexibility',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
          QAfterFilterCondition>
      remoteFlexibilityElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'remoteFlexibility',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
          QAfterFilterCondition>
      remoteFlexibilityElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'remoteFlexibility',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> remoteFlexibilityElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteFlexibility',
        value: '',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> remoteFlexibilityElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'remoteFlexibility',
        value: '',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> remoteFlexibilityLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'remoteFlexibility',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> remoteFlexibilityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'remoteFlexibility',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> remoteFlexibilityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'remoteFlexibility',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> remoteFlexibilityLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'remoteFlexibility',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> remoteFlexibilityLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'remoteFlexibility',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> remoteFlexibilityLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'remoteFlexibility',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> salaryPotentialIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'salaryPotential',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> salaryPotentialIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'salaryPotential',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> salaryPotentialEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'salaryPotential',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> salaryPotentialGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'salaryPotential',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> salaryPotentialLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'salaryPotential',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> salaryPotentialBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'salaryPotential',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> techStackIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'techStack',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> techStackIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'techStack',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> techStackElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'techStack',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> techStackElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'techStack',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> techStackElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'techStack',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> techStackElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'techStack',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> techStackElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'techStack',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> techStackElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'techStack',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
          QAfterFilterCondition>
      techStackElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'techStack',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
          QAfterFilterCondition>
      techStackElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'techStack',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> techStackElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'techStack',
        value: '',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> techStackElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'techStack',
        value: '',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> techStackLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'techStack',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> techStackIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'techStack',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> techStackIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'techStack',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> techStackLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'techStack',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> techStackLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'techStack',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> techStackLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'techStack',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> tierIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tier',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> tierIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tier',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> tierEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tier',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> tierGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tier',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> tierLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tier',
        value: value,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> tierBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tier',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> websiteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'website',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> websiteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'website',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> websiteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'website',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> websiteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'website',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> websiteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'website',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> websiteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'website',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> websiteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'website',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> websiteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'website',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
          QAfterFilterCondition>
      websiteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'website',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
          QAfterFilterCondition>
      websiteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'website',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> websiteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'website',
        value: '',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> websiteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'website',
        value: '',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> workLifeBalanceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'workLifeBalance',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> workLifeBalanceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'workLifeBalance',
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> workLifeBalanceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'workLifeBalance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> workLifeBalanceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'workLifeBalance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> workLifeBalanceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'workLifeBalance',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache,
      QAfterFilterCondition> workLifeBalanceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'workLifeBalance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension WatchlistCompanyCacheQueryObject on QueryBuilder<
    WatchlistCompanyCache, WatchlistCompanyCache, QFilterCondition> {}

extension WatchlistCompanyCacheQueryLinks on QueryBuilder<WatchlistCompanyCache,
    WatchlistCompanyCache, QFilterCondition> {}

extension WatchlistCompanyCacheQuerySortBy
    on QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QSortBy> {
  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByAts() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ats', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByAtsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ats', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByAttritionRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attritionRate', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByAttritionRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attritionRate', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByEmployeeCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeCount', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByEmployeeCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeCount', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByEngineeringCulture() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'engineeringCulture', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByEngineeringCultureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'engineeringCulture', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByGrowthPotential() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'growthPotential', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByGrowthPotentialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'growthPotential', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByHeadquarters() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'headquarters', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByHeadquartersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'headquarters', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByHiringFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hiringFrequency', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByHiringFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hiringFrequency', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByOverallRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overallRating', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByOverallRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overallRating', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortBySalaryPotential() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salaryPotential', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortBySalaryPotentialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salaryPotential', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByTier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tier', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByTierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tier', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByWebsite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'website', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByWebsiteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'website', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByWorkLifeBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workLifeBalance', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      sortByWorkLifeBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workLifeBalance', Sort.desc);
    });
  }
}

extension WatchlistCompanyCacheQuerySortThenBy
    on QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QSortThenBy> {
  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByAts() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ats', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByAtsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ats', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByAttritionRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attritionRate', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByAttritionRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attritionRate', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByEmployeeCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeCount', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByEmployeeCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeCount', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByEngineeringCulture() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'engineeringCulture', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByEngineeringCultureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'engineeringCulture', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByGrowthPotential() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'growthPotential', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByGrowthPotentialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'growthPotential', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByHeadquarters() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'headquarters', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByHeadquartersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'headquarters', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByHiringFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hiringFrequency', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByHiringFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hiringFrequency', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByOverallRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overallRating', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByOverallRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overallRating', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenBySalaryPotential() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salaryPotential', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenBySalaryPotentialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'salaryPotential', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByTier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tier', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByTierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tier', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByWebsite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'website', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByWebsiteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'website', Sort.desc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByWorkLifeBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workLifeBalance', Sort.asc);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QAfterSortBy>
      thenByWorkLifeBalanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workLifeBalance', Sort.desc);
    });
  }
}

extension WatchlistCompanyCacheQueryWhereDistinct
    on QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QDistinct> {
  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QDistinct>
      distinctByAts({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ats', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QDistinct>
      distinctByAttritionRate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'attritionRate',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QDistinct>
      distinctByEmployeeCount({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'employeeCount',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QDistinct>
      distinctByEngineeringCulture() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'engineeringCulture');
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QDistinct>
      distinctByGrowthPotential() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'growthPotential');
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QDistinct>
      distinctByHeadquarters({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'headquarters', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QDistinct>
      distinctByHiringFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hiringFrequency');
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QDistinct>
      distinctByLocations() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'locations');
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QDistinct>
      distinctByOverallRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'overallRating');
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QDistinct>
      distinctByRemoteFlexibility() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteFlexibility');
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QDistinct>
      distinctBySalaryPotential() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'salaryPotential');
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QDistinct>
      distinctByTechStack() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'techStack');
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QDistinct>
      distinctByTier() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tier');
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QDistinct>
      distinctByWebsite({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'website', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WatchlistCompanyCache, WatchlistCompanyCache, QDistinct>
      distinctByWorkLifeBalance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workLifeBalance');
    });
  }
}

extension WatchlistCompanyCacheQueryProperty on QueryBuilder<
    WatchlistCompanyCache, WatchlistCompanyCache, QQueryProperty> {
  QueryBuilder<WatchlistCompanyCache, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WatchlistCompanyCache, String?, QQueryOperations> atsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ats');
    });
  }

  QueryBuilder<WatchlistCompanyCache, String?, QQueryOperations>
      attritionRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'attritionRate');
    });
  }

  QueryBuilder<WatchlistCompanyCache, String?, QQueryOperations>
      employeeCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'employeeCount');
    });
  }

  QueryBuilder<WatchlistCompanyCache, double?, QQueryOperations>
      engineeringCultureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'engineeringCulture');
    });
  }

  QueryBuilder<WatchlistCompanyCache, double?, QQueryOperations>
      growthPotentialProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'growthPotential');
    });
  }

  QueryBuilder<WatchlistCompanyCache, String?, QQueryOperations>
      headquartersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'headquarters');
    });
  }

  QueryBuilder<WatchlistCompanyCache, double?, QQueryOperations>
      hiringFrequencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hiringFrequency');
    });
  }

  QueryBuilder<WatchlistCompanyCache, List<String>?, QQueryOperations>
      locationsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'locations');
    });
  }

  QueryBuilder<WatchlistCompanyCache, String?, QQueryOperations>
      nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<WatchlistCompanyCache, double?, QQueryOperations>
      overallRatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'overallRating');
    });
  }

  QueryBuilder<WatchlistCompanyCache, List<String>?, QQueryOperations>
      remoteFlexibilityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteFlexibility');
    });
  }

  QueryBuilder<WatchlistCompanyCache, double?, QQueryOperations>
      salaryPotentialProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'salaryPotential');
    });
  }

  QueryBuilder<WatchlistCompanyCache, List<String>?, QQueryOperations>
      techStackProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'techStack');
    });
  }

  QueryBuilder<WatchlistCompanyCache, int?, QQueryOperations> tierProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tier');
    });
  }

  QueryBuilder<WatchlistCompanyCache, String?, QQueryOperations>
      websiteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'website');
    });
  }

  QueryBuilder<WatchlistCompanyCache, double?, QQueryOperations>
      workLifeBalanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workLifeBalance');
    });
  }
}
