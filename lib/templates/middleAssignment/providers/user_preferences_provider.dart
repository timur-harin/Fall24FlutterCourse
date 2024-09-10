import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_preferences.dart';

final userPreferencesProvider = StateProvider<UserPreferences>((ref) {
  return UserPreferences(
    phaseDurations: List.generate(4, (index) => Duration(minutes: index + 1)),
    numberOfPhases: 4,
    isHotFirst: true,
  );
});
