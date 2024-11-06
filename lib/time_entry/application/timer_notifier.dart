import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timer_notifier.g.dart';

@riverpod
class TimerNotifier extends _$TimerNotifier {
  TimerNotifier();

  Timer? timer;

  @override
  Duration build(DateTime startTime) {
    _dispose();
    _initializeTimer();
    return Duration.zero;
  }

  void _initializeTimer() {
    final now = DateTime.now();

    state = now.difference(startTime);

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state += const Duration(seconds: 1);
    });
  }

  void _dispose() {
    ref.onDispose(() async {
      timer?.cancel();
    });
  }
}
