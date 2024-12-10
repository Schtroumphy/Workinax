import 'package:workinax/time_entry/data/model/work_break.dart';
import 'package:collection/collection.dart';

class TimeEntryModel {
  final int? id;
  final DateTime startTime;
  final DateTime? endTime;
  final List<WorkBreak> breaks;

  TimeEntryModel({
    required this.id,
    required this.startTime,
    this.endTime,
    this.breaks = const [],
  });

  TimeEntryModel.init()
      : id = null,
        startTime = DateTime.now(),
        endTime = null,
        breaks = [];
  
  bool get hasBreakInProgress => breaks.firstWhereOrNull((wb)=> wb.endTime == null) != null;

  Duration get totalBreakHours =>
      breaks.fold(Duration.zero, (prev, next) => prev + next.duration);

  Duration get totalHours => endTime?.difference(startTime) ?? Duration.zero;

  Duration get overtime =>
      endTime?.difference((endTime ?? DateTime.now()).copyWith(
        hour: 12,
        minute: 30,
        second: 0,
      )) ??
      Duration.zero;

  bool get isLate => !startTime
      .difference(startTime.copyWith(hour: 5, minute: 0, second: 0))
      .isNegative;

  TimeEntryModel copyWith({
    int? id,
    DateTime? startTime,
    DateTime? endTime,
    List<WorkBreak>? breaks,
  }) {
    return TimeEntryModel(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      breaks: breaks ?? this.breaks,
    );
  }
}
