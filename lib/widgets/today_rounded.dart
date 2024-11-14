import 'package:flutter/material.dart';
import 'package:workinax/extensions/date_extension.dart';
import 'package:workinax/theme/colors.dart';
import 'package:workinax/theme/insets.dart';

class TodayRounded extends StatelessWidget {
  const TodayRounded({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: Insets.m, vertical: Insets.xs),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(color: AppColor.primaryColor)),
      child: Row(
        children: [
          const Icon(
            Icons.date_range,
            color: AppColor.primaryColor,
            size: Insets.l,
          ),
          const SizedBox(width: 4),
          Text(
            DateTime.now().formatFrShortDate,
            style: const TextStyle(color: AppColor.primaryColor),
          ),
        ],
      ),
    );
  }
}
