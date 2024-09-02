import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _waterIntakeKey = 'waterIntake';

  Future<void> saveWaterIntake(double intake) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_waterIntakeKey, intake);
    // TODO - Save the water intake into prefs  
  }

  Future<double> getWaterIntake() async {
    final prefs = await SharedPreferences.getInstance();
    double? intake = prefs.getDouble(_waterIntakeKey);
    if (intake == null) {
      return 0.0;
    }
    // TODO - Get the water intake from prefs, remove 'return 0.0'
    return intake;
  }
}