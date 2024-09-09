import 'package:fall_24_flutter_course/templates/middleAssignment/domain/shower_session.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/domain/shower_sessions_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowerSessionsNotifier extends StateNotifier<List<ShowerSession>> {
  final ShowerSessionRepository _repository;

  ShowerSessionsNotifier(this._repository): super([]) {
    loadSessions();
    clearPreviousSession();
  }

  void loadSessions() async =>
      state = await _repository.showerSessions();

  void clearPreviousSession() async =>
      await _repository.updateCurrentSession(null);
}
