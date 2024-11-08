import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workinax/time_entry/domain/mode_type.dart';
import 'package:workinax/time_entry/widgets/action_button_row.dart';
import 'package:workinax/time_entry/widgets/clock_in_card.dart';

class ActionHeader extends ConsumerWidget {
  const ActionHeader({
    super.key,
    required this.mode,
    this.allowBreak = true,
    required this.onClockInClick,
    required this.onClockOutClick,
    required this.onBreakInClick,
    required this.onBreakOutClick,
  });

  final ModeType mode;
  final bool allowBreak;
  final VoidCallback onClockInClick;
  final VoidCallback onClockOutClick;
  final VoidCallback onBreakInClick;
  final VoidCallback onBreakOutClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (mode) {
      ModeType.notStarted => ClockInCard(onClockInClick: onClockInClick),
      ModeType.workInProgress => ActionButtonRow(
          firstButtonLabel: allowBreak ? 'Prendre une pause' : null,
          onBreakClick: onBreakInClick,
          secondButtonLabel: 'Débaucher',
          onClockOutClick: onClockOutClick,
        ),
      ModeType.breakInProgress => ActionButtonRow(
          firstButtonLabel: 'Reprendre le travail',
          onBreakClick: onBreakOutClick,
        ),
      ModeType.workEnd => const SizedBox.shrink(),
    };
  }
}
