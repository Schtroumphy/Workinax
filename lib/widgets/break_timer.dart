import 'package:flutter/material.dart';
import 'package:workinax/widgets/app_text.dart';
import 'package:workinax/widgets/timer.dart';

class BreakTimer extends StatelessWidget {
  const BreakTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AppText('Durée de la pause '),
        const SizedBox(
          width: 8,
        ),
        TimerFromStartTime(
          startTime: TimeOfDay.now(),
        )
      ],
    );
  }
}