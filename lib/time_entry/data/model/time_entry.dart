import 'package:json_annotation/json_annotation.dart';
import 'package:workinax/data/app_entity.dart';
import 'package:workinax/data/converters/date_time_converter.dart';

part 'time_entry.g.dart';

@JsonSerializable()
class TimeEntry extends AppEntity {
  static const tableName = 'time_entry';

  final int? id;

  @JsonKey(includeToJson: true)
  @SimpleDateTimeConverter()
  final DateTime date;

  @DateTimeConverter()
  final DateTime startTime;

  @DateTimeConverter()
  final DateTime? endTime;

  TimeEntry({
    this.id,
    required this.startTime,
    this.endTime,
  }) : date = DateTime(startTime.year, startTime.month, startTime.day);

  int get totalHours => (endTime?.hour ?? 0) - (startTime.hour);

  factory TimeEntry.fromJson(Map<String, dynamic> json) {
    return TimeEntry(
      id: json['id'] as int?,
      startTime:
          const DateTimeConverter().fromJson(json['startTime'] as String),
      endTime: json['endTime'] != null
          ? const DateTimeConverter().fromJson(json['endTime'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': const SimpleDateTimeConverter().toJson(date),
      'startTime': const DateTimeConverter().toJson(startTime),
      'endTime':
          endTime != null ? const DateTimeConverter().toJson(endTime!) : null,
    };
  }

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
