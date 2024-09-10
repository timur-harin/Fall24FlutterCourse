import 'package:fall_24_flutter_course/templates/middleAssignment/data/session_storage_repository_imlp.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/domain/i_session_storage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_screen_state.dart';

final loadingProvider = StateNotifierProvider<LoadingNotifier, HomeScreenState>((ref) {
  return LoadingNotifier(SessionStorageRepositoryImlp.instance)..refreshData();
});

class LoadingNotifier extends StateNotifier<HomeScreenState> {
  LoadingNotifier(this._storage) : super(const HomeScreenState());

  final ISessionStorageRepository _storage;

  void refreshData() {
    state = HomeScreenState.loading();
    _storage.getSessions().then((sessions) {
      state = HomeScreenState.loaded(sessions);
    });
  }
}