import 'package:flutter/material.dart';
import 'package:workinax/theme/insets.dart';
import 'package:workinax/widgets/app_outlined_button.dart';
import 'package:workinax/widgets/rounded_button.dart';

class ActionButtonRow extends StatelessWidget {
  const ActionButtonRow({
    super.key,
    this.onBreakClick,
    this.onClockOutClick,
    required this.firstButtonLabel,
    this.secondButtonLabel,
  });

  final String firstButtonLabel;
  final VoidCallback? onBreakClick;
  final String? secondButtonLabel;
  final VoidCallback? onClockOutClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: RoundedButton(
          label: firstButtonLabel,
          onClick: onBreakClick,
        )),
        if (secondButtonLabel != null) ...[
          const SizedBox(width: Insets.m),
          Expanded(
            child: AppOutlinedButton(
              label: secondButtonLabel!,
              onClick: onClockOutClick,
            ),
          ),
        ]
      ],
    );
  }
}
