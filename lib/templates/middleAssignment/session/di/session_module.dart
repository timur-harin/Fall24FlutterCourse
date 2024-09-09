import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get_it/get_it.dart';

import '../presentation/notifier.dart';
import '../presentation/state.dart';

extension SessionModule on GetIt {
  void registerSessionModule() => registerLazySingleton(
      () => StateNotifierProvider<SessionNotifier, SessionState?>(
          (_) => SessionNotifier(this())
      )
  );
}
