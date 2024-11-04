import 'package:flutter/material.dart';
import 'package:workinax/theme/colors.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 18.0),
      child: SizedBox(
        height: 1,
        width: 50,
        child: ColoredBox(color: AppColor.primaryColor),
      ),
    );
  }
}