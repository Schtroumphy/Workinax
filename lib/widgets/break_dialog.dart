import 'package:flutter/material.dart';
import 'package:workinax/extension/date_extension.dart';
import 'package:workinax/theme/colors.dart';
import 'package:workinax/widgets/app_outlined_button.dart';
import 'package:workinax/widgets/app_text.dart';
import 'package:workinax/widgets/rounded_button.dart';

Future<bool?> showBreakDialog(
    BuildContext context, { bool isBreakIn = false, TimeOfDay? breakStartTime}) {
  return showDialog<bool>(
    context: context,
    builder: (_) => BreakDialogContent(
      isBreakIn: isBreakIn, breakStartTime: breakStartTime,
    ),
  );
}

class BreakDialogContent extends StatelessWidget {
  const BreakDialogContent({super.key, this.isBreakIn = true, required this.breakStartTime});

  final bool isBreakIn;
  final TimeOfDay? breakStartTime;

  @override
  Widget build(BuildContext context) {
    final breakDuration = [TimeOfDay.now(), breakStartTime].formatHoursDiff;

    return AlertDialog(
      title: Center(
        child: AppText(
          isBreakIn ? "Let's take a break ..." : "Let's go back to work",
          fontSizeType: FontSizeType.large,
          color: AppColor.primaryColor,
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              "${isBreakIn ? 'Commencer' : 'Arrêter'} le minuteur de pause ?",
              fontSizeType: FontSizeType.medium,
            ),
            if(!isBreakIn) AppText(
              "Temps de pause effectif : $breakDuration",
              fontSizeType: FontSizeType.medium,
            ),
          ],
        ),
      ),
      actions: [
        AppOutlinedButton(
          label: 'Annuler',
          onClick: () {
            Navigator.pop(context, false);
          },
        ),
        RoundedButton(
          label: 'Confirmer',
          onClick: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }
}
