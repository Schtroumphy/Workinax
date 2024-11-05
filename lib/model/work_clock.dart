import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:workinax/data/converters/date_time_converter.dart';
import 'package:workinax/data/converters/duration_converter.dart';
import 'package:workinax/extension/duration_extension.dart';

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

  WorkClock.newOne()
      : id = null,
        date = DateTime.now(),
        startWorkTime = null,
        endWorkTime = null,
        firstBreakDuration = null,
        secondBreakDuration = null;

  int get totalHours => (endWorkTime?.hour ?? 0) - (startWorkTime?.hour ?? 0);

  Duration get totalBreakTime =>
      firstBreakDuration.orZero + secondBreakDuration.orZero;

  factory WorkClock.fromJson(Map<String, dynamic> json) =>
      _$WorkClockFromJson(json);

  Map<String, dynamic> toJson() => _$WorkClockToJson(this);

  WorkClock copyWith({
    int? id,
    DateTime? date,
    TimeOfDay? startWorkTime,
    TimeOfDay? endWorkTime,
    Duration? firstBreakDuration,
    Duration? secondBreakDuration,
  }) {
    return WorkClock(
      id: id ?? this.id,
      date: date ?? this.date,
      startWorkTime: startWorkTime ?? this.startWorkTime,
      endWorkTime: endWorkTime ?? this.endWorkTime,
      firstBreakDuration: firstBreakDuration ?? this.firstBreakDuration,
      secondBreakDuration: secondBreakDuration ?? this.secondBreakDuration,
    );
  }
}
