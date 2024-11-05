import 'package:flutter/material.dart';
import 'package:workinax/widgets/app_text.dart';

class RoundedText extends StatelessWidget {
  const RoundedText(this.label, {super.key, this.color, this.outlined = false, this.textColor});

  final String label;
  final Color? color;
  final Color? textColor;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: outlined ? Colors.transparent : color ?? Colors.grey.withOpacity(0.3),
        border: outlined ? Border.all(color: color ?? Colors.grey.withOpacity(0.3), width: 1) : Border.all(color: Colors.transparent)
      ),
      child: AppText(
        label,
        fontSizeType: FontSizeType.medium,
        color: textColor ?? Colors.black,
      ),
    );
  }
}
