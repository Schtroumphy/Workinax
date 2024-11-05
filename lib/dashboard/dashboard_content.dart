import 'package:flutter/material.dart';
import 'package:workinax/dashboard/widgets/header.dart';
import 'package:workinax/dashboard/widgets/historic.dart';
import 'package:workinax/dashboard/widgets/sub_header.dart';
import 'package:workinax/data/database_helper.dart';
import 'package:workinax/model/mode_type.dart';
import 'package:workinax/model/work_clock.dart';
import 'package:workinax/widgets/app_divider.dart';
import 'package:workinax/widgets/app_image.dart';
import 'package:workinax/widgets/break_dialog.dart';
import 'package:workinax/dashboard/widgets/work_times_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardContent extends ConsumerStatefulWidget {
  const DashboardContent({super.key});

  @override
  ConsumerState<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends ConsumerState<DashboardContent> {
  late ModeType mode;
  List<WorkClock> workClocks = [];
  TimeOfDay? breakStart;

  changeMode(ModeType targetMode) {
    setState(() {
      mode = targetMode;
    });
  }

  setBreakStart({bool reset = false}) {
    setState(() {
      breakStart = reset ? null : TimeOfDay.now();
    });
  }

  @override
  void initState() {
    mode = ModeType.notStarted;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(getTodayWorkClockProvider, _onListen);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header(),
          const AppDivider(),
          ActionHeader(
            mode: mode,
            onClockInClick: _onClockInClick,
            onClockOutClick: _onClockOutClick,
            onBreakInClick: _onBreakInClick,
            onBreakOutClick: _onBreakOutClick,
          ),
          const SizedBox(height: 16),
          if (mode != ModeType.notStarted) ...[
            const AsyncWorkTimesCard(),
            const SizedBox(height: 16),
          ],
          if (!mode.isWorking) const Historic(),
          AppImage(mode: mode),
        ],
      ),
    );
  }

  _onBreakInClick() async {
    final result = await showBreakDialog(context, isBreakIn: true);
    if (result == true) {
      setBreakStart();
      changeMode(ModeType.breakInProgress);
    }
  }

  _onBreakOutClick({bool isSecondBreak = false}) async {
    final result = await showBreakDialog(context, breakStartTime: breakStart);
    if (result == true) {
      ref.read(workClockServiceProvider).setBreak(breakStart, isSecondBreak);
    }
    setBreakStart(reset: true);
    changeMode(ModeType.workInProgress);
  }

  _onClockInClick() {
    changeMode(ModeType.workInProgress);
    ref.read(workClockServiceProvider).saveWorkClock(WorkClock.init());
  }

  _onClockOutClick() {
    changeMode(ModeType.workEnd);
    ref.read(workClockServiceProvider).setWorkEnd();
  }

  _onListen(AsyncValue<WorkClock?>? previous, AsyncValue<WorkClock?> next) {
    if (!next.isLoading && next.valueOrNull != null && mode != ModeType.workEnd) { //
      changeMode(next.valueOrNull?.endWorkTime != null
          ? ModeType.workEnd
          : ModeType.workInProgress);
    }
  }
}
