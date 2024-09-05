import 'package:flutter/material.dart';

class PhaseCirclePainter extends CustomPainter {
  final bool isHotPhase;

  PhaseCirclePainter({required this.isHotPhase});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isHotPhase ? Colors.red : Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
