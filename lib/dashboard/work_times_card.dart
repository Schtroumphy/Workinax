import 'package:flutter/material.dart';
import 'package:workinax/theme/colors.dart';
import 'package:workinax/widgets/app_outlined_button.dart';
import 'package:workinax/widgets/app_text.dart';
import 'package:workinax/widgets/edit_time_dialog.dart';
import 'package:workinax/widgets/icon_column.dart';

class WorkTimesCard extends StatelessWidget {
  const WorkTimesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      color: AppColor.lightBlue,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppText(
                  'Work in progress ...',
                  fontSizeType: FontSizeType.medium,
                ),
                AppOutlinedButton(
                  label: 'Modifier',
                  onClick: () {
                    showDialog(
                      context: context,
                      builder: (_) => const EditTimeDialog(),
                    );
                  },
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconColumn(
                    icon: Icons.share_arrival_time_outlined,
                    label: '5:30',
                    subtitle: 'Effectif'),
                IconColumn(
                    icon: Icons.coffee, label: '0:15', subtitle: 'Pause'),
                IconColumn(icon: Icons.coffee, label: '_', subtitle: 'Pause'),
                IconColumn(
                    icon: Icons.hourglass_top_rounded,
                    label: '2:30',
                    subtitle: 'Restant'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
