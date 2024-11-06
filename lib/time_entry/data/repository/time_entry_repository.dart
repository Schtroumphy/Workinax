import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workinax/data/dao/time_entry_dao.dart';
import 'package:workinax/data/dao/work_break_dao.dart';
import 'package:workinax/extension/date_extension.dart';
import 'package:workinax/time_entry/data/model/time_entry.dart';
import 'package:workinax/time_entry/data/model/work_break.dart';
import 'package:workinax/time_entry/domain/time_entry_model.dart';

part 'time_entry_repository.g.dart';

extension TimeEntryModelExtension on TimeEntryModel {
  TimeEntry toTimeEntry() {
    return TimeEntry(
      id: id,
      startTime: startTime,
      endTime: endTime,
    );
  }
}

@riverpod
TimeEntryRepository timeEntryRepository(Ref ref) => TimeEntryRepository(
    ref.read(timeEntryDaoProvider), ref.read(workBreakDaoProvider));

class TimeEntryRepository {
  final TimeEntryDao _timeEntryDao;
  final WorkBreakDao _workBreakDao;

  TimeEntryRepository(this._timeEntryDao, this._workBreakDao);

  Future<TimeEntryModel?> saveAndFetch(TimeEntryModel timeEntry) async {
    final id = await save(timeEntry);

    return getById(id);
  }

  Future<int> save(TimeEntryModel model) async {
    model.breaks.forEach(_workBreakDao.save);
    return _timeEntryDao.save(model.toTimeEntry());
  }

  Future<TimeEntryModel?> getById(int id) async {
    final entry = await _timeEntryDao.getById(id);
    return toModel(entry);
  }

  Future<TimeEntryModel?> getFirstOrNull({
    String? where,
    List<String> whereArgs = const [],
  }) async {
    final entry = await _timeEntryDao.queryFirstItem(
      where: where,
      whereArgs: whereArgs,
    );
    return toModel(entry);
  }

  Future<List<TimeEntryModel>> getAll({
    String? where,
    List<String> whereArgs = const [],
  }) async {
    final entries = await _timeEntryDao.getAll(
      where: where,
      whereArgs: whereArgs,
    );

    final models = await Future.wait(entries.map((e) => toModel(e)));

    return models.nonNulls.toList();
  }

  Future<TimeEntryModel?> getByDate(DateTime date) async {
    return getFirstOrNull(
        where: 'DATE(startTime) = ?', whereArgs: [date.formatDbShortDate]);
  }

  void deleteById(int id) async {
    _timeEntryDao.deleteById(id);
  }

  Future<TimeEntryModel?> toModel(
    TimeEntry? entry, {
    List<WorkBreak>? breaks,
  }) async {
    if (entry == null) return null;

    final List<WorkBreak> breaks = await _getBreaksByTimeEntryId(entry.id!);

    return TimeEntryModel(
      id: entry.id,
      startTime: entry.startTime,
      endTime: entry.endTime,
      breaks: breaks,
    );
  }

  /// WorkBreaks methods
  Future<List<WorkBreak>> _getBreaksByTimeEntryId(int entryId) {
    return _workBreakDao
        .queryItems(where: 'timeEntryId = ?', whereArgs: [entryId]);
  }

  Future<TimeEntryModel?> addBreak(int entryId) async {
    final id = await _workBreakDao.save(
      WorkBreak(
        startTime: DateTime.now(),
        timeEntryId: entryId,
      ),
    );

    final workBreak = await _workBreakDao.getById(id);

    final entry = await getById(entryId);
    if (workBreak != null) {
      entry?.breaks.add(workBreak);
    }

    return entry;
  }

  Future<TimeEntryModel?> endBreak(int entryId) async {
    final breaks = await _getBreaksByTimeEntryId(entryId);
    final currentBreak = breaks.firstWhere((b) => b.endTime == null);
    final endedBreak = currentBreak.copyWith(
      endTime: DateTime.now(),
    );

    _workBreakDao.save(endedBreak);

    final updatedBreaks = await _getBreaksByTimeEntryId(entryId);
    final entry = await getById(entryId);
    entry?.copyWith(
      breaks: updatedBreaks,
    );
    return entry;
  }
}
