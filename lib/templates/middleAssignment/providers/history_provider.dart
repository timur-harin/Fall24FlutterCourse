import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mid_assignment/models/shower_session.dart';

final historyProvider =
    StateNotifierProvider<HistoryNotifier, List<ShowerSession>>((ref) {
  return HistoryNotifier();
});

class HistoryNotifier extends StateNotifier<List<ShowerSession>> {
  HistoryNotifier() : super([]);

  void addSession(ShowerSession session) {
    state = [...state, session];
  }
}
