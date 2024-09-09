import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'timer.dart';
import 'valve/valve.dart';
import '../../../ui/theme/theme.dart';
import '../../../domain/shower_session.dart';

const _animDuration = Duration(milliseconds: 1000);
const _timerDuration = Duration(seconds: 1);

class SessionContent extends StatefulWidget {
  final ShowerPhase phase;
  final int currentPhaseDurationSecs;
  final int? nextPhaseDurationSecs;
  final void Function(int) onTimeChanged;
  final void Function() onPhaseEnd;

  const SessionContent({
    super.key,
    required this.phase,
    required this.currentPhaseDurationSecs,
    required this.nextPhaseDurationSecs,
    required this.onTimeChanged,
    required this.onPhaseEnd,
  });

  @override
  State<StatefulWidget> createState() => _SessionContentState();
}

class _SessionContentState extends State<SessionContent> with SingleTickerProviderStateMixin {
  late AnimationController _valveController;

  int _timeout = 0;
  late Timer _timer;

  final _theme = GetIt.instance<AppTheme>();

  void _startTimer() {
    _timer = Timer.periodic(_timerDuration, (Timer timer) =>
    switch (_timeout) {
      0 => setState(() {
        _onTimeout();
        _launchNextCountdownOrStop();
      }),

      _ => setState(() {
        final nextTimeout = --_timeout;
        widget.onTimeChanged(nextTimeout);
      }),
    });
  }

  void _onTimeout() {
    _performValveAnimation();
    widget.onPhaseEnd();
  }

  void _launchNextCountdownOrStop() {
    _timer.cancel();
    if (widget.nextPhaseDurationSecs != null) {
      _timeout = widget.nextPhaseDurationSecs ?? 0;
      _startTimer();
    }
  }

  @override
  void initState() {
    _valveController = AnimationController(
      duration: _animDuration,
      vsync: this,
    );

    _timeout = widget.currentPhaseDurationSecs;
    _startTimer();

    super.initState();
  }

  @override
  void dispose() {
    _valveController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
    alignment: Alignment.center,
    width: double.infinity,
    height: double.infinity,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          _theme.colors.background.primary,
          widget.phase == ShowerPhase.hot
              ? _theme.colors.background.hot
              : _theme.colors.background.cold,
        ],
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // TODO: нарисовать вентиль, таймер, паузу
        Valve(
          phase: widget.phase,
          controller: _valveController,
          performAnimation: _performValveAnimation,
          onClick: () {
            widget.onPhaseEnd();
            _launchNextCountdownOrStop();
          },
        ),

        SizedBox(height: _theme.dimensions.padding.extraMedium),

        SessionTimer(
          timer: _timer,
          timeout: _timeout,
        ),
      ],
    ),
  );

  void _performValveAnimation() =>
      widget.phase == ShowerPhase.hot
          ? _valveController.forward()
          : _valveController.animateBack(0.0);
}