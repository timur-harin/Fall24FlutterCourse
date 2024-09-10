import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/shower_session.dart';
import 'package:hive/hive.dart';
import 'dart:async';

class ShowerSessionNotifier extends StateNotifier<ShowerSession?> {
  Timer? _timer;
  int remainingPhaseTime = 0;
  int currentPhaseIndex = 0;
  int totalSessionTime = 0;
  int initialTotalDuration = 0;
  int elapsedTime = 0;
  List<TemperaturePhase> completedPhases = [];

  final SessionHistoryNotifier sessionHistoryNotifier;

  ShowerSessionNotifier(this.sessionHistoryNotifier) : super(null);

  void startSession(List<TemperaturePhase> phases) {
    int calculatedTotalDuration = phases.fold(0, (sum, phase) => sum + phase.duration);
    state = ShowerSession(
      dateTime: DateTime.now(),
      phases: phases,
      totalDuration: calculatedTotalDuration,
    );

    currentPhaseIndex = 0;
    remainingPhaseTime = phases[currentPhaseIndex].duration;
    totalSessionTime = calculatedTotalDuration;
    initialTotalDuration = calculatedTotalDuration;
    elapsedTime = 0;
    completedPhases = [];
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingPhaseTime > 0) {
        remainingPhaseTime--;
        totalSessionTime--;
        elapsedTime++;
        state = state?.copyWith(totalDuration: totalSessionTime);
      } else {
        completedPhases.add(state!.phases[currentPhaseIndex]);
        _moveToNextPhase();
      }

      if (totalSessionTime <= 0) {
        endSession();
      }
    });
  }

  void _moveToNextPhase() {
    currentPhaseIndex++;
    if (currentPhaseIndex < state!.phases.length) {
      remainingPhaseTime = state!.phases[currentPhaseIndex].duration;
      state = state?.copyWith();
    } else {
      endSession();
    }
  }

  void pauseSession() {
    _timer?.cancel();
    state = state?.copyWith(isPaused: true);
  }

  void resumeSession() {
    state = state?.copyWith(isPaused: false);
    _startTimer();
  }

  void endSession() {
    _timer?.cancel();

    if (remainingPhaseTime > 0 && currentPhaseIndex < state!.phases.length) {
      int completedTimeForCurrentPhase = state!.phases[currentPhaseIndex].duration - remainingPhaseTime;
      completedPhases.add(
        TemperaturePhase(
          type: state!.phases[currentPhaseIndex].type,
          duration: completedTimeForCurrentPhase,
        ),
      );
    }
    sessionHistoryNotifier.addSession(state!.copyWith(
      totalDuration: elapsedTime,
      phases: completedPhases,
    ));

    state = null; 
  }


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class UserPreferencesNotifier extends StateNotifier<UserPreferences> {
  UserPreferencesNotifier() : super(UserPreferences());

  void setHotPhaseDuration(int duration) {
    state = state.copyWith(hotPhaseDuration: duration);
  }

  void setColdPhaseDuration(int duration) {
    state = state.copyWith(coldPhaseDuration: duration);
  }

  void setSessionLength(int length) {
    state = state.copyWith(sessionLength: length);
  }
}

class SessionHistoryNotifier extends StateNotifier<List<ShowerSession>> {
  SessionHistoryNotifier() : super([]) {
    loadHistory();
  }

  Future<void> loadHistory() async {
    final box = await Hive.openBox<ShowerSession>('session_history');
    state = box.values.toList();
  }

  Future<void> addSession(ShowerSession session) async {
    final box = await Hive.openBox<ShowerSession>('session_history');
    await box.add(session);
    state = [...state, session];
  }

  Future<void> updateSession(int key, ShowerSession updatedSession) async {
    final box = await Hive.openBox<ShowerSession>('session_history');
    await box.put(key, updatedSession);
    state = [...box.values];
  }
}



final showerSessionProvider = StateNotifierProvider<ShowerSessionNotifier, ShowerSession?>((ref) {
  final sessionHistoryNotifier = ref.read(sessionHistoryProvider.notifier);
  return ShowerSessionNotifier(sessionHistoryNotifier);
});

final userPreferencesProvider = StateNotifierProvider<UserPreferencesNotifier, UserPreferences>((ref) {
  return UserPreferencesNotifier();
});

final sessionHistoryProvider = StateNotifierProvider<SessionHistoryNotifier, List<ShowerSession>>((ref) {
  return SessionHistoryNotifier();
});

