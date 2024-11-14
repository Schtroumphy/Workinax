import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workinax/extensions/date_extension.dart';
import 'package:workinax/extensions/duration_extension.dart';
import 'package:workinax/extensions/time_of_day_extension.dart';
import 'package:workinax/theme/colors.dart';
import 'package:workinax/theme/insets.dart';
import 'package:workinax/time_entry/domain/time_entry_model.dart';
import 'package:workinax/time_entry/presentation/historic/historic.dart';
import 'package:workinax/widgets/app_divider.dart';
import 'package:workinax/widgets/app_outlined_button.dart';
import 'package:workinax/widgets/app_text.dart';
import 'package:workinax/widgets/edit_duration_field.dart';
import 'package:workinax/widgets/edit_time_controller.dart';
import 'package:workinax/widgets/edit_time_field.dart';
import 'package:workinax/widgets/rounded_button.dart';

const dateField = 'date_field';
const clockInField = 'clock_in';
const clockOutField = 'clock_out';
const int maxBreakNumber = 2;

void showEditTimeDialog(BuildContext context, TimeEntryModel model) {
  showDialog(
    context: context,
    builder: (_) => EditTimeDialog(model: model),
  );
}

class EditTimeDialog extends ConsumerStatefulWidget {
  static final _formKey = GlobalKey<FormBuilderState>();

  const EditTimeDialog({super.key, required this.model});

  final TimeEntryModel model;

  @override
  ConsumerState<EditTimeDialog> createState() => _EditTimeDialogState();
}

class _EditTimeDialogState extends ConsumerState<EditTimeDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addTimeMode = widget.model.id == null;
    final state = ref.watch(editTimeControllerProvider(widget.model));

    return AlertDialog(
      title: Align(
        child: AppText(
          addTimeMode ? 'Ajouter un temps' : 'Modifier mes temps',
          color: AppColor.primaryColor,
          fontSizeType: FontSizeType.xlarge,
        ),
      ),
      content: SingleChildScrollView(
        child: FormBuilder(
          key: EditTimeDialog._formKey,
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
                  : AppText(widget.model.startTime.formatFrShortDate),
              const SizedBox(height: 8),
              const AppDivider(),
              EditTimeField(
                name: clockInField,
                title: "J'ai embauché à",
                initialValue: addTimeMode ? null : widget.model.startTime,
                onChanged: (date) => ref
                    .read(editTimeControllerProvider(widget.model).notifier)
                    .onStartTimeChange(date),
              ),
              const SizedBox(height: Insets.l),
              EditTimeField(
                name: clockOutField,
                title: "J'ai débauché à",
                initialValue: addTimeMode ? null : widget.model.endTime,
                condition: (date) =>
                    isEndDateIsAfterStart(date, state.timeEntry?.startTime),
              ),
              const SizedBox(height: Insets.l),
              for (var i = 0; i < state.breaks.length; i++) ...[
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          EditTimeField(
                            name: 'break_start_$i',
                            title: "Début pause $i",
                            initialValue: state.breaks[i].startTime,
                            required: true,
                          ),
                          const SizedBox(height: Insets.m),
                          EditDurationField(
                            name: 'break_duration_$i',
                            title: "Durée pause $i",
                            initialValue: state.breaks[i].duration.orZero,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _onDeleteBreak(i),
                    ),
                  ],
                ),
                const SizedBox(height: Insets.l),
              ],
              if (state.breaks.length < maxBreakNumber) ...[
                const SizedBox(height: Insets.l),
                AppClickableText(
                  label: '+ Ajouter une pause',
                  onClick: _onAddBreakClick,
                ),
              ]
            ],
          ),
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

  bool isEndDateIsAfterStart(DateTime? endDate, DateTime? startDate) {
    final applyValidator = startDate != null &&
        endDate != null &&
        !endDate.toTimeOfDay.isAfter(startDate.toTimeOfDay);
    return applyValidator;
  }

  void _onAddBreakClick() {
    ref.read(editTimeControllerProvider(widget.model).notifier).addBreak();
  }

  void _onDeleteBreak(int index) {
    ref
        .read(editTimeControllerProvider(widget.model).notifier)
        .deleteBreak(index);
  }

  _onCancel(BuildContext context) {
    Navigator.pop(context);
  }

  _onConfirm(BuildContext context, WidgetRef ref) {
    final state = EditTimeDialog._formKey.currentState;
    if (state == null) return;

    state.validate();

    if (!state.isValid) return;

    // Save fields if valid
    state.save();
    final values = state.value;

    ref.read(editTimeControllerProvider(widget.model).notifier).save(values);

    Navigator.pop(context);
  }
}
