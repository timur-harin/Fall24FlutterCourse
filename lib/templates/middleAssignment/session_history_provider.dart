import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'session_storage.dart';

final sessionHistoryProvider = StateNotifierProvider<SessionHistoryNotifier, List<Map<String, dynamic>>>((ref) {
  return SessionHistoryNotifier();
});

class SessionHistoryNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  SessionHistoryNotifier() : super([]) {
    loadHistory();
  }

  Future<void> loadHistory() async {
    List<Map<String, dynamic>> history = await SessionStorage().getSessionHistory();
    state = history;
  }

  Future<void> addSession(int totalPhases, int hotDuration, int coldDuration) async {
    await SessionStorage().saveSession(totalPhases, hotDuration, coldDuration);
    await loadHistory();
  }
}
