import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workinax/time_entry/data/repository/time_entry_repository.dart';
import 'package:workinax/time_entry/domain/time_entry_model.dart';

part 'time_entry_service.g.dart';

@Riverpod(keepAlive: true)
TimeEntryService timeEntryService(Ref ref) {
  return TimeEntryService(ref, ref.read(timeEntryRepositoryProvider));
}

class TimeEntryService {
  final TimeEntryRepository _repository;
  final Ref _ref;

  TimeEntryService(this._ref, this._repository);

  Future<TimeEntryModel?> saveAndFetch(TimeEntryModel model) async {
    return _repository.saveAndFetch(model);
  }

  Future<void> save(TimeEntryModel timeEntry) async {
    _repository.save(timeEntry);
  }

  Future<List<TimeEntryModel>> getAll() {
    return _repository.getAll();
  }

  deleteById(int id) async {
    _repository.deleteById(id);
  }

  Future<TimeEntryModel?> addBreak(int entryId) {
    return _repository.addBreak(entryId);
  }

  Future<TimeEntryModel?> endBreak(int entryId) {
    final entry = _repository.endBreak(entryId);
    _ref.invalidateSelf();
    return entry;
  }

  Future<TimeEntryModel?> todayEntry() {
    return _repository.getByDate(DateTime.now());
  }
}
