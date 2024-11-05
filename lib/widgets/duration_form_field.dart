import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:workinax/widgets/timer.dart';

class DurationFormField extends FormBuilderField<Duration> {
  DurationFormField({
    super.key,
    required super.name,
    super.initialValue,
    FormFieldValidator<Duration>? validator,
    ValueChanged<Duration?>? onChanged,
  }) : super(
          builder: (FormFieldState<Duration> field) {
            return InkWell(
              onTap: () async {
                Duration? result = await showDurationPicker(
                  context: field.context,
                  baseUnit: BaseUnit.minute,
                  initialTime: field.value ?? Duration.zero,
                );
                if (result != null) {
                  field.didChange(result);
                }
              },
              child: InputDecorator(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.hourglass_top_rounded),
                  errorText: field.errorText,
                ),
                child: Text(
                  field.value != null
                      ? "${field.value!.inMinutes} min ${field.value!.inSeconds % 60} s"
                      : "Choisissez une durée",
                ),
              ),
            );
          },
        );
}
