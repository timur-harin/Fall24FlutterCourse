import 'dart:async';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/i_session_storage_repository.dart';
import '../../../domain/session_entity.dart';
import 'session_overview_state.dart';

class SessionOverviewNotifier extends StateNotifier<SessionOverviewState> {
  SessionOverviewNotifier(
    super.state,
    this._onTemperatureChanged,
    this._storage,
    this._onSessionSaved,
  );

  late Timer _timer;
  late Temperature _currentTemperature;
  final void Function(Temperature) _onTemperatureChanged;
  final ISessionStorageRepository _storage;
  final VoidCallback _onSessionSaved;

  void startTimer() {
    _currentTemperature =
        state.createdSession.startWithCold ? Temperature.cold : Temperature.hot;
    _onTemperatureChanged(_currentTemperature);
    state = state.copyWith(
      sessionState: SessionState.started,
      secondsLeft: _startTemperatureInterval,
    );
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_finished(state.currentSet)) {
          _finish();
        } else {
          state = state.copyWith(secondsLeft: state.secondsLeft - 1);
          if (state.secondsLeft <= 0) {
            _nextSet();
          }
        }
      },
    );
  }

  void _finish() {
    state = state.copyWith(finished: true, sessionState: SessionState.finished);
    _timer.cancel();
  }

  Temperature _nextTemperature() {
    switch (_currentTemperature) {
      case Temperature.cold:
        return Temperature.hot;
      case Temperature.hot:
        return Temperature.cold;
    }
  }

  bool get _isNewSetStarted {
    if (state.createdSession.startWithCold &&
        _currentTemperature == Temperature.cold) {
      return true;
    } else if (!state.createdSession.startWithCold &&
        _currentTemperature == Temperature.hot) {
      return true;
    }
    return false;
  }

  int get _startTemperatureInterval => state.createdSession.startWithCold
      ? state.createdSession.coldIntervalSeconds
      : state.createdSession.hotIntervalSeconds;

  void _nextSet() {
    _currentTemperature = _nextTemperature();
    if (_isNewSetStarted && !_finished(state.currentSet)) {
      if (_finished(state.currentSet + 1) &&
              (_nextTemperature() != Temperature.cold &&
                  state.createdSession.startWithCold) ||
          (_nextTemperature() != Temperature.hot &&
              !state.createdSession.startWithCold)) {
        _finish();
        return;
      } else {
        state = state.copyWith(
          secondsLeft: _startTemperatureInterval,
          currentSet: state.currentSet + 1,
        );
      }
    } else {
      state = state.copyWith(
        secondsLeft: _currentTemperature == Temperature.cold
            ? state.createdSession.coldIntervalSeconds
            : state.createdSession.hotIntervalSeconds,
      );
    }
    _onTemperatureChanged(_currentTemperature);
  }

  bool _finished(int nextSet) => nextSet > state.createdSession.numberOfSets;

  SessionEntity get finishedSession => SessionEntity(
      startWithCold: state.createdSession.startWithCold,
      coldIntervalSeconds: state.createdSession.coldIntervalSeconds,
      hotIntervalSeconds: state.createdSession.hotIntervalSeconds,
      amountOfSets: state.createdSession.numberOfSets,
      dateAndTime: DateTime.now(),
    );

  Future<void> saveTraining() async {
    await _storage.saveSession(finishedSession);
    _onSessionSaved();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

enum Temperature {
  cold,
  hot;
}
