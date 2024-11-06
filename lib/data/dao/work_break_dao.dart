import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workinax/data/dao/dao.dart';
import 'package:workinax/data/database_notifier.dart';
import 'package:workinax/time_entry/data/model/work_break.dart';

part 'work_break_dao.g.dart';

@riverpod
WorkBreakDao workBreakDao(Ref ref) => WorkBreakDao(ref);

class WorkBreakDao extends DAO<WorkBreak> {
  final Ref ref;

  WorkBreakDao(this.ref) : super('work_break');

  @override
  Future<Database> database() {
    return ref.read(databaseNotifierProvider.notifier).database;
  }

  @override
  WorkBreak fromJson(Json object) {
    return WorkBreak.fromJson(object);
  }

  @override
  Json toJson(WorkBreak object) {
    return object.toJson();
  }
}
