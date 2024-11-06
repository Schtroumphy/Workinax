import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workinax/data/dao/dao.dart';
import 'package:workinax/data/database_notifier.dart';
import 'package:workinax/time_entry/data/model/time_entry.dart';

part 'time_entry_dao.g.dart';

@riverpod
TimeEntryDao timeEntryDao(Ref ref) => TimeEntryDao(ref);

class TimeEntryDao extends DAO<TimeEntry> {
  TimeEntryDao(this.ref) : super('time_entry');

  final Ref ref;

  @override
  Future<Database> database() {
    return ref.read(databaseNotifierProvider.notifier).database;
  }

  @override
  TimeEntry fromJson(Json object) {
    return TimeEntry.fromJson(object);
  }

  @override
  Json toJson(TimeEntry object) {
    return object.toJson();
  }
}
