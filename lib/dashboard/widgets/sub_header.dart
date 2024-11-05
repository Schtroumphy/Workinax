import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workinax/dashboard/widgets/action_button_row.dart';
import 'package:workinax/dashboard/widgets/clock_in_card.dart';
import 'package:workinax/data/database_helper.dart';
import 'package:workinax/model/mode_type.dart';

class ActionHeader extends ConsumerWidget {
  const ActionHeader({
    super.key,
    required this.mode,
    required this.onClockInClick,
    required this.onClockOutClick,
    required this.onBreakInClick,
    required this.onBreakOutClick,
  });

  final ModeType mode;
  final VoidCallback onClockInClick;
  final VoidCallback onClockOutClick;
  final VoidCallback onBreakInClick;
  final Function({required bool isSecondBreak}) onBreakOutClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayWC = ref.watch(getTodayWorkClockProvider);
    return switch (mode) {
      ModeType.notStarted => ClockInCard(onClockInClick: onClockInClick),
      ModeType.workInProgress => ActionButtonRow(
          firstButtonLabel: 'Prendre une pause',
          onBreakClick: onBreakInClick,
          secondButtonLabel: 'Débaucher',
          onClockOutClick: onClockOutClick,
        ),
      ModeType.breakInProgress => ActionButtonRow(
          firstButtonLabel: 'Reprendre le travail',
          onBreakClick: () => onBreakOutClick(
            isSecondBreak: todayWC.valueOrNull?.firstBreakDuration != null,
          ),
        ),
      ModeType.workEnd => const SizedBox.shrink(),
    };
  }
}
