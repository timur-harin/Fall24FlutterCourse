import 'package:flutter/material.dart';

class WaterProgressPainter extends CustomPainter {
  final double waterIntakeLevel;

  WaterProgressPainter({
    required this.waterIntakeLevel,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final waterLevel = size.height * (1 - waterIntakeLevel / 2.0); // assuming the target is 2.0 liters

    final paint = Paint()
      ..color = Colors.blueAccent.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTRB(0, waterLevel, size.width, size.height),
      paint,
    ); // TODO - Draw the water level on the canvas using rectangle and size from waterLevel
  }

  @override
  bool shouldRepaint(covariant WaterProgressPainter oldDelegate) => true;
}

class WaterPainterWidget extends StatelessWidget {
  final double waterIntakeLevel;

  const WaterPainterWidget({super.key, required this.waterIntakeLevel});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(1000, 200), // Fixed size for visualization
      painter: WaterProgressPainter(
        waterIntakeLevel: waterIntakeLevel,
      ),
    );
  }
}
