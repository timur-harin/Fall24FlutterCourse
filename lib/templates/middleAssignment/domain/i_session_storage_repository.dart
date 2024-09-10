import 'session_entity.dart';

abstract interface class ISessionStorageRepository {
  Future<void> saveSession(SessionEntity session);
  Future<List<SessionEntity>> getSessions();
}
