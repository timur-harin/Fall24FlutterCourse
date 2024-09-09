import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'dart:async';

import '../../../ui/theme/theme.dart';
import '../../../utils/extensions/int.dart';

class SessionTimer extends StatefulWidget {
  final int timeout;
  final Timer timer;

  const SessionTimer({
    super.key,
    required this.timeout,
    required this.timer,
  });

  @override
  State<StatefulWidget> createState() => _SessionTimerState();
}

class _SessionTimerState extends State<SessionTimer> {
  final _theme = GetIt.instance<AppTheme>();

  @override
  Widget build(BuildContext context) => Text(
    widget.timeout.toMinuteWithSecondFormat(),
    style: _theme.typography.h.h2.copyWith(
        color: _theme.colors.text.onBackground
    ),
  );
}
