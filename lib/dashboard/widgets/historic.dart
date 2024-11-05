import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workinax/dashboard/widgets/history_item.dart';
import 'package:workinax/data/database_helper.dart';
import 'package:workinax/widgets/app_divider.dart';
import 'package:workinax/widgets/app_text.dart';
import 'package:workinax/widgets/async_value_widget.dart';

class Historic extends ConsumerWidget {
  const Historic({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workClocks = ref.watch(getAllProvider);

    return Column(
      children: [
        const AppDivider(),
        const AppText('Historique', fontSizeType: FontSizeType.large),
        const SizedBox(height: 16),
        AsyncValueWidget(
            value: workClocks,
            data: (workClocks) {
              if (workClocks.isEmpty) {
                return const AppText(
                  'No data yet',
                  color: Colors.grey,
                );
              }
              return Column(
                children: [
                  for (var workClock in workClocks) HistoryItem(workClock)
                ],
              );
            }),
      ],
    );
  }
}
