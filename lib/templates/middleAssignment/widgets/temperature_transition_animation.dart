import 'package:flutter/material.dart';

class TemperatureTransitionAnimation extends StatefulWidget {
  final bool isHot;

  const TemperatureTransitionAnimation({Key? key, required this.isHot}) : super(key: key);

  @override
  _TemperatureTransitionAnimationState createState() => _TemperatureTransitionAnimationState();
}

class _TemperatureTransitionAnimationState extends State<TemperatureTransitionAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _colorAnimation = ColorTween(
      begin: widget.isHot ? Colors.blue : Colors.red,
      end: widget.isHot ? Colors.red : Colors.blue,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant TemperatureTransitionAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.isHot != oldWidget.isHot) {
      _colorAnimation = ColorTween(
        begin: widget.isHot ? Colors.blue : Colors.red,
        end: widget.isHot ? Colors.red : Colors.blue,
      ).animate(_controller);

      _controller
        ..reset()
        ..forward();
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
        return Icon(
          Icons.shower,
          size: 100,
          color: _colorAnimation.value,
        );
      },
    );
  }
}
