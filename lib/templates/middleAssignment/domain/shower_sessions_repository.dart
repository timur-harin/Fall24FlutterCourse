import 'package:fall_24_flutter_course/templates/middleAssignment/domain/shower_session.dart';

abstract class ShowerSessionRepository {
  Future<List<ShowerSession>> showerSessions();
  Future<void> insertShowerSession(ShowerSession session);

  Future<ShowerSession?> currentSession();
  Future<void> updateCurrentSession(ShowerSession? session);
}
