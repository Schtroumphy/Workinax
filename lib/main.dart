import 'package:flutter/material.dart';
import 'package:workinax/widgets/action_button_row.dart';
import 'package:workinax/widgets/app_divider.dart';
import 'package:workinax/widgets/app_text.dart';
import 'package:workinax/widgets/break_dialog.dart';
import 'package:workinax/widgets/history_row.dart';
import 'package:workinax/widgets/rounded_card.dart';
import 'package:workinax/widgets/today_rounded.dart';

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

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

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
          ActionButtonRow(
            onBreakClick: () => _onBreakClick(context),
          ),
          const SizedBox(height: 8),
          const AspectRatio(aspectRatio: 10 / 4, child: RoundedCard()),
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

  _onBreakClick(BuildContext context) {
    showBreakDialog(context);
  }
}