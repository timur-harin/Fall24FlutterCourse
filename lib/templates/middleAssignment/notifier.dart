import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'storage.dart';

//-----------------------------------------State Management----------------------------------------//

final sessionHistoryProvider = Provider<SessionStorage>((ref){
  return SessionStorage();
});

final showerHistoryProvider = StateNotifierProvider<sessionHistoryNotifier, List<String>>((ref) {
  final sessionHistory = ref.watch(sessionHistoryProvider);
  return sessionHistoryNotifier(sessionHistory);
});

class sessionHistoryNotifier extends StateNotifier<List<String>>{
  final SessionStorage _sessionStorage;

  sessionHistoryNotifier(this._sessionStorage): super([]) {
    _loadSessionStorage();
  }

  void _loadSessionStorage() async{
    state = await _sessionStorage.getSessionHistory();
  }

  void addSession(String sessionDetails) async {
    List<String> hist = await _sessionStorage.getSessionHistory();
    hist.add(sessionDetails);
    await _sessionStorage.saveSessionHistory(hist);
  }
}