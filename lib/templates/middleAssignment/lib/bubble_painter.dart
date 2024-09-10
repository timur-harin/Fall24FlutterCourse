import 'dart:math';
import 'package:flutter/material.dart';

class BubblePainter extends CustomPainter {
  final Animation<double> animation;
  final List<Bubble> _bubbles = [];

  BubblePainter(this.animation) : super(repaint: animation) {
    _generateBubbles();
  }

  void _generateBubbles() {
    final Random random = Random();
    _bubbles.clear();
    for (int i = 0; i < 30; i++) {
      _bubbles.add(Bubble(
        position: Offset(random.nextDouble() * 1800, random.nextDouble() * 100),
        size: random.nextDouble() * 20 + 10,
        speed: random.nextDouble() * 0.1 + 0.05,
      ));
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < _bubbles.length; i++) {
      final bubble = _bubbles[i];
      final double newY =
          bubble.position.dy - (bubble.speed * size.height * 0.1);

      if (newY < -bubble.size) {
        _bubbles[i] = bubble.copyWith(
          position: Offset(
              Random().nextDouble() * size.width, size.height + bubble.size),
        );
      } else {
        _bubbles[i] = bubble.copyWith(
          position: Offset(bubble.position.dx, newY),
        );
      }
      canvas.drawCircle(_bubbles[i].position, bubble.size, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Bubble {
  final Offset position;
  final double size;
  final double speed;

  Bubble({
    required this.position,
    required this.size,
    required this.speed,
  });

  Bubble copyWith({
    Offset? position,
    double? size,
    double? speed,
  }) {
    return Bubble(
      position: position ?? this.position,
      size: size ?? this.size,
      speed: speed ?? this.speed,
    );
  }
}
