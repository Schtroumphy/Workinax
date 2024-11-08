import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workinax/widgets/app_text.dart';

class IconColumn extends StatelessWidget {
  const IconColumn(
      {super.key, this.iconPath, required this.label, this.subtitle});

  final String? iconPath;
  final String label;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          iconPath ?? 'assets/icons/coffee.svg',
          width: 25,
          height: 25,
        ),
        AppText(
          subtitle ?? 'Effectif',
          color: Colors.grey,
          fontSizeType: FontSizeType.small,
        ),
        const SizedBox(height: 4),
        AppText(label),
      ],
    );
  }
}
