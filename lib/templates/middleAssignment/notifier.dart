import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'local_storage_service.dart';

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

final historyProvider =
    StateNotifierProvider<HistoryNotifier, List<String>>((ref) {
  final localStorageService = ref.watch(localStorageServiceProvider);
  return HistoryNotifier(localStorageService);
});

class HistoryNotifier extends StateNotifier<List<String>> {
  final LocalStorageService _localStorageService;

  HistoryNotifier(this._localStorageService) : super([]) {
    _loadHistory();
  }

  void _loadHistory() async {
    state = await _localStorageService.getHistory();
  }

  void save(String hist) async {
    await _localStorageService.saveHistory(hist);
  }

}