import 'package:fall_24_flutter_course/templates/middleAssignment/screens/active_session_screen.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/screens/new_session_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contrast Shower Companion',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 112, 22, 22),
          elevation: 10,
          titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255)
          )
        ),
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromARGB(255, 179, 247, 245),
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
