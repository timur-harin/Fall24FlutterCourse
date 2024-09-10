import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shower_session.dart';
import 'package:hive/hive.dart';

final showerHistoryProvider = StateProvider<List<ShowerSession>>((ref) {
  final box = Hive.box<ShowerSession>('shower_history');
  return box.values.toList();
});

final currentSessionProvider = StateProvider<ShowerSession?>((ref) {
  return null;
});
