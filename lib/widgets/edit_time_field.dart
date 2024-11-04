import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:workinax/widgets/app_text.dart';

class EditTimeField extends StatefulWidget {
  const EditTimeField({super.key, required this.title, this.initialValue});

  final String title;
  final DateTime? initialValue;

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
          name: widget.title,
          initialValue: widget.initialValue ?? DateTime.now(),
          initialDatePickerMode: DatePickerMode.day,
          inputType: InputType.time,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.access_time),
          ),
          keyboardType: TextInputType.datetime,
        )
      ],
    );
  }
}
