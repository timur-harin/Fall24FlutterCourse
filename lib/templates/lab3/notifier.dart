import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'storage.dart';

const double maxWaterLiters = 10.0;

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
    if (state + amount < maxWaterLiters) {
      state += amount;
      _saveState();
    }
  }

  void reset() async {
    state = 0;
    _saveState();
  }

  void _saveState() async {
    _localStorageService.saveWaterIntake(state);
  }
}

class MaxLevelReachedException implements Exception {
  const MaxLevelReachedException({this.cause = 'Max level reached'});
  
  final String cause;

  @override
  String toString() => 'Max level reached';
}
