import 'package:flutter/material.dart';
import 'package:workinax/theme/insets.dart';
import 'package:workinax/widgets/app_text.dart';
import 'package:workinax/widgets/rounded_button.dart';

class ClockInCard extends StatelessWidget {
  const ClockInCard({super.key, required this.onClockInClick});

  final VoidCallback onClockInClick;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Card(
        elevation: Insets.m,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(Insets.l),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppText("Let's go to work !"),
              const SizedBox(height: Insets.m),
              SizedBox(
                width: double.infinity,
                child: RoundedButton(
                  label: 'Embaucher',
                  onClick: onClockInClick,
                ),
              ),
              const SizedBox(height: Insets.m),
              const AppText("Ton temps de travail sera renseigné ici."),
            ],
          ),
        ),
      ),
    );
  }
}
