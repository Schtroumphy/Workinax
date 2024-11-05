import 'package:flutter/material.dart';
import 'package:workinax/widgets/app_text.dart';
import 'package:workinax/widgets/rounded_button.dart';

class ClockInCard extends StatelessWidget {
  const ClockInCard({super.key, required this.onClockInClick});

  final VoidCallback onClockInClick;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: AspectRatio(
        aspectRatio: 10 / 4,
        child: Card(
          elevation: 8,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppText("Let's go to work !"),
                SizedBox(
                    width: double.infinity,
                    child: RoundedButton(
                      label: 'Embaucher',
                      onClick: onClockInClick,
                    )),
                const AppText("Ton temps de travail sera renseigné ici."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
