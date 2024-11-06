import 'package:flutter/material.dart';
import 'package:workinax/time_entry/domain/mode_type.dart';
import 'package:workinax/widgets/break_timer.dart';

class AppImage extends StatelessWidget {
  const AppImage({super.key, required this.mode});

  final ModeType mode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        switch (mode) {
          ModeType.workInProgress =>
            Image.asset('assets/images/working_rounded.png'),
          ModeType.breakInProgress => //
            Image.asset('assets/images/coffee.png'),
          _ => const SizedBox.shrink(),
        },
        if (mode == ModeType.breakInProgress) const BreakTimer()
      ],
    );
  }
}
