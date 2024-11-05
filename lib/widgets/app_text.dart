import 'package:flutter/material.dart';
import 'package:workinax/theme/colors.dart';

class AppText extends StatelessWidget {
  const AppText(this.label, {super.key, this.color, this.fontSizeType});

  final String label;
  final Color? color;
  final FontSizeType? fontSizeType;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
          fontSize: switch (fontSizeType) {
            FontSizeType.small => 12,
            FontSizeType.medium => 14,
            FontSizeType.large => 18,
            null => 14,
          },
          color: color ?? AppColor.black,
          fontStyle: switch (fontSizeType) {
            FontSizeType.small => FontStyle.italic,
            _ => FontStyle.normal,
          }),
    );
  }
}

enum FontSizeType {
  small,
  medium,
  large,
}
