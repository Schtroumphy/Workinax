import 'package:flutter/material.dart';
import 'package:workinax/theme/colors.dart';
import 'package:workinax/theme/insets.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: Insets.m),
      child: SizedBox(
        height: 1,
        width: 50,
        child: ColoredBox(color: AppColor.primaryColor),
      ),
    );
  }
}