import 'dart:async';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timer_notifier.g.dart';

@riverpod
class TimerNotifier extends _$TimerNotifier {
  TimerNotifier({this.startTime});

  final TimeOfDay? startTime;
  Timer? timer;

  @override
  Duration build() {
    _dispose();
    _initializeTimer();
    return Duration.zero;
  }

  void _initializeTimer() {
    if (startTime == null) {
      state = Duration.zero;
    } else {
      final startDateTime = _timeOfDayToDateTime(startTime!);
      final now = DateTime.now();

      state = now.isAfter(startDateTime)
          ? now.difference(startDateTime)
          : Duration.zero;
    }

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state += const Duration(seconds: 1);
    });
  }

  DateTime _timeOfDayToDateTime(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    return DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  }

  void _dispose() {
    ref.onDispose(() async {
      timer?.cancel();
    });
  }
}
