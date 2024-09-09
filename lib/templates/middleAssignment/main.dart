import 'package:fall_24_flutter_course/templates/middleAssignment/screens/active_session_screen.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/screens/new_session_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contrast Shower Companion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/newSession': (context) => NewSessionScreen(),
        '/activeSession': (context) => ActiveSessionScreen()
      },
    );
  }
}
