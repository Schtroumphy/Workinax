import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workinax/theme/colors.dart';
import 'package:workinax/widgets/app_outlined_button.dart';
import 'package:workinax/widgets/app_text.dart';
import 'package:workinax/widgets/rounded_button.dart';

Future<bool?> showBreakDialog(BuildContext context, {bool isBreakIn = false}) {
  return showDialog<bool>(
    context: context,
    builder: (_) => BreakDialogContent(
      isBreakIn: isBreakIn,
    ),
  );
}

class BreakDialogContent extends ConsumerWidget {
  const BreakDialogContent({super.key, this.isBreakIn = true});

  final bool isBreakIn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final duration = ref.read(timerNotifierProvider).formatShortDuration;
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
