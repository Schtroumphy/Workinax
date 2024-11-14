import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workinax/extensions/duration_extension.dart';
import 'package:workinax/theme/colors.dart';
import 'package:workinax/time_entry/application/timer_notifier.dart';
import 'package:workinax/widgets/app_text.dart';
import 'package:workinax/widgets/rounded_text.dart';

class BreakTimer extends ConsumerWidget {
  const BreakTimer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final breakDuration =
        ref.watch(timerNotifierProvider(DateTime.now())).formatClockDuration;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AppText('Durée de la pause '),
        const SizedBox(
          width: 8,
        ),
        RoundedText(
          breakDuration,
          color: AppColor.primaryColor,
          textColor: Colors.white,
        )
      ],
    );
  }
}
