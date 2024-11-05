import 'dart:async';

import 'package:flutter/material.dart';
import 'package:workinax/data/converters/date_time_converter.dart';
import 'package:workinax/extension/date_extension.dart';
import 'package:workinax/extension/duration_extension.dart';
import 'package:workinax/extension/time_of_day_extension.dart';
import 'package:workinax/model/work_clock.dart';
import 'package:workinax/theme/colors.dart';
import 'package:workinax/widgets/app_outlined_button.dart';
import 'package:workinax/widgets/app_text.dart';
import 'package:workinax/widgets/edit_time_dialog.dart';
import 'package:workinax/widgets/icon_column.dart';
import 'package:workinax/widgets/rounded_text.dart';
import 'package:workinax/widgets/timer.dart';

class WorkTimesCard extends StatelessWidget {
  const WorkTimesCard({super.key, this.workClock});

  final WorkClock? workClock;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      color: AppColor.lightBlue,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  workClock?.endWorkTime != null
                      ? 'Temps de travail du jour'
                      : 'Travail en cours ...',
                  fontSizeType: FontSizeType.medium,
                ),
                workClock?.endWorkTime != null ? AppOutlinedButton(
                  label: 'Modifier',
                  onClick: () {
                    showDialog(
                      context: context,
                      builder: (_) => const EditTimeDialog(),
                    );
                  },
                ) : TimerFromStartTime(startTime: workClock?.startWorkTime),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconColumn(
                    icon: Icons.share_arrival_time_outlined,
                    label: workClock?.startWorkTime?.formatTimeOfDay ?? 'N/A',
                    subtitle: 'Embauché'),
                IconColumn(
                  icon: Icons.coffee,
                  label: workClock?.firstBreakDuration?.inMinutes.toString() ?? '-',
                  subtitle: 'Pause',
                ),
                IconColumn(
                  icon: Icons.coffee,
                  label: workClock?.firstBreakDuration?.inMinutes.toString() ?? '-',
                  subtitle: 'Pause',
                ),
                  IconColumn(
                  icon: Icons.exit_to_app,
                  label: workClock?.endWorkTime.formatTimeOfDay ?? 'N/A',
                  subtitle: 'Débauché',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
