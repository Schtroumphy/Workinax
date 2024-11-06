import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workinax/extension/date_extension.dart';
import 'package:workinax/theme/colors.dart';
import 'package:workinax/theme/insets.dart';
import 'package:workinax/time_entry/application/today_entry.dart';
import 'package:workinax/time_entry/domain/time_entry_model.dart';
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
    final todayWC = ref.watch(todayEntryProvider);
    return AsyncValueWidget<TimeEntryModel?>(
      value: todayWC,
      data: (wc) => wc == null
          ? const Text('No Time entry found')
          : WorkTimesCard(timeEntry: wc),
    );
  }
}

class WorkTimesCard extends StatelessWidget {
  const WorkTimesCard({super.key, required this.timeEntry});

  final TimeEntryModel timeEntry;

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
                  timeEntry.endTime != null
                      ? 'Temps de travail du jour'
                      : 'Travail en cours ...',
                  fontSizeType: FontSizeType.medium,
                ),
                timeEntry.endTime != null
                    ? AppOutlinedButton(
                        label: 'Modifier',
                        onClick: () => _onEditClick(context),
                      )
                    : TimerFromStartTime(startTime: timeEntry.startTime),
              ],
            ),
            const SizedBox(height: Insets.m),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: IconColumn(
                      icon: Icons.share_arrival_time_outlined,
                      label: timeEntry.startTime.formatHoursMinutes,
                      subtitle: 'Embauché'),
                ),
                // Flexible(
                //   child: IconColumn(
                //     icon: Icons.coffee,
                //     label: timeEntry.breaks.first.duration.formatShortDuration,
                //     subtitle: 'Pause',
                //   ),
                // ),
                // Flexible(
                //   child: IconColumn(
                //     icon: Icons.coffee,
                //     label: timeEntry.breaks.first.duration.formatShortDuration,
                //     subtitle: 'Pause',
                //   ),
                // ),
                Flexible(
                  child: IconColumn(
                    icon: Icons.exit_to_app,
                    label: timeEntry.endTime?.formatHoursMinutes ?? 'N/A',
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
    showEditTimeDialog(context, timeEntry);
  }
}
