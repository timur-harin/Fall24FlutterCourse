import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class ShowerSession {
  final int duration;
  final String date;
  final double rating;

  ShowerSession({
    required this.duration,
    required this.date,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'duration': duration,
      'date': date,
      'rating': rating,
    };
  }

  static ShowerSession fromMap(Map<String, dynamic> map) {
    return ShowerSession(
      duration: map['duration'] as int,
      date: map['date'] as String,
      rating: map['rating'] as double,
    );
  }
}

final showerSessionProvider = StateNotifierProvider<ShowerSessionNotifier, List<ShowerSession>>((ref) {
  return ShowerSessionNotifier();
});

class ShowerSessionNotifier extends StateNotifier<List<ShowerSession>> {
  ShowerSessionNotifier() : super([]) {
    _init();
  }

  Box? _box;

  // Initialize Hive box
  Future<void> _init() async {
    _box = await Hive.openBox('sessions');
    _loadSessions();
  }

  // Load sessions from Hive
  void _loadSessions() {
    if (_box != null) {
      final sessions = _box!.values.map((e) => ShowerSession.fromMap(Map<String, dynamic>.from(e))).toList();
      state = sessions;
    }
  }

  // Add new session to Hive and update state
  Future<void> addSession(ShowerSession session) async {
    // Ensure the box is initialized before using it
    if (_box == null) {
      await _init();
    }

    await _box!.add(session.toMap());
    state = [...state, session]; // Append the new session
  }

  @override
  void dispose() {
    _box?.close(); // Close the Hive box when the notifier is disposed
    super.dispose();
  }
}
