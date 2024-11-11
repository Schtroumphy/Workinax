import 'dart:async';

import 'package:flutter/material.dart';
import 'package:workinax/extension/duration_extension.dart';
import 'package:workinax/theme/colors.dart';
import 'package:workinax/widgets/rounded_text.dart';

class TimerFromStartTime extends StatefulWidget {
  final DateTime? startTime;
  final bool outlined;

  const TimerFromStartTime({super.key, this.startTime, this.outlined = false});

  @override
  TimerFromStartTimeState createState() => TimerFromStartTimeState();
}

class TimerFromStartTimeState extends State<TimerFromStartTime> {
  late final AppLifecycleListener _listener;
  late Timer _timer;
  Duration _elapsedTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      onStateChange: _onStateChanged,
    );
    _startTimer();
  }

  void _onStateChanged(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _resetAndStartTimer();
    } else if (state == AppLifecycleState.paused) {
      _timer.cancel();
    }
  }

  @override
  void didUpdateWidget(covariant TimerFromStartTime oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset timer when an other instance is built
    _resetAndStartTimer();
  }

  void _resetAndStartTimer() {
    _timer.cancel();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _listener.dispose();
    super.dispose();
  }

  void _startTimer() {
    final startDateTime = widget.startTime;

    if (startDateTime == null) {
      _elapsedTime = Duration.zero;
    } else {
      final now = DateTime.now();
      _elapsedTime = now.difference(startDateTime);
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime += const Duration(seconds: 1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      key: UniqueKey(),
      child: RoundedText(
        _elapsedTime.formatClockDuration,
        color: AppColor.primaryColor,
        textColor: widget.outlined ? AppColor.primaryColor : Colors.white,
        outlined: widget.outlined,
      ),
    );
  }
}
