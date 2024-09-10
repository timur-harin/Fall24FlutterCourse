import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/shower_session.dart';

final currentSessionProvider = StateNotifierProvider<CurrentSessionNotifier, ShowerSession?>((ref) {
  return CurrentSessionNotifier();
});

class CurrentSessionNotifier extends StateNotifier<ShowerSession?> {
  DateTime? _sessionStartTime;
  Duration _totalActiveTime = Duration.zero;
  Timer? _timer;
  bool _isPaused = false;

  CurrentSessionNotifier() : super(null);

  void startSession(ShowerSession session) {
    _sessionStartTime = DateTime.now();
    _totalActiveTime = Duration.zero;
    _isPaused = false;
    state = session;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        _totalActiveTime += const Duration(seconds: 1);
      }
    });
  }

  void pauseSession() {
    _isPaused = true;
  }

  void resumeSession() {
    _isPaused = false;
  }

  void endSession() {
    if (state != null && _sessionStartTime != null) {
      _timer?.cancel();
      final updatedSession = ShowerSession(
        phases: state!.phases,
        totalTime: _totalActiveTime,
        dateTime: state!.dateTime, 
        rating: state!.rating,
      );
      state = updatedSession;
    }
  }

  void rateSession(int rating) {
    if (state != null) {
      final updatedSession = state!.copyWith(rating: rating);
      state = updatedSession;
    }
  }
  
  void clearSession() {
    _timer?.cancel();
    state = null;
  }

  Duration getTotalActiveTime() {
    return _totalActiveTime;
  }
}
