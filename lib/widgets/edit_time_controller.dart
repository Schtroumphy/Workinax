import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workinax/time_entry/application/time_entry_service.dart';
import 'package:workinax/time_entry/data/model/work_break.dart';
import 'package:workinax/time_entry/domain/time_entry_model.dart';
import 'package:workinax/time_entry/presentation/historic/historic_controller.dart';
import 'package:workinax/widgets/edit_time_dialog.dart';

part 'edit_time_controller.g.dart';

class TimeEntryState {
  final List<WorkBreak> breaks;
  final TimeEntryModel? timeEntry;
  final bool loading;
  final String? error;

  const TimeEntryState({
    this.breaks = const [],
    this.timeEntry,
    this.loading = false,
    this.error,
  });

  TimeEntryState copyWith({
    List<WorkBreak>? breaks,
    TimeEntryModel? timeEntry,
    bool? loading,
    String? error,
  }) {
    return TimeEntryState(
      breaks: breaks ?? this.breaks,
      timeEntry: timeEntry ?? this.timeEntry,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}

@riverpod
class EditTimeController extends _$EditTimeController {
  @override
  TimeEntryState build(TimeEntryModel model) {
    return TimeEntryState(
      timeEntry: model,
      breaks: List.from(model.breaks),
    );
  }

  void onStartTimeChange(DateTime? date) {
    if (date == null) return;

    state = state.copyWith(
      timeEntry: state.timeEntry?.copyWith(startTime: date),
    );
  }

  void addBreak() {
    final newBreak = WorkBreak(
      startTime: DateTime.now(),
      timeEntryId: state.timeEntry?.id,
    );

    state = state.copyWith(
      breaks: [...state.breaks, newBreak],
    );
  }

  void deleteBreak(int index) {
    final newBreaks = List<WorkBreak>.from(state.breaks);
    newBreaks.removeAt(index);

    state = state.copyWith(breaks: newBreaks);
  }

  void updateBreak(
    int index, {
    DateTime? startTime,
    Duration? duration,
  }) {
    final newBreaks = List<WorkBreak>.from(state.breaks);
    final currentBreak = newBreaks[index];

    final endTime = startTime != null && duration != null
        ? startTime.add(duration)
        : currentBreak.endTime;

    newBreaks[index] = WorkBreak(
      id: currentBreak.id,
      startTime: startTime ?? currentBreak.startTime,
      endTime: endTime,
      timeEntryId: state.timeEntry?.id,
    );

    state = state.copyWith(breaks: newBreaks);
  }

  Future<void> save(Map<String, dynamic> formValues) async {
    try {
      state = state.copyWith(loading: true, error: null);

      final currentEntry = state.timeEntry;
      if (currentEntry == null) return;

      final baseDate =
          formValues[dateField] as DateTime?; // When creating new entry

      DateTime? adjustDate(DateTime? dateTime) {
        if (dateTime == null || baseDate == null) return dateTime;
        return DateTime(
          baseDate.year,
          baseDate.month,
          baseDate.day,
          dateTime.hour,
          dateTime.minute,
          dateTime.second,
        );
      }

      final updatedBreaks = state.breaks.asMap().entries.map((entry) {
        final index = entry.key;
        final breakItem = entry.value;

        final startTime =
            adjustDate(formValues['break_start_$index'] as DateTime?);
        final duration = formValues['break_duration_$index'] as Duration?;
        final endTime = startTime?.add(duration ?? Duration.zero);

        return WorkBreak(
          id: breakItem.id,
          startTime: startTime ?? breakItem.startTime,
          endTime: endTime,
          timeEntryId: currentEntry.id,
        );
      }).toList();

      final updatedModel = TimeEntryModel(
        id: currentEntry.id,
        startTime:
            adjustDate(formValues[clockInField]) ?? currentEntry.startTime,
        endTime: adjustDate(formValues[clockOutField]),
        breaks: updatedBreaks,
      );

      await ref.read(timeEntryServiceProvider).save(updatedModel);
      ref.invalidate(historicControllerProvider);

      state = state.copyWith(
        timeEntry: updatedModel,
        breaks: updatedBreaks,
        loading: false,
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: e.toString(),
      );
    }
  }
}
