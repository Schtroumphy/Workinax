import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workinax/dashboard/widgets/history_item.dart';
import 'package:workinax/data/database_helper.dart';
import 'package:workinax/extension/date_extension.dart';
import 'package:workinax/model/work_clock.dart';
import 'package:workinax/theme/colors.dart';
import 'package:workinax/theme/insets.dart';
import 'package:workinax/widgets/app_divider.dart';
import 'package:workinax/widgets/app_outlined_button.dart';
import 'package:workinax/widgets/app_text.dart';
import 'package:workinax/widgets/async_value_widget.dart';
import 'package:workinax/widgets/edit_time_dialog.dart';
import 'package:workinax/widgets/rounded_button.dart';

class Historic extends ConsumerWidget {
  const Historic({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workClocks = ref.watch(getAllProvider);

    return Column(
      children: [
        const AppDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const AppText('Historique', fontSizeType: FontSizeType.large),
            AppClickableText(
                label: '+ Ajouter une saisie',
                onClick: () => _onAddWorkClockClick(context)),
          ],
        ),
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
            return ListView.builder(
              shrinkWrap: true,
              itemCount: workClocks.length,
              itemBuilder: (context, index) {
                final current = workClocks[index];
                return Dismissible(
                    key: Key(current.id?.toString() ?? ''),
                    background: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.red[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.delete,
                            size: 40,
                            color: Color(0xffffffff),
                          ),
                        ],
                      ),
                    ),
                    confirmDismiss: (_) async {
                      final current = workClocks[index];
                      /** TODO UNCOMMENT
                       * if (current.date.formatShortDate ==
                          DateTime.now().formatShortDate) {

                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: AppColor.primaryColor,
                          content: Text("Tu ne peux pas supprimer la saisie du jour"),
                          ));
                          return false;
                          } // Do not allow today workClock deletion
                       */

                      final shouldDismiss =
                          await _onDismiss(context, ref, current);
                      return shouldDismiss ?? false;
                    },
                    child: HistoryItem(current));
              },
            );
          },
        ),
      ],
    );
  }

  _onAddWorkClockClick(BuildContext context) {
    showEditTimeDialog(context, WorkClock.newOne());
  }

  Future<bool?> _onDismiss(
      BuildContext context, WidgetRef ref, WorkClock workClock) async {
    return await showRemoveDialog(context, ref, workClock.id);
  }
}

Future<bool?> showRemoveDialog(
    BuildContext context, WidgetRef ref, int? workClockId) async {
  return await showDialog<bool?>(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text('Supprimer le temps saisi ?'),
              content: const Text(
                  'Toute suppression est irréversible. Êtes-vous sûr de vouloir supprimer cette entrée ?'),
              actions: [
                AppOutlinedButton(
                  label: 'Annuler',
                  onClick: () {
                    Navigator.pop(context, false);
                  },
                ),
                RoundedButton(
                  label: 'Confirmer',
                  onClick: workClockId == null
                      ? null
                      : () {
                          ref
                              .read(workClockServiceProvider)
                              .deleteById(workClockId);
                          Navigator.pop(context, true);
                        },
                ),
              ],
            );
          }) ??
      false;
}

class AppClickableText extends StatelessWidget {
  const AppClickableText(
      {super.key, required this.label, required this.onClick});

  final String label;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(10),
      highlightColor: AppColor.lightBlue,
      child: Padding(
        padding: const EdgeInsets.all(Insets.m),
        child: AppText(
          label,
          color: AppColor.primaryColor,
        ),
      ),
    );
  }
}
