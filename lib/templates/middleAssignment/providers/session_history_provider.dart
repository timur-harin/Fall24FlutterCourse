import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/shower_session.dart';

final sessionHistoryProvider = FutureProvider<List<ShowerSession>>((ref) async {
  final sessionBox = Hive.box<ShowerSession>('sessionBox');
  return sessionBox.values.toList();
});

Future<void> addShowerSession(ShowerSession session, WidgetRef ref) async {
  final sessionBox = Hive.box<ShowerSession>('sessionBox');
  await sessionBox.add(session);
  
  ref.invalidate(sessionHistoryProvider);
}
