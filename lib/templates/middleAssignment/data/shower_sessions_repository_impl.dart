import 'dart:async';
import 'dart:convert';

import 'package:fall_24_flutter_course/templates/middleAssignment/domain/shower_session.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/domain/shower_sessions_repository.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

const _databaseName = 'shower_database.db';
const _tableName = 'ShowerSession';
const _databaseVersion = 1;

const _currentSessionKey = 'current_session';

class ShowerSessionsRepositoryImpl extends ShowerSessionRepository {
  Database? _database;

  void init() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, versions) => db.execute(
        '''
        CREATE TABLE IF NOT EXISTS $_tableName(
          start_timestamp TEXT PRIMARY KEY,
          phases INTEGER NOT NULL,
          start_phase INTEGER NOT NULL,
          hot_minutes INTEGER NOT NULL,
          hot_seconds INTEGER NOT NULL,
          cold_minutes INTEGER NOT NULL,
          cold_seconds INTEGER NOT NULL
        )
        '''
      ),
      version: _databaseVersion,
    );
  }

  @override
  Future<void> insertShowerSession(ShowerSession session) async {
    await _database?.insert(
        _tableName,
        session.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  @override
  Future<List<ShowerSession>> showerSessions() async {
    final data = await _database?.query(_tableName) ?? [];
    return [
      for (
        final {
          'start_timestamp': startTimestamp as String,
          'phases': phases as int,
          'start_phase': startPhaseOrd as int,
          'hot_minutes': hotMinutes as int,
          'hot_seconds': hotSeconds as int,
          'cold_minutes': coldMinutes as int,
          'cold_seconds': coldSeconds as int,
        } in data
      ) ShowerSession(
          startTimestamp: startTimestamp,
          phases: phases,
          startPhase: ShowerPhase.values[startPhaseOrd],
          hotMinutes: hotMinutes,
          hotSeconds: hotSeconds,
          coldMinutes: coldMinutes,
          coldSeconds: coldSeconds,
      )
    ];
  }

  @override
  Future<ShowerSession?> currentSession() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_currentSessionKey);
    return data == null ? null : ShowerSession.fromJson(jsonDecode(data));
  }

  @override
  Future<void> updateCurrentSession(ShowerSession session) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_currentSessionKey, jsonEncode(session.toJson()));
  }
}
