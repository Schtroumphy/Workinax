import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workinax/theme/insets.dart';
import 'package:workinax/time_entry/domain/mode_type.dart';
import 'package:workinax/time_entry/presentation/dashboard/dashboard_controller.dart';
import 'package:workinax/time_entry/presentation/historic/historic.dart';
import 'package:workinax/time_entry/presentation/times_card.dart';
import 'package:workinax/time_entry/widgets/header.dart';
import 'package:workinax/time_entry/widgets/sub_header.dart';
import 'package:workinax/widgets/app_divider.dart';
import 'package:workinax/widgets/app_image.dart';
import 'package:workinax/widgets/async_value_widget.dart';
import 'package:workinax/widgets/break_dialog.dart';
import 'package:workinax/widgets/timer.dart';

class DashboardContent extends ConsumerStatefulWidget {
  const DashboardContent({super.key});

  @override
  ConsumerState<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends ConsumerState<DashboardContent> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardControllerProvider);

    return AsyncValueWidget(
      value: state,
      data: (state) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            const AppDivider(),
            ActionHeader(
              mode: state.modeType,
              allowBreak: (state.timeEntryModel?.breaks.length ?? 0) < 2,
              onClockInClick: _onClockInClick,
              onClockOutClick: _onClockOutClick,
              onBreakInClick: _onBreakInClick,
              onBreakOutClick: _onBreakOutClick,
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            if (state.modeType != ModeType.notStarted) ...const [
              AsyncWorkTimesCard(),
              SizedBox(height: 16),
            ],
            if (state.timeEntryModel?.endTime == null &&
                state.modeType.isWorking) ...[
              const SizedBox(height: Insets.l),
              TimerFromStartTime(
                startTime: state.modeType != ModeType.breakInProgress
                    ? state.timeEntryModel?.startTime
                    : state.timeEntryModel?.breaks.last.startTime,
                outlined: state.modeType == ModeType.breakInProgress,
              )
            ],
            if (!state.modeType.isWorking) const Historic(),
            const SizedBox(height: Insets.xxl),
            AppImage(mode: state.modeType),
          ],
        ),
      ),
    );
  }

  _onBreakInClick() async {
    final result = await showBreakDialog(context, isBreakIn: true);
    if (result == true) {
      ref.read(dashboardControllerProvider.notifier).onBreakIn();
    }
  }

  _onBreakOutClick({bool isSecondBreak = false}) async {
    final result = await showBreakDialog(context);
    if (result == true) {
      ref.read(dashboardControllerProvider.notifier).onBreakOut();
    }
  }

  _onClockInClick() {
    ref.read(dashboardControllerProvider.notifier).onClockIn();
  }

  _onClockOutClick() {
    ref.read(dashboardControllerProvider.notifier).onClockOut();
  }
}
