import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:workinax/data/converters/date_time_converter.dart';
import 'package:workinax/data/converters/duration_converter.dart';

part 'work_clock.g.dart';

@JsonSerializable()
class WorkClock {
  static const tableName = 'work_clock';

  final int? id;

  @DateTimeConverter()
  final DateTime date;

  @TimeOfDayConverter()
  final TimeOfDay? startWorkTime;

  @TimeOfDayConverter()
  final TimeOfDay? endWorkTime;

  @DurationConverter()
  final Duration? firstBreakDuration;

  @DurationConverter()
  final Duration? secondBreakDuration;

  WorkClock({
    this.id,
    required this.date,
    this.startWorkTime,
    this.endWorkTime,
    this.firstBreakDuration,
    this.secondBreakDuration,
  });

  WorkClock.init()
      : id = null,
        date = DateTime.now(),
        startWorkTime = TimeOfDay.now(),
        endWorkTime = null,
        firstBreakDuration = null,
        secondBreakDuration = null;

  int get totalHours => (endWorkTime?.hour ?? 0) - (startWorkTime?.hour ?? 0);

  factory WorkClock.fromJson(Map<String, dynamic> json) =>
      _$WorkClockFromJson(json);

  Map<String, dynamic> toJson() => _$WorkClockToJson(this);
}