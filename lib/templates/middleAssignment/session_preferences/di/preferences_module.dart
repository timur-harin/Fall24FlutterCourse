import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get_it/get_it.dart';

import '../presentation/notifier.dart';
import '../presentation/state.dart';

extension PreferencesModule on GetIt {
  void registerPreferencesModule() => registerLazySingleton(
          () => StateNotifierProvider<PreferencesNotifier, PreferencesState>(
              (_) => PreferencesNotifier(this())
      )
  );
}
