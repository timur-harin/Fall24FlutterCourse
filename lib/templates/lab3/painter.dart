import 'package:flutter/material.dart';

class WaterProgressPainter extends CustomPainter {
  final double waterIntakeLevel;

  WaterProgressPainter({
    required this.waterIntakeLevel,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const maxWaterLevel = 5.0;
    final waterLevel = size.height * (waterIntakeLevel / maxWaterLevel).clamp(0.0, 1.0); // Clamp to ensure it doesn't exceed 100%

    final paint = Paint()
      ..color = Colors.blueAccent.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTRB(0, size.height - waterLevel, size.width, size.height),
      paint,
    );
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
      painter: WaterProgressPainter(
        waterIntakeLevel: waterIntakeLevel,
      ),
      size: const Size(double.infinity, 500),
    );
  }
}
