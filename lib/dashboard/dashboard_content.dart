import 'package:flutter/material.dart';
import 'package:workinax/data/database_helper.dart';
import 'package:workinax/extension/time_of_day_extension.dart';
import 'package:workinax/model/mode_type.dart';
import 'package:workinax/dashboard/action_button_row.dart';
import 'package:workinax/model/work_clock.dart';
import 'package:workinax/widgets/app_divider.dart';
import 'package:workinax/widgets/app_text.dart';
import 'package:workinax/widgets/break_dialog.dart';
import 'package:workinax/dashboard/clock_in_card.dart';
import 'package:workinax/dashboard/history_item.dart';
import 'package:workinax/dashboard/today_rounded.dart';
import 'package:workinax/dashboard/work_times_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workinax/widgets/timer.dart';

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
    final workClocks = ref.watch(getAllProvider);
    final todayWC = ref.watch(getTodayWorkClockProvider);

    ref.listen(getTodayWorkClockProvider, (previous, next) {
      if (!next.isLoading && next.valueOrNull != null && mode != ModeType.workEnd) {
        changeMode(ModeType.workInProgress);
      }
    });

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText('Bonjour Axel  👋', fontSizeType: FontSizeType.large),
              TodayRounded(),
            ],
          ),
          const AppDivider(),
          switch (mode) {
            ModeType.notStarted => ClockInCard(onClockInClick: _onClockInClick),
            ModeType.workInProgress => ActionButtonRow(
                firstButtonLabel: 'Prendre une pause',
                onBreakClick: () => _onBreakInClick(context),
                secondButtonLabel: 'Débaucher',
                onClockOutClick: _onClockOutClick,
              ),
            ModeType.breakInProgress => ActionButtonRow(
                firstButtonLabel: 'Reprendre le travail',
                onBreakClick: () => _onBreakOutClick(context,
                    isSecondBreak:
                        todayWC.valueOrNull?.firstBreakDuration != null),
              ),
            ModeType.workEnd =>
              const SizedBox.shrink(),
          },
          const SizedBox(height: 16),
          if (mode != ModeType.notStarted)
            todayWC.when(
              data: (wc) => AspectRatio(
                aspectRatio: 10 / 4,
                child: WorkTimesCard(workClock: wc),
              ),
              error: (e, _) => const Text('No data yet'),
              loading: () => const CircularProgressIndicator(),
            ),
          const SizedBox(height: 16),
          if (!mode.isWorking) ...[
            const AppText('Historique', fontSizeType: FontSizeType.large),
            const SizedBox(height: 16),
            workClocks.when(
              data: (wc) {
                if(wc.isEmpty) return const AppText('No data yet', color: Colors.grey,);
                return Column(
                  children: [for (var workClock in wc) HistoryItem(workClock)],
                );
              },
              error: (_, __) => const AppText(
                'Error retrieving data !',
                color: Colors.grey,
              ),
              loading: () => const Text("Data is loading..."),
            ),
          ],
          if (mode == ModeType.workInProgress)
            AspectRatio(
              aspectRatio: 4 / 5,
              child: Image.asset('assets/images/working_rounded.png'),
            ),
          if (mode == ModeType.breakInProgress) ...[
            AspectRatio(
              aspectRatio: 4 / 5,
              child: Image.asset('assets/images/coffee.png'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppText('Durée de la pause '),
                const SizedBox(
                  width: 8,
                ),
                TimerFromStartTime(
                  startTime: TimeOfDay.now(),
                )
              ],
            )
          ]
        ],
      ),
    );
  }

  _onBreakInClick(BuildContext context) async {
    final result = await showBreakDialog(context, true);
    if (result == true) {
      setBreakStart();
      changeMode(ModeType.breakInProgress);
    }
  }

  _onBreakOutClick(BuildContext context, {bool isSecondBreak = false}) async {
    final result = await showBreakDialog(
      context,
      false,
      breakStartTime: breakStart,
    );
    if (result == true) {
      final breakTime = differenceInMinutes(TimeOfDay.now(), breakStart ?? TimeOfDay.now());
      ref.read(workClockServiceProvider).updateWorkClock(
          date: DateTime.now(),
          firstBreakStart: isSecondBreak ? null : breakTime,
          secondBreakStart: isSecondBreak ? breakTime : null);
    }
    setBreakStart(reset: true);
    changeMode(ModeType.workInProgress);
  }

  _onClockInClick() {
    changeMode(ModeType.workInProgress);

    // Save clock in in db
    ref.read(workClockServiceProvider).insertWorkClock(WorkClock.init());
  }

  _onClockOutClick() {
    changeMode(ModeType.workEnd);
    ref
        .read(workClockServiceProvider)
        .updateWorkClock(date: DateTime.now(), end: TimeOfDay.now());
  }
}