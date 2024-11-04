import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:workinax/theme/colors.dart';
import 'package:workinax/widgets/app_text.dart';
import 'package:workinax/widgets/edit_duration_field.dart';
import 'package:workinax/widgets/edit_time_field.dart';
import 'package:workinax/widgets/rounded_button.dart';

class EditTimeDialog extends StatelessWidget {
  static final _formKey = GlobalKey<FormBuilderState>();

  const EditTimeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const AppText(
        'Modifier mes temps',
        color: AppColor.primaryColor,
      ),
      content: FormBuilder(
        key: _formKey,
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EditTimeField(
              title: "J'ai embauché à",
            ),
            SizedBox(height: 16),
            EditTimeField(
              title: "J'ai débauché à",
            ),
            SizedBox(height: 16),
            EditDurationField(
              title: "Pause 1",
            ),
            SizedBox(height: 16),
            EditDurationField(
              title: "Pause 2",
            ),
          ],
        ),
      ),
      actions: [
        RoundedButton(
          label: 'Annuler',
          onClick: () {
            Navigator.pop(context);
          },
        ),
        RoundedButton(
          label: 'Confirmer',
          onClick: () {},
        ),
      ],
    );
  }
}

extension TOD on TimeOfDay {
  DateTime toDateTime() {
    return DateTime(1, 1, 1, hour, minute);
  }
}
