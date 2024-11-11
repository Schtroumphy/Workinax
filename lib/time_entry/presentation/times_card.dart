import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workinax/extension/date_extension.dart';
import 'package:workinax/extension/duration_extension.dart';
import 'package:workinax/theme/colors.dart';
import 'package:workinax/theme/insets.dart';
import 'package:workinax/time_entry/application/today_entry.dart';
import 'package:workinax/time_entry/domain/time_entry_model.dart';
import 'package:workinax/widgets/async_value_widget.dart';
import 'package:workinax/widgets/edit_time_dialog.dart';
import 'package:workinax/widgets/icon_column.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: AppColor.lightBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () => _onEditClick(context),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(Insets.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: Insets.m),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: IconColumn(
                        iconPath: 'assets/icons/clock_in.svg',
                        label: timeEntry.startTime.formatHoursMinutes,
                        subtitle: 'Embauché'),
                  ),
                  for (var b in timeEntry.breaks)
                    Flexible(
                      child: IconColumn(
                        iconPath: 'assets/icons/coffee_break.svg',
                        label: b.duration.formatDuration,
                        subtitle: 'Pause',
                      ),
                    ),
                  Flexible(
                    child: IconColumn(
                      iconPath: 'assets/icons/out.svg',
                      label: timeEntry.endTime?.formatHoursMinutes ?? 'N/A',
                      subtitle: 'Débauché',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onEditClick(BuildContext context) {
    if (timeEntry.endTime != null) showEditTimeDialog(context, timeEntry);
  }
}
