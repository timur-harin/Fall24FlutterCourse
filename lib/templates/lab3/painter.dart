// Your existing imports
import 'dart:math';

import 'package:flutter/material.dart';

class WaterProgressPainter extends CustomPainter {
  final double waterIntakeLevel;

  WaterProgressPainter({required this.waterIntakeLevel});

  @override
  void paint(Canvas canvas, Size size) {
    const double maxWaterSize = 512.0;

    // TODO - Using size and waterIntakeLevel to calculate the water level
    final waterLevel = min(
      maxWaterSize * (waterIntakeLevel / 10.0),
      maxWaterSize,
    );

    final paint = Paint()
      ..color = Colors.blueAccent.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    // TODO - Draw the water level on the canvas using rectangle and size from waterLevel
    canvas.drawRect(
      Rect.fromLTRB(
        0,
        size.height - waterLevel,
        size.width,
        size.height,
      ),
      paint,
    );

    paint
      ..color = Colors.green
      ..strokeWidth = 4.0;
    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, size.height),
      paint,
    );

    paint
      ..color = Colors.red
      ..strokeWidth = 4.0;
    canvas.drawLine(
      Offset(0, size.height - maxWaterSize),
      Offset(size.width, size.height - maxWaterSize),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant WaterProgressPainter oldDelegate) => true;
}

class WaterPainterWidget extends StatefulWidget {
  final double waterIntakeLevel;

  const WaterPainterWidget({super.key, required this.waterIntakeLevel});

  @override
  WaterPainterState createState() => WaterPainterState();
}

class WaterPainterState extends State<WaterPainterWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WaterProgressPainter(
        waterIntakeLevel: widget.waterIntakeLevel,
      ),
    );
  }
}
