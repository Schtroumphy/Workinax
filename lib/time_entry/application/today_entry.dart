import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workinax/time_entry/application/time_entry_service.dart';
import 'package:workinax/time_entry/domain/time_entry_model.dart';

part 'today_entry.g.dart';

@riverpod
Future<TimeEntryModel?> todayEntry(Ref ref) {
  final service = ref.watch(timeEntryServiceProvider);
  return service.todayEntry();
}
