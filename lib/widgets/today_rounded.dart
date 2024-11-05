import 'package:flutter/material.dart';
import 'package:workinax/extension/date_extension.dart';
import 'package:workinax/theme/colors.dart';

class TodayRounded extends StatelessWidget {
  const TodayRounded({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.primaryColor,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.date_range,
            color: Colors.white,
          ),
          const SizedBox(width: 4),
          Text(
            DateTime.now().formatShortDate,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
