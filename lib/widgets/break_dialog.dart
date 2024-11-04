import 'package:flutter/material.dart';
import 'package:workinax/theme/colors.dart';
import 'package:workinax/widgets/app_outlined_button.dart';
import 'package:workinax/widgets/app_text.dart';
import 'package:workinax/widgets/rounded_button.dart';

showBreakDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => const BreakDialogContent(),
  );
}

class BreakDialogContent extends StatelessWidget {
  const BreakDialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: AppText(
          "Let's take a break ...",
          fontSizeType: FontSizeType.large,
          color: AppColor.primaryColor,
        ),
      ),
      content: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              "Commencer le minuteur de pause ?",
              fontSizeType: FontSizeType.medium,
            ),
          ],
        ),
      ),
      actions: [
        AppOutlinedButton(
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
