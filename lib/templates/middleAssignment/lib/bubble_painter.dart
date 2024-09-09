import 'package:flutter/material.dart';
import 'dart:math';

class BubblePainter extends CustomPainter {
  final Animation<double> animation;
  final List<Offset> _bubbles = [];

  BubblePainter(this.animation) : super(repaint: animation) {
    _generateBubbles();
  }

  void _generateBubbles() {
    final Random random = Random();
    for (int i = 0; i < 20; i++) {
      final double x = random.nextDouble() * 300;
      final double y = 600 + random.nextDouble() * 100;
      _bubbles.add(Offset(x, y));
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    final double bubbleSize = 30 + 10 * animation.value;

    // Update bubble positions based on animation
    for (int i = 0; i < _bubbles.length; i++) {
      final Offset bubblePosition = _bubbles[i];
      final double newY = bubblePosition.dy - (animation.value * size.height);
      _bubbles[i] = Offset(bubblePosition.dx, newY < -50 ? size.height : newY);
    }

    for (final bubble in _bubbles) {
      canvas.drawCircle(
        bubble,
        bubbleSize,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
