import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workinax/extension/date_extension.dart';
import 'package:workinax/theme/colors.dart';
import 'package:workinax/theme/insets.dart';
import 'package:workinax/time_entry/domain/time_entry_model.dart';
import 'package:workinax/widgets/app_divider.dart';
import 'package:workinax/widgets/app_outlined_button.dart';
import 'package:workinax/widgets/app_text.dart';
import 'package:workinax/widgets/edit_time_field.dart';
import 'package:workinax/widgets/rounded_button.dart';

const dateField = 'date_field';
const clockInField = 'clock_in';
const clockOutField = 'clock_out';
const break1Field = 'break_1';
const break2Field = 'break_2';

void showEditTimeDialog(BuildContext context, TimeEntryModel timeEntry) {
  showDialog(
    context: context,
    builder: (_) => EditTimeDialog(timeEntry: timeEntry),
  );
}

class EditTimeDialog extends ConsumerWidget {
  static final _formKey = GlobalKey<FormBuilderState>();

  const EditTimeDialog({super.key, required this.timeEntry});

  final TimeEntryModel timeEntry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addTimeMode = timeEntry.id == null;

    return AlertDialog(
      title: Align(
        child: AppText(
          addTimeMode ? 'Ajouter un temps' : 'Modifier mes temps',
          color: AppColor.primaryColor,
          fontSizeType: FontSizeType.xlarge,
        ),
      ),
      content: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            addTimeMode
                ? const EditTimeField(
                    name: dateField,
                    title: "Date de saisie",
                    initialValue: null,
                    isTimeOnly: false,
                  )
                : AppText(timeEntry.startTime.formatShortDate),
            const SizedBox(
              height: 8,
            ),
            const AppDivider(),
            EditTimeField(
              name: clockInField,
              title: "J'ai embauché à",
              initialValue: addTimeMode ? null : timeEntry.startTime,
            ),
            const SizedBox(height: Insets.l),
            EditTimeField(
              name: clockOutField,
              title: "J'ai débauché à",
              initialValue: addTimeMode ? null : timeEntry.endTime,
            ),
            const SizedBox(height: Insets.l),
            // EditDurationField(
            //   name: break1Field,
            //   title: "Pause 1",
            //   initialValue: addTimeMode
            //       ? Duration.zero
            //       : timeEntry.firstBreakDuration.orZero,
            // ),
            // const SizedBox(height: Insets.l),
            // EditDurationField(
            //   name: break2Field,
            //   title: "Pause 2",
            //   initialValue: addTimeMode
            //       ? Duration.zero
            //       : timeEntry.secondBreakDuration.orZero,
            // ),
          ],
        ),
      ),
      actions: [
        AppOutlinedButton(
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

    // final newWC = timeEntry.copyWith(
    //   date: (state.fields[dateField]?.value as DateTime?),
    //   startTime:
    //       (state.fields[clockInField]?.value as DateTime?)?.toTimeOfDay,
    //   endTime:
    //       (state.fields[clockOutField]?.value as DateTime?)?.toTimeOfDay,
    //   firstBreakDuration: state.fields[break1Field]?.value as Duration?,
    //   secondBreakDuration: state.fields[break2Field]?.value as Duration?,
    // );
    //
    // ref.read(workClockServiceProvider).save(newWC);

    Navigator.pop(context);
  }
}
