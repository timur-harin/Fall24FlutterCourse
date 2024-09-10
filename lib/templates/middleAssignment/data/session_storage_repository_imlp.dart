import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/i_session_storage_repository.dart';
import '../domain/session_entity.dart';

const String kSessionMapKey = 'sessionMapKey';

class SessionStorageRepositoryImlp implements ISessionStorageRepository {
  SessionStorageRepositoryImlp._() {
    _instance ??= this;
  }

  static SessionStorageRepositoryImlp instance =
      SessionStorageRepositoryImlp._();

  SessionStorageRepositoryImlp? _instance;

  @override
  Future<void> saveSession(SessionEntity session) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> list = prefs.getStringList(kSessionMapKey) ?? [];
    list.add(jsonEncode(session.toJson()));
    await prefs.setStringList(kSessionMapKey, list);
  }

  @override
  Future<List<SessionEntity>> getSessions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> list = prefs.getStringList(kSessionMapKey) ?? [];
    return List<SessionEntity>.from(
      list.map(
        (e) => SessionEntity.fromJson(
          Map<String, dynamic>.from(jsonDecode(e)),
        ),
      ),
    );
  }
}
