import 'package:flutter/material.dart';
import 'package:workinax/theme/insets.dart';

import '../theme/colors.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({super.key, required this.label, this.onClick});

  final String label;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onClick,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: Insets.m),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.white,
        side: const BorderSide(color: AppColor.primaryColor, width: 1), //<-- SEE HERE
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          color: AppColor.primaryColor,
        ),
      ),
    );
  }
}