import 'package:flutter/material.dart';
import 'package:workinax/widgets/app_outlined_button.dart';
import 'package:workinax/widgets/rounded_button.dart';

class ActionButtonRow extends StatelessWidget {
  const ActionButtonRow({super.key, this.onBreakClick, this.onClockOutClick});

  final VoidCallback? onBreakClick;
  final VoidCallback? onClockOutClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: RoundedButton(
          label: 'Prendre une pause',
          onClick: onBreakClick,
        )),
        const SizedBox(width: 8),
        Expanded(
            child: AppOutlinedButton(
          label: 'Débaucher',
              onClick: onClockOutClick,
        )),
      ],
    );
  }
}
