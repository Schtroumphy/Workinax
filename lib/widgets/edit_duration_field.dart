import 'package:flutter/material.dart';
import 'package:workinax/widgets/app_text.dart';
import 'package:workinax/widgets/duration_form_field.dart';

class EditDurationField extends StatefulWidget {
  const EditDurationField({super.key, required this.title});

  final String title;

  @override
  State<EditDurationField> createState() => _EditDurationFieldState();
}

class _EditDurationFieldState extends State<EditDurationField> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(widget.title),
        DurationFormField(
          name: widget.title,
          initialValue: const Duration(minutes: 15),
        ),
      ],
    );
  }
}
