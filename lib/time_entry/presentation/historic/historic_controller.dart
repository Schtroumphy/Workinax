import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workinax/time_entry/application/time_entry_service.dart';
import 'package:workinax/time_entry/domain/time_entry_model.dart';

part 'historic_controller.g.dart';

@riverpod
class HistoricController extends _$HistoricController {
  @override
  Future<List<TimeEntryModel>> build() {
    _init();
    return Future.value([]);
  }

  _init() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_getAllModels);
  }

  Future<List<TimeEntryModel>> _getAllModels() {
    return ref.read(timeEntryServiceProvider).getAll();
  }

  delete(int id) {
    ref.read(timeEntryServiceProvider).deleteById(id);
  }
}
