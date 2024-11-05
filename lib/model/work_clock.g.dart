// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_clock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkClock _$WorkClockFromJson(Map<String, dynamic> json) => WorkClock(
      id: (json['id'] as num?)?.toInt(),
      date: const DateTimeConverter().fromJson(json['date'] as String),
      startWorkTime: _$JsonConverterFromJson<String, TimeOfDay>(
          json['startWorkTime'], const TimeOfDayConverter().fromJson),
      endWorkTime: _$JsonConverterFromJson<String, TimeOfDay>(
          json['endWorkTime'], const TimeOfDayConverter().fromJson),
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
      'startWorkTime': _$JsonConverterToJson<String, TimeOfDay>(
          instance.startWorkTime, const TimeOfDayConverter().toJson),
      'endWorkTime': _$JsonConverterToJson<String, TimeOfDay>(
          instance.endWorkTime, const TimeOfDayConverter().toJson),
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
