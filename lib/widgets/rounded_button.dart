
import 'package:flutter/material.dart';
import 'package:workinax/theme/colors.dart';
import 'package:workinax/widgets/app_text.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({super.key, required this.label, this.onClick});

  final String label;
  final VoidCallback? onClick;

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
      onPressed: onClick,
      child: AppText(
        label,
        color: Colors.white,
      ),
    );
  }
}