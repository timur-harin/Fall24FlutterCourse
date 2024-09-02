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
    try {
      final intake = await _localStorageService.getWaterIntake();
      state = intake;
    } catch (e) {
      print('Failed to load water intake: $e');
    }
  }

  void increment(double amount) async {
    state += amount;
    try {
      await _localStorageService.saveWaterIntake(state);
    } catch (e) {
      print('Failed to save water intake: $e');
    }
  }

  void reset() async {
    state = 0;
    try {
      await _localStorageService.saveWaterIntake(state);
    } catch (e) {
      print('Failed to reset water intake: $e');
    }
  }
}
