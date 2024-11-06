import 'package:json_annotation/json_annotation.dart';
import 'package:workinax/data/app_entity.dart';
import 'package:workinax/data/converters/date_time_converter.dart';

part 'work_break.g.dart';

@JsonSerializable()
class WorkBreak extends AppEntity {
  static const tableName = 'work_break';

  final int? id;

  @DateTimeConverter()
  final DateTime startTime;

  @DateTimeConverter()
  final DateTime? endTime;

  final int? timeEntryId;

  WorkBreak.init(this.timeEntryId)
      : id = null,
        startTime = DateTime.now(),
        endTime = null;

  WorkBreak({
    this.id,
    required this.startTime,
    this.endTime,
    this.timeEntryId,
  });

  Duration get duration => endTime?.difference(startTime) ?? Duration.zero;

  factory WorkBreak.fromJson(Map<String, dynamic> json) =>
      _$WorkBreakFromJson(json);

  Map<String, dynamic> toJson() => _$WorkBreakToJson(this);

  WorkBreak copyWith({
    int? id,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return WorkBreak(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      timeEntryId: timeEntryId,
    );
  }
}
