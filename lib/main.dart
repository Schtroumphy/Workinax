import 'package:flutter/material.dart';
import 'package:workinax/widgets/action_button_row.dart';
import 'package:workinax/widgets/app_divider.dart';
import 'package:workinax/widgets/app_text.dart';
import 'package:workinax/widgets/break_dialog.dart';
import 'package:workinax/widgets/clock_in_card.dart';
import 'package:workinax/widgets/history_row.dart';
import 'package:workinax/widgets/work_times_card.dart';
import 'package:workinax/widgets/today_rounded.dart';

enum ModeType { notStarted, workInProgress, breakInProgress, workEnd;

  static List<ModeType> get working => [workInProgress, ModeType.breakInProgress];
}

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: DashboardContent(),
        ),
      ),
    );
  }
}

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  late ModeType mode;

  changeMode(ModeType targetMode) {
    setState(() {
      mode = targetMode;
    });
  }

  @override
  void initState() {
    mode = ModeType.notStarted;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                onBreakClick: () => _onBreakOutClick(context),
              ),
            ModeType.workEnd => ClockInCard(onClockInClick: _onClockInClick),
          },
          const SizedBox(height: 16),
          if (ModeType.working.contains(mode))
            const AspectRatio(aspectRatio: 10 / 4, child: WorkTimesCard()),
          const SizedBox(height: 16),
          const AppText('Historique', fontSizeType: FontSizeType.large),
          const SizedBox(height: 16),
          ...[
            for (var i = 0; i < 25; i++) const HistoryRow(),
          ],
        ],
      ),
    );
  }

  _onBreakInClick(BuildContext context) async {
    final result = await showBreakDialog(context, true);
    if (result == true) {
      changeMode(ModeType.breakInProgress);
    }
  }

  _onBreakOutClick(BuildContext context) async {
    final result = await showBreakDialog(context, false);
    if (result == true) {
      changeMode(ModeType.workInProgress);
    }
  }

  _onClockInClick() {
    changeMode(ModeType.workInProgress);
  }

  _onClockOutClick() {
    changeMode(ModeType.workEnd);
  }
}
