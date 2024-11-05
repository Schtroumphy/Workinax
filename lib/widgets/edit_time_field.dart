import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:workinax/core/constants/app_date_format.dart';
import 'package:workinax/widgets/app_text.dart';

class EditTimeField extends StatefulWidget {
  const EditTimeField(
      {super.key,
      required this.title,
      this.initialValue,
      required this.name,
      this.isTimeOnly = true});

  final String name;
  final String title;
  final DateTime? initialValue;
  final bool isTimeOnly;

  @override
  State<EditTimeField> createState() => _EditTimeFieldState();
}

class _EditTimeFieldState extends State<EditTimeField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(widget.title),
        FormBuilderDateTimePicker(
          name: widget.name,
          initialValue: widget.initialValue,
          initialDatePickerMode: DatePickerMode.day,
          initialTime: TimeOfDay.now(),
          timePickerInitialEntryMode: TimePickerEntryMode.input,
          format: widget.isTimeOnly
              ? AppDateFormat.shortHourMinute
              : AppDateFormat.mediumDateFormat,
          inputType: widget.isTimeOnly ? InputType.time : InputType.date,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            prefixIcon: Icon(widget.isTimeOnly
                ? Icons.access_time
                : Icons.calendar_today_rounded),
          ),
          keyboardType: TextInputType.datetime,
        )
      ],
    );
  }
}
