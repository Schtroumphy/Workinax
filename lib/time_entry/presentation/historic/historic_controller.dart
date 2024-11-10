import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workinax/extension/duration_extension.dart';
import 'package:workinax/time_entry/application/time_entry_service.dart';
import 'package:workinax/time_entry/data/model/work_break.dart';
import 'package:workinax/time_entry/domain/time_entry_model.dart';
import 'package:workinax/widgets/edit_time_dialog.dart';

part 'historic_controller.g.dart';

@riverpod
class HistoricController extends _$HistoricController {
  @override
  Future<List<TimeEntryModel>> build() {
    _init();
    return Future.value([]);
  }

  var currentEntryId = 0;

  setCurrentUpdatingEntryId(int id) {
    currentEntryId = id;
  }

  _init() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_getAllModels);
  }

  Future<List<TimeEntryModel>> _getAllModels() {
    return ref.read(timeEntryServiceProvider).getAll();
  }

  Future<List<TimeEntryModel>> edit(FormBuilderState builderState) {
    final currentModel = state.value!.firstWhere((e) => e.id == currentEntryId);

    final newBreaks = <WorkBreak>[
      for (var i = 1; i < maxBreakNumber + 2; i++)
        toWorkBreak(
          start: builderState.fields['break_start_$i']?.value as DateTime,
          duration: builderState.fields['break_start_$i']?.value as Duration?,
        ),
    ];

    final newEntry = currentModel.copyWith(
      startTime: builderState.fields[clockInField]?.value as DateTime?,
      endTime: builderState.fields[clockOutField]?.value as DateTime?,
      breaks: newBreaks,
    );
    return ref.read(timeEntryServiceProvider).getAll();
  }

  delete(int id) {
    ref.read(timeEntryServiceProvider).deleteById(id);
  }

  toWorkBreak({required DateTime start, Duration? duration}) {
    return WorkBreak(startTime: start, endTime: start.add(duration.orZero));
  }
}
