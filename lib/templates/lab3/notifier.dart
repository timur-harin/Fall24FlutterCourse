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

  void _loadWaterIntake() async {
    state = await _localStorageService.getWaterIntake();
  }

  void increment(double amount) async {
    state += amount;
    //round here to not get 1.000000000000004
    state = double.parse(state.toStringAsFixed(2));
    await _localStorageService.saveWaterIntake(state);
  }

  void reset() async {
    state = 0.0;
    await _localStorageService.saveWaterIntake(state);
  }
}