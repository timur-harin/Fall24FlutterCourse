import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'storage.dart';

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

final waterIntakeProvider = StateNotifierProvider<WaterIntakeNotifier, double>((ref) {
  final localStorageService = ref.watch(localStorageServiceProvider);
  return WaterIntakeNotifier(localStorageService);
});

class WaterIntakeNotifier extends StateNotifier<double> {
  final LocalStorageService _localStorageService;

  WaterIntakeNotifier(this._localStorageService) : super(0) {
    _loadWaterIntake();
  }

  void _loadWaterIntake() async {
    state = await _localStorageService.getWaterIntake(); // Load the water intake from _localStorageService using await
  }

  void increment(double amount) async {
    if (state + amount <= 5.0) {  // Check to prevent exceeding 5 liters
      state += amount;
      await _localStorageService.saveWaterIntake(state); // Save the water intake into _localStorageService using saveWaterIntake
    } else {
      state = 5.0;  // Ensure state doesn't exceed 5 liters
      await _localStorageService.saveWaterIntake(state); // Save the maximum limit into storage
    }
  }

  void reset() async {
    state = 0;
    await _localStorageService.saveWaterIntake(state); // Reset state and save it into _localStorageService using saveWaterIntake
  }
}
