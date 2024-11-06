import 'dart:async';

import 'package:flutter/material.dart';
import 'package:workinax/extension/duration_extension.dart';
import 'package:workinax/theme/colors.dart';
import 'package:workinax/widgets/rounded_text.dart';

class TimerFromStartTime extends StatefulWidget {
  final DateTime? startTime;

  const TimerFromStartTime({super.key, this.startTime});

  @override
  TimerFromStartTimeState createState() => TimerFromStartTimeState();
}

class TimerFromStartTimeState extends State<TimerFromStartTime> {
  late Timer _timer;
  Duration _elapsedTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
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
      child: RoundedText(
        _elapsedTime.formatDuration,
        color: AppColor.primaryColor,
        textColor: Colors.white,
      ),
    );
  }
}
