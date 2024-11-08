import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workinax/extension/date_extension.dart';
import 'package:workinax/theme/colors.dart';
import 'package:workinax/theme/insets.dart';
import 'package:workinax/time_entry/domain/time_entry_model.dart';
import 'package:workinax/time_entry/presentation/historic/historic_controller.dart';
import 'package:workinax/time_entry/widgets/history_item.dart';
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
    final entries = ref.watch(historicControllerProvider);

    return Column(
      children: [
        const AppDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const AppText('Historique', fontSizeType: FontSizeType.xlarge),
            AppClickableText(
                label: '+ Ajouter une saisie',
                onClick: () => _onAddWorkClockClick(context)),
          ],
        ),
        const SizedBox(height: 16),
        AsyncValueWidget(
          value: entries,
          data: (timeEntries) {
            if (timeEntries.isEmpty) {
              return const AppText(
                'Pas encore de données ...',
                color: Colors.grey,
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: timeEntries.length,
              itemBuilder: (context, index) {
                final current = timeEntries[index];
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
                      final current = timeEntries[index];
                      if (current.startTime.formatShortDate ==
                          DateTime.now().formatShortDate) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: AppColor.primaryColor,
                          content: Text(
                              "Tu ne peux pas supprimer la saisie du jour"),
                        ));
                        return false;
                      } // Do not allow today workClock deletion

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
    showEditTimeDialog(context, TimeEntryModel.init());
  }

  Future<bool?> _onDismiss(
      BuildContext context, WidgetRef ref, TimeEntryModel timeEntry) async {
    return await showRemoveDialog(context, ref, timeEntry.id);
  }
}

Future<bool?> showRemoveDialog(
    BuildContext context, WidgetRef ref, int? entryId) async {
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
                  onClick: entryId == null
                      ? null
                      : () {
                          ref
                              .read(historicControllerProvider.notifier)
                              .delete(entryId);
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
