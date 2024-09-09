import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/session_summary.dart';
import '../storage_service.dart';

class SessionSummaryNotifier extends StateNotifier<List<SessionSummary>> {
  final StorageService _storageService;

  SessionSummaryNotifier(this._storageService) : super([]) {
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    final sessions = await _storageService.getSessions();
    state = sessions;
  }

  Future<void> addSession(SessionSummary session) async {
    await _storageService.saveSession(session);
    state = [...state, session];
  }

  Future<void> clearHistory() async {
    await _storageService.clearSessions();
    state = [];
  }
}

final sessionSummaryProvider = StateNotifierProvider<SessionSummaryNotifier, List<SessionSummary>>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  return SessionSummaryNotifier(storageService);
});

final currentSessionSummaryProvider = StateProvider<SessionSummary?>((ref) => null);
