// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_clock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkClock _$WorkClockFromJson(Map<String, dynamic> json) => WorkClock(
      id: (json['id'] as num?)?.toInt(),
      date: DateTime.parse(json['date'] as String),
      startWorkDate: json['startWorkDate'] == null
          ? null
          : DateTime.parse(json['startWorkDate'] as String),
      endWorkDate: json['endWorkDate'] == null
          ? null
          : DateTime.parse(json['endWorkDate'] as String),
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
      'date': instance.date.toIso8601String(),
      'startWorkDate': instance.startWorkDate?.toIso8601String(),
      'endWorkDate': instance.endWorkDate?.toIso8601String(),
      'firstBreakDuration': instance.firstBreakDuration?.inMicroseconds,
      'secondBreakDuration': instance.secondBreakDuration?.inMicroseconds,
    };
