import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:workinax/core/constants/app_date_format.dart';
import 'package:workinax/widgets/app_text.dart';

class EditTimeField extends StatelessWidget {
  const EditTimeField({
    super.key,
    required this.title,
    this.initialValue,
    required this.name,
    this.isTimeOnly = true,
    this.required = true,
    this.condition,
    this.validator,
    this.onChanged,
  });

  final String name;
  final String title;
  final DateTime? initialValue;
  final bool isTimeOnly;
  final bool required;
  final bool Function(DateTime?)? condition;
  final String? Function(DateTime?)? validator;
  final Function(DateTime?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(title),
        FormBuilderDateTimePicker(
          name: name,
          initialValue: initialValue,
          initialDatePickerMode: DatePickerMode.day,
          initialTime: TimeOfDay.now(),
          timePickerInitialEntryMode: TimePickerEntryMode.input,
          onChanged: onChanged,
          format: isTimeOnly
              ? AppDateFormat.shortHourMinute
              : AppDateFormat.mediumDateFormat,
          inputType: isTimeOnly ? InputType.time : InputType.date,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            prefixIcon: Icon(
                isTimeOnly ? Icons.access_time : Icons.calendar_today_rounded),
          ),
          keyboardType: TextInputType.datetime,
          validator: FormBuilderValidators.compose([
            if (required)
              FormBuilderValidators.required(
                  errorText: 'Le champs est obligatoire'),
            if (condition != null)
              FormBuilderValidators.conditional(
                condition!,
                validator ?? (_) => 'La date saisie est invalide',
              )
          ]),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofocus: false,
        )
      ],
    );
  }
}
