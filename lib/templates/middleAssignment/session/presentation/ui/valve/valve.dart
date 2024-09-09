import 'package:flutter/material.dart';

import '../../../../domain/shower_session.dart';
import '../../../../session/presentation/ui/valve/valve_painter.dart';

const _animDuration = Duration(milliseconds: 1000);
const _valveSize = 50.0;

class Valve extends StatefulWidget {
  final ShowerPhase phase;
  final void Function() onClick;

  const Valve({super.key, required this.phase, required this.onClick});

  @override
  State<StatefulWidget> createState() => _ValveState();
}

class _ValveState extends State<Valve> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: _animDuration,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () {
      widget.phase == ShowerPhase.hot
          ? _controller.forward()
          : _controller.animateBack(0.0);
      widget.onClick();
    },
    child: SizedBox(
      width: _valveSize,
      height: _valveSize,
      child: RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
        child: CustomPaint(
          painter: ValvePainter(
            phase: widget.phase,
            top: _valveSize / 2,
            left: _valveSize / 2,
          ),
          size: const Size(50, 50),
        ),
      ),
    ),
  );
}
