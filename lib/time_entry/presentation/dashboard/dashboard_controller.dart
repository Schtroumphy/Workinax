import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workinax/time_entry/application/time_entry_service.dart';
import 'package:workinax/time_entry/domain/mode_type.dart';
import 'package:workinax/time_entry/domain/time_entry_model.dart';

part 'dashboard_controller.g.dart';

class DashboardState {
  final ModeType modeType;
  final TimeEntryModel? timeEntryModel;

  DashboardState({
    required this.modeType,
    this.timeEntryModel,
  });

  DashboardState.init()
      : modeType = ModeType.notStarted,
        timeEntryModel = null;

  DashboardState copyWith({ModeType? modeType, TimeEntryModel? timeEntryModel}) {
    return DashboardState(
      modeType: modeType ?? this.modeType,
      timeEntryModel: timeEntryModel ?? this.timeEntryModel,
    );
  }
}

@riverpod
class DashboardController extends _$DashboardController {
  TimeEntryService get service => ref.read(timeEntryServiceProvider);

  TimeEntryModel? get currentEntry => state.asData?.valueOrNull?.timeEntryModel;

  @override
  Future<DashboardState> build() async {
    return await initTodayEntry();
  }

  Future<DashboardState> initTodayEntry() async {
    final todayEntry = await service.todayEntry();

    if (todayEntry == null) return DashboardState.init();

    return DashboardState(
      modeType: todayEntry.endTime != null ? ModeType.workInProgress : ModeType.workEnd,
      timeEntryModel: todayEntry,
    );
  }

  Future<void> updateState({
    ModeType? modeType,
    TimeEntryModel? model,
  }) async {
    final previousState = state.asData?.valueOrNull;

    if (previousState == null) {
      state = AsyncValue.error(Exception('Previous state is null'), StackTrace.empty);
      return;
    }
    final newState = previousState.copyWith(
      modeType: modeType,
      timeEntryModel: model,
    );
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return newState;
    });
  }

  onClockIn() async {
    final timeEntryModel = await service.saveAndFetch(TimeEntryModel.init());
    state = AsyncValue.data(state.asData?.value.copyWith(modeType: ModeType.workInProgress, timeEntryModel: timeEntryModel) ?? DashboardState.init());
  }

  onClockOut() async {
    final timeEntryModel = currentEntry?.copyWith(endTime: DateTime.now());

    if (timeEntryModel == null) return;

    await service.save(timeEntryModel);
    ref.invalidate(timeEntryServiceProvider);

    updateState(
      modeType: ModeType.workEnd,
      model: timeEntryModel,
    );
  }

  onBreakIn() async {
    if (currentEntry?.id == null) return;

    final timeEntryModel = await service.addBreak(currentEntry!.id!);

    updateState(
      modeType: ModeType.breakInProgress,
      model: timeEntryModel,
    );
  }

  onBreakOut() async {
    if (currentEntry?.id == null) return;

    final entry = await service.endBreak(currentEntry!.id!);

    updateState(
      modeType: ModeType.workInProgress,
      model: entry,
    );
  }
}
