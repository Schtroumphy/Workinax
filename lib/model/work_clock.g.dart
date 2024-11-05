// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_clock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkClock _$WorkClockFromJson(Map<String, dynamic> json) => WorkClock(
      id: (json['id'] as num?)?.toInt(),
      date: const DateTimeConverter().fromJson(json['date'] as String),
      startWorkDate: _$JsonConverterFromJson<String, DateTime>(
          json['startWorkDate'], const DateTimeToTimeConverter().fromJson),
      endWorkDate: _$JsonConverterFromJson<String, DateTime>(
          json['endWorkDate'], const DateTimeToTimeConverter().fromJson),
      firstBreakDuration: json['firstBreakDuration'] == null
          ? null
          : Duration(microseconds: (json['firstBreakDuration'] as num).toInt()),
      secondBreakDuration: json['secondBreakDuration'] == null
          ? null
          : Duration(
              microseconds: (json['secondBreakDuration'] as num).toInt()),
    );

Map<String, dynamic> _$WorkClockToJson(WorkClock instance) => <String, dynamic>{
      'id': instance.id,
      'date': const DateTimeConverter().toJson(instance.date),
      'startWorkDate': _$JsonConverterToJson<String, DateTime>(
          instance.startWorkDate, const DateTimeToTimeConverter().toJson),
      'endWorkDate': _$JsonConverterToJson<String, DateTime>(
          instance.endWorkDate, const DateTimeToTimeConverter().toJson),
      'firstBreakDuration': instance.firstBreakDuration?.inMicroseconds,
      'secondBreakDuration': instance.secondBreakDuration?.inMicroseconds,
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
