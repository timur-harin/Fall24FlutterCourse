import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models/session_summary.dart';

class StorageService {
  static const String _sessionBoxName = 'sessions';

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SessionSummaryAdapter());
    await Hive.openBox<SessionSummary>(_sessionBoxName);
  }

  Future<void> saveSession(SessionSummary session) async {
    final box = Hive.box<SessionSummary>(_sessionBoxName);
    await box.add(session);
  }

  Future<List<SessionSummary>> getSessions() async {
    final box = Hive.box<SessionSummary>(_sessionBoxName);
    return box.values.toList();
  }

  Future<void> clearSessions() async {
    final box = Hive.box<SessionSummary>(_sessionBoxName);
    await box.clear();
  }
}

final storageServiceProvider = Provider<StorageService>((ref) => StorageService());
