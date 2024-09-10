import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'session_overview_state.dart';

class SessionOverviewNotifier extends StateNotifier<SessionOverviewState> {
  SessionOverviewNotifier(super.state, this._onTemperatureChanged);

  late Timer _timer;
  late Temperature _currentTemperature;
  final void Function(Temperature) _onTemperatureChanged;

  void startTimer() {
    _currentTemperature =
        state.createdSession.startWithCold ? Temperature.cold : Temperature.hot;
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
      ? state.createdSession.coldIntervalMinutes
      : state.createdSession.hotIntervalMinutes;

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
            ? state.createdSession.coldIntervalMinutes
            : state.createdSession.hotIntervalMinutes,
      );
    }
    _onTemperatureChanged(_currentTemperature);
  }

  bool _finished(int nextSet) => nextSet > state.createdSession.numberOfSets;

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
