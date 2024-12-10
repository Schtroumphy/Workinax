import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workinax/time_entry/presentation/dashboard/dashboard_content.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: MaterialApp(
        locale: Locale('fr', 'FR'),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: WorkinaxApp(),
      ),
    ),
  );
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
