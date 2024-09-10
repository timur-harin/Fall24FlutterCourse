import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/history_screen.dart';
import 'screens/home_screen.dart';
import 'screens/preferences_screen.dart';
import 'screens/session_overview_screen.dart';
import 'screens/session_screen.dart';
import 'screens/session_summary_screen.dart';
import 'utils/hive_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeHive();
  runApp(const ProviderScope(child: ContrastShowerApp()));
}

class ContrastShowerApp extends StatelessWidget {
  const ContrastShowerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contrast Shower Companion',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/preferences': (context) => const PreferencesScreen(),
        '/session_overview': (context) => const SessionOverviewScreen(),
        '/active_session': (context) => const SessionScreen(),
        '/session_summary': (context) => const SessionSummaryScreen(),
        '/history' : (context) => const HistoryScreen(),
      },
    );
  }
}
