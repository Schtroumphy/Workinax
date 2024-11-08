import 'package:flutter/material.dart';
import 'package:workinax/time_entry/domain/mode_type.dart';

class AppImage extends StatelessWidget {
  const AppImage({super.key, required this.mode});

  final ModeType mode;

  @override
  Widget build(BuildContext context) {
    return switch (mode) {
      ModeType.workInProgress => Image.asset('assets/images/worker.jpg'),
      ModeType.breakInProgress => //
        Image.asset('assets/images/break.jpg'),
      _ => const SizedBox.shrink(),
    };
  }
}
