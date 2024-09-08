import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../domain/shower_session.dart';
import '../presentation/ui/sessions/notifier.dart';

extension HomeModule on GetIt {
  void registerHomeModule() => registerLazySingleton(
          () => StateNotifierProvider<ShowerSessionsNotifier, List<ShowerSession>>(
              (_) => ShowerSessionsNotifier(this())
      )
  );
}