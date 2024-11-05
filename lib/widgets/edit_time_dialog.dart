import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workinax/data/database_helper.dart';
import 'package:workinax/extension/date_extension.dart';
import 'package:workinax/extension/duration_extension.dart';
import 'package:workinax/model/work_clock.dart';
import 'package:workinax/theme/colors.dart';
import 'package:workinax/theme/insets.dart';
import 'package:workinax/widgets/app_divider.dart';
import 'package:workinax/widgets/app_text.dart';
import 'package:workinax/widgets/edit_duration_field.dart';
import 'package:workinax/widgets/edit_time_field.dart';
import 'package:workinax/widgets/rounded_button.dart';

const clockInField = 'clock_in';
const clockOutField = 'clock_out';
const break1Field = 'break_1';
const break2Field = 'break_2';

void showEditTimeDialog(BuildContext context, WorkClock workClock) {
  showDialog(
    context: context,
    builder: (_) => EditTimeDialog(workClock: workClock),
  );
}

class EditTimeDialog extends ConsumerWidget {
  static final _formKey = GlobalKey<FormBuilderState>();

  const EditTimeDialog({super.key, required this.workClock});

  final WorkClock workClock;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const AppText(
        'Modifier mes temps',
        color: AppColor.primaryColor,
      ),
      content: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(workClock.date.formatShortDate),
            const SizedBox(
              height: 8,
            ),
            const AppDivider(),
            EditTimeField(
              name: clockInField,
              title: "J'ai embauché à",
              initialValue: _getDateTimeFromDateAndTime(
                  workClock.date, workClock.startWorkTime),
            ),
            const SizedBox(height: Insets.l),
            EditTimeField(
              name: clockOutField,
              title: "J'ai débauché à",
              initialValue: _getDateTimeFromDateAndTime(
                  workClock.date, workClock.endWorkTime),
            ),
            const SizedBox(height: Insets.l),
            EditDurationField(
              name: break1Field,
              title: "Pause 1",
              initialValue: workClock.firstBreakDuration.orZero,
            ),
            const SizedBox(height: Insets.l),
            EditDurationField(
              name: break2Field,
              title: "Pause 2",
              initialValue: workClock.secondBreakDuration.orZero,
            ),
          ],
        ),
      ),
      actions: [
        RoundedButton(
          label: 'Annuler',
          onClick: () => _onCancel(context),
        ),
        RoundedButton(
          label: 'Confirmer',
          onClick: () => _onConfirm(context, ref),
        ),
      ],
    );
  }

  _onCancel(BuildContext context) {
    Navigator.pop(context);
  }

  _onConfirm(BuildContext context, WidgetRef ref) {
    final state = _formKey.currentState;

    if (state == null || state.isValid == false) return;

    final newWC = workClock.copyWith(
      startWorkTime: (state.fields[clockInField]?.value as DateTime?)?.toTimeOfDay,
      endWorkTime: (state.fields[clockOutField]?.value as DateTime?)?.toTimeOfDay,
      firstBreakDuration: state.fields[break1Field]?.value as Duration?,
      secondBreakDuration: state.fields[break2Field]?.value as Duration?,
    );

    ref.read(workClockServiceProvider).saveWorkClock(newWC);

    Navigator.pop(context);
  }

  DateTime _getDateTimeFromDateAndTime(DateTime date, TimeOfDay? time) {
    return date.copyWith(hour: time?.hour, minute: time?.minute);
  }
}
