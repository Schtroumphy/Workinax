import 'package:workinax/time_entry/data/model/work_break.dart';

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

  Duration get totalBreakHours =>
      breaks.fold(Duration.zero, (prev, next) => prev + next.duration);

  Duration get totalHours => endTime?.difference(startTime) ?? Duration.zero;

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
