import 'package:flutter/material.dart';

//-----------------------------------------Animated Widget-----------------------------------------//

class TemperatureTransitionWidget extends StatefulWidget {
  final bool isHotPhase;

  const TemperatureTransitionWidget({super.key, required this.isHotPhase});

  @override
  _TemperatureTransitionWidgetState createState() => _TemperatureTransitionWidgetState();
}

class _TemperatureTransitionWidgetState extends State<TemperatureTransitionWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _colorAnimation = ColorTween(
      begin: widget.isHotPhase ? Colors.red : Colors.blue,
      end: widget.isHotPhase ? Colors.red : Colors.blue,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant TemperatureTransitionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if the phase has changed and update the animation accordingly
    if (oldWidget.isHotPhase != widget.isHotPhase) {
      setState(() {
        // If isHotPhase changes, we reverse the color transition
        _colorAnimation = ColorTween(
          begin: widget.isHotPhase ? Colors.blue : Colors.red, // From previous color
          end: widget.isHotPhase ? Colors.red : Colors.blue,  // To new color
        ).animate(_controller);

        // Restart the animation to show the new color
        _controller.reset();
        _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: _colorAnimation.value,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.water_drop_outlined,
            size: 40,
          ),
        );
      },
    );
  }
}
