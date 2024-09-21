import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'storage.dart';

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

  Future<void> _loadWaterIntake() async {
    // Load the water intake from _localStorageService using await
    final savedWaterIntake = await _localStorageService.getWaterIntake();
    if (savedWaterIntake != null) {
      state = savedWaterIntake;
    }
  }

  Future<void> increment(double amount) async {
    state += amount;
    // Save the water intake into _localStorageService using saveWaterIntake
    await _localStorageService.saveWaterIntake(state);
  }

  Future<void> reset() async {
    // reset state and save it into _localStorageService using saveWaterIntake
    state = 0;
    await _localStorageService.saveWaterIntake(state);
  }
}
