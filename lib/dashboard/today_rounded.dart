import 'package:flutter/material.dart';
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
      child: const Row(
        children: [
          Icon(
            Icons.date_range,
            color: Colors.white,
          ),
          SizedBox(width: 4),
          Text(
            'Lun 4 Nov, 2024',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
