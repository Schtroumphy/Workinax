// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_break.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkBreak _$WorkBreakFromJson(Map<String, dynamic> json) => WorkBreak(
      id: (json['id'] as num?)?.toInt(),
      startTime:
          const DateTimeConverter().fromJson(json['startTime'] as String),
      endTime: _$JsonConverterFromJson<String, DateTime>(
          json['endTime'], const DateTimeConverter().fromJson),
      timeEntryId: (json['timeEntryId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WorkBreakToJson(WorkBreak instance) => <String, dynamic>{
      'id': instance.id,
      'startTime': const DateTimeConverter().toJson(instance.startTime),
      'endTime': _$JsonConverterToJson<String, DateTime>(
          instance.endTime, const DateTimeConverter().toJson),
      'timeEntryId': instance.timeEntryId,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
