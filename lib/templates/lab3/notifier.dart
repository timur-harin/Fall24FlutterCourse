import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'storage.dart';
const double maxWaterIntake = 2.0;

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

final waterIntakeProvider =
    StateNotifierProvider<WaterIntakeNotifier, double>((ref) {
  final localStorageService = ref.watch(localStorageServiceProvider);
  return WaterIntakeNotifier(localStorageService);
});

class WaterIntakeNotifier extends StateNotifier<double> {
  final LocalStorageService _localStorageService;

  WaterIntakeNotifier(this._localStorageService) : super(0) {
    _loadWaterIntake();
  }

  void _loadWaterIntake() async {
    // Load the water intake from _localStorageService using await
    state = await _localStorageService.getWaterIntake();
  }

  void increment(double amount) async {
    if (state + amount > maxWaterIntake) {
      state = maxWaterIntake;
    } else {
      state += amount;
    }
    // Save the water intake into _localStorageService using saveWaterIntake
    await _localStorageService.saveWaterIntake(state);
  }

  void reset() async {
    // Reset state and save it into _localStorageService using saveWaterIntake
    state = 0;
    await _localStorageService.saveWaterIntake(state);
  }
}
