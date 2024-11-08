import 'package:flutter/material.dart';
import 'package:workinax/widgets/app_text.dart';
import 'package:workinax/widgets/today_rounded.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText('Bonjour Axel  👋', fontSizeType: FontSizeType.xlarge),
        TodayRounded(),
      ],
    );
  }
}
