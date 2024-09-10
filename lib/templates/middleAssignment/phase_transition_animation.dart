import 'package:flutter/material.dart';

class PhaseTransitionAnimation extends StatefulWidget {
  final bool isHotPhase;
  final Duration duration;

  const PhaseTransitionAnimation({
    super.key,
    required this.isHotPhase,
    required this.duration,
  });

  @override
  State<PhaseTransitionAnimation> createState() =>
      _PhaseTransitionAnimationState();
}

class _PhaseTransitionAnimationState extends State<PhaseTransitionAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                widget.isHotPhase
                    ? Colors.red.withOpacity(_animation.value)
                    : Colors.blue.withOpacity(_animation.value),
                widget.isHotPhase
                    ? Colors.orange.withOpacity(_animation.value)
                    : Colors.cyan.withOpacity(_animation.value),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: child,
        );
      },
      child: const Icon(Icons.water_drop, size: 50), // Example icon
    );
  }
}
