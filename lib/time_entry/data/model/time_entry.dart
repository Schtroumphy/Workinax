import 'package:json_annotation/json_annotation.dart';
import 'package:workinax/data/app_entity.dart';
import 'package:workinax/data/converters/date_time_converter.dart';

part 'time_entry.g.dart';

@JsonSerializable()
class TimeEntry extends AppEntity {
  static const tableName = 'time_entry';

  final int? id;

  @DateTimeConverter()
  final DateTime startTime;

  @DateTimeConverter()
  final DateTime? endTime;

  TimeEntry({
    this.id,
    required this.startTime,
    this.endTime,
  });

  int get totalHours => (endTime?.hour ?? 0) - (startTime.hour);

  factory TimeEntry.fromJson(Map<String, dynamic> json) =>
      _$TimeEntryFromJson(json);

  Map<String, dynamic> toJson() => _$TimeEntryToJson(this);

  TimeEntry copyWith({
    int? id,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return TimeEntry(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}
