import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workinax/data/database_helper.dart';
import 'package:workinax/extension/duration_extension.dart';
import 'package:workinax/extension/time_of_day_extension.dart';
import 'package:workinax/model/work_clock.dart';
import 'package:workinax/theme/colors.dart';
import 'package:workinax/theme/insets.dart';
import 'package:workinax/widgets/app_outlined_button.dart';
import 'package:workinax/widgets/app_text.dart';
import 'package:workinax/widgets/async_value_widget.dart';
import 'package:workinax/widgets/edit_time_dialog.dart';
import 'package:workinax/widgets/icon_column.dart';
import 'package:workinax/widgets/timer.dart';

class AsyncWorkTimesCard extends ConsumerWidget {
  const AsyncWorkTimesCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayWC = ref.watch(getTodayWorkClockProvider);
    return AsyncValueWidget<WorkClock?>(
      value: todayWC,
      data: (wc) => wc == null ? const Text('No WorkClock found') : WorkTimesCard(workClock: wc),
    );
  }
}

class WorkTimesCard extends StatelessWidget {
  const WorkTimesCard({super.key, required this.workClock});

  final WorkClock workClock;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      color: AppColor.lightBlue,
      child: Padding(
        padding: const EdgeInsets.all(Insets.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  workClock.endWorkTime != null
                      ? 'Temps de travail du jour'
                      : 'Travail en cours ...',
                  fontSizeType: FontSizeType.medium,
                ),
                workClock.endWorkTime != null
                    ? AppOutlinedButton(
                        label: 'Modifier',
                        onClick: () => _onEditClick(context),
                      )
                    : TimerFromStartTime(startTime: workClock.startWorkTime),
              ],
            ),
            const SizedBox(height: Insets.m),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: IconColumn(
                      icon: Icons.share_arrival_time_outlined,
                      label: workClock.startWorkTime?.formatTimeOfDay ?? 'N/A',
                      subtitle: 'Embauché'),
                ),
                Flexible(
                  child: IconColumn(
                    icon: Icons.coffee,
                    label:
                        workClock.firstBreakDuration?.formatShortDuration ?? '-',
                    subtitle: 'Pause',
                  ),
                ),
                Flexible(
                  child: IconColumn(
                    icon: Icons.coffee,
                    label: workClock.secondBreakDuration?.formatShortDuration ??
                        '-',
                    subtitle: 'Pause',
                  ),
                ),
                Flexible(
                  child: IconColumn(
                    icon: Icons.exit_to_app,
                    label: workClock.endWorkTime?.formatTimeOfDay ?? 'N/A',
                    subtitle: 'Débauché',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _onEditClick(BuildContext context) {
    showEditTimeDialog(context, workClock);
  }
}
