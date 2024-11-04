import 'package:flutter/material.dart';
import 'package:workinax/widgets/app_text.dart';

class IconColumn extends StatelessWidget {
  const IconColumn({super.key, this.icon, required this.label, this.subtitle});

  final IconData? icon;
  final String label;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon ?? Icons.timelapse_outlined),
        const SizedBox(height: 4),
        AppText(subtitle ?? 'Effectif', color: Colors.grey, fontSizeType: FontSizeType.small,),
        AppText(label),
      ],
    );
  }
}
