import 'package:flutter/material.dart';

import '../../../../domain/shower_session.dart';
import '../../../../session/presentation/ui/valve/valve_painter.dart';

const _valveSize = 50.0;

class Valve extends StatefulWidget {
  final ShowerPhase phase;
  final AnimationController controller;
  final void Function() performAnimation;
  final void Function() onClick;

  const Valve({
    super.key,
    required this.phase,
    required this.controller,
    required this.performAnimation,
    required this.onClick,
  });

  @override
  State<StatefulWidget> createState() => _ValveState();
}

class _ValveState extends State<Valve> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () {
      widget.performAnimation();
      widget.onClick();
    },
    child: SizedBox(
      width: _valveSize,
      height: _valveSize,
      child: RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(widget.controller),
        child: CustomPaint(
          painter: ValvePainter(
            phase: widget.phase,
            top: _valveSize / 2,
            left: _valveSize / 2,
          ),
          size: const Size(_valveSize, _valveSize),
        ),
      ),
    ),
  );
}
