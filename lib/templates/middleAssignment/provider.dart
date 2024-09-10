import 'package:flutter_riverpod/flutter_riverpod.dart';

class Session {
  final int duration;
  final int temperatureInterval;
  final double minTemperature;
  final double maxTemperature;
  final int rating;

  Session({
    required this.duration,
    required this.temperatureInterval,
    required this.minTemperature,
    required this.maxTemperature,
    required this.rating,
  });
}

class SessionNotifier extends StateNotifier<List<Session>> {
  SessionNotifier() : super([]);

  void addSession(Session session) {
    state = [session, ...state];
  }
}

final sessionProvider = StateNotifierProvider<SessionNotifier, List<Session>>((ref) {
  return SessionNotifier();
});