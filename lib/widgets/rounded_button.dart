
import 'package:flutter/material.dart';
import 'package:workinax/theme/colors.dart';
import 'package:workinax/widgets/app_text.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: AppColor.primaryColor,
      ),
      child: AppText(
        label,
        color: Colors.white,
      ),
      onPressed: () {},
    );
  }
}