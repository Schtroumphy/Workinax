import 'package:flutter/material.dart';
import 'package:workinax/theme/colors.dart';
import 'package:workinax/widgets/rounded_text.dart';

class HistoryRow extends StatelessWidget {
  const HistoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      margin: const EdgeInsets.only(bottom: 12),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RoundedText(
            '04/11',
            color: AppColor.lightBlue,
          ),
          ClockIn(),
          Overtime(),
          //BreakTime(),
          TotalHours(),
        ],
      ),
    );
  }
}

class IconRow extends StatelessWidget {
  const IconRow(
      {super.key,
      required this.icon,
      required this.label,
      this.color,
      this.outlined = false});

  final IconData icon;
  final String label;
  final Color? color;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(child: Icon(icon, size: 24)),
        const SizedBox(width: 4),
        Flexible(
            child: RoundedText(
          label,
          color: color,
          outlined: outlined,
        )),
      ],
    );
  }
}

class ClockIn extends StatelessWidget {
  const ClockIn({super.key});

  @override
  Widget build(BuildContext context) {
    return const IconRow(
      icon: Icons.access_time_outlined,
      label: '15:30 - 16:30',
    );
  }
}

class Overtime extends StatelessWidget {
  const Overtime({super.key});

  @override
  Widget build(BuildContext context) {
    return const IconRow(
      icon: Icons.more_time_rounded,
      label: '1:30',
      color: AppColor.lightGreen,
      outlined: true,
    );
  }
}

class BreakTime extends StatelessWidget {
  const BreakTime({super.key});

  @override
  Widget build(BuildContext context) {
    return const IconRow(
      icon: Icons.coffee_outlined,
      label: '1:10',
      outlined: true,
    );
  }
}

class TotalHours extends StatelessWidget {
  const TotalHours({super.key});

  @override
  Widget build(BuildContext context) {
    return const IconRow(
      icon: Icons.history_toggle_off_rounded,
      label: '8:00',
      outlined: true,
    );
  }
}
