import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_screen.dart';
import 'screens/session_preferences_screen.dart';
import 'screens/session_overview_screen.dart';
import 'screens/active_session_screen.dart';
import 'screens/session_summary_screen.dart';
import 'app_theme.dart';
import 'storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storageService = StorageService();
  await storageService.init();

  runApp(
    ProviderScope(
      overrides: [
        storageServiceProvider.overrideWithValue(storageService),
      ],
      child: ContrastShowerCompanionApp(),
    ),
  );
}

class ContrastShowerCompanionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contrast Shower Companion',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/preferences': (context) => SessionPreferencesScreen(),
        '/overview': (context) => SessionOverviewScreen(),
        '/active_session': (context) => ActiveSessionScreen(),
        '/summary': (context) => SessionSummaryScreen(),
      },
    );
  }
}
