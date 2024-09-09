import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:showerPackage/home_screen.dart';
import 'package:showerPackage/shower_session.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TemperaturePhaseAdapter());
  Hive.registerAdapter(ShowerSessionAdapter());
  await Hive.openBox<ShowerSession>('sessionsBox');
  runApp(const ProviderScope(child: MiddleAssigmentApp()));
}

class MiddleAssigmentApp extends StatelessWidget {
  const MiddleAssigmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Middle Assigment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
