import 'package:json_annotation/json_annotation.dart';

part 'work_clock.g.dart';

@JsonSerializable()
class WorkClock {
  final int? id;
  final DateTime date;
  final DateTime? startWorkDate;
  final DateTime? endWorkDate;
  final Duration? firstBreakDuration;
  final Duration? secondBreakDuration;

  WorkClock({
    this.id,
    required this.date,
    this.startWorkDate,
    this.endWorkDate,
    this.firstBreakDuration,
    this.secondBreakDuration,
  });

  WorkClock.init()
      : id = null,
        date = DateTime.now(),
        startWorkDate = DateTime.now(),
        endWorkDate = null,
        firstBreakDuration = null,
        secondBreakDuration = null;

  int get totalHours => (endWorkDate?.hour ?? 0) - (startWorkDate?.hour ?? 0);

  factory WorkClock.fromJson(Map<String, dynamic> json) =>
      _$WorkClockFromJson(json);

  Map<String, dynamic> toJson() => _$WorkClockToJson(this);
}
