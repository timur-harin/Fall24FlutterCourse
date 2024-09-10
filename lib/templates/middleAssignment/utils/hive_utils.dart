import 'package:hive_flutter/hive_flutter.dart';
import '../adapters/shower_session_adapter.dart' ;
import '../adapters/temperature_phase_adapter.dart';
import '../models/shower_session.dart' hide ShowerSessionAdapter;

Future<void> initializeHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ShowerSessionAdapter());
  Hive.registerAdapter(TemperaturePhaseAdapter());
  //await Hive.deleteBoxFromDisk('sessionBox');
  await Hive.openBox<ShowerSession>('sessionBox');
}
