import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get_it/get_it.dart';

import '../../session_preferences/ui/notifier.dart';
import '../../session_preferences/ui/state.dart';

extension PreferencesModule on GetIt {
  void registerPreferencesModule() => registerLazySingleton(
          () => StateNotifierProvider<PreferencesNotifier, PreferencesState>(
              (_) => PreferencesNotifier(this())
      )
  );
}
