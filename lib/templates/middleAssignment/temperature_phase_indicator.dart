import 'package:flutter/material.dart';
import 'active_session_screen.dart';

class TemperaturePhaseIndicator extends StatefulWidget {
  final bool isHotPhase;
  final Duration hotDuration;
  final Duration coldDuration;

  const TemperaturePhaseIndicator({Key? key, required this.isHotPhase, required this.hotDuration, required this.coldDuration}) : super(key: key);

  @override
  _TemperaturePhaseIndicatorState createState() => _TemperaturePhaseIndicatorState();
}

class _TemperaturePhaseIndicatorState extends State<TemperaturePhaseIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.isHotPhase ?  widget.hotDuration: widget.coldDuration, vsync: this)
      ..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: widget.isHotPhase ? Colors.red : Colors.blue,
      end: widget.isHotPhase ? Colors.blue : Colors.red,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 100,
          height: 100,
          color: _colorAnimation.value,
          alignment: Alignment.center,
          child: widget.isHotPhase ? Icon(Icons.wb_sunny, color: Colors.yellow) : Icon(Icons.nightlight_round, color: Colors.white),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
