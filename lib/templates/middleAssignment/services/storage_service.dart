import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:mid_assignment/models/shower_session.dart';
import 'package:mid_assignment/providers/history_provider.dart';

class StorageService {
  final HistoryNotifier historyNotifier = HistoryNotifier();

  Future<void> saveSession(ShowerSession session) async {
    final prefs = await SharedPreferences.getInstance();

    final sessions = prefs.getStringList('sessions') ?? [];
    sessions.add(session.toJson());
    historyNotifier.addSession(session);

    prefs.setStringList('sessions', sessions);
  }

  Future<List<ShowerSession>> getSessions() async {
    final prefs = await SharedPreferences.getInstance();

    final sessions = prefs.getStringList('sessions') ?? [];
    final res = sessions
        .map((session) => ShowerSession.fromJson(json.decode(session)))
        .toList();
    return res;
  }
}
