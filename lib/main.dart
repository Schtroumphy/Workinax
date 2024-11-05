import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workinax/dashboard/dashboard_content.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(
    child: MaterialApp(
      home: WorkinaxApp(),
    ),
  ));
}

class WorkinaxApp extends StatefulWidget {
  const WorkinaxApp({super.key});

  @override
  State<WorkinaxApp> createState() => _WorkinaxAppState();
}

class _WorkinaxAppState extends State<WorkinaxApp> {
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
