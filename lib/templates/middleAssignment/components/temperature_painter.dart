import 'package:flutter/material.dart';

// Создаем кастомного painter для отрисовки круга и температуры
class TemperaturePainter extends CustomPainter {
  final double temperature;
  final Color color;

  TemperaturePainter({required this.temperature, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // Рисуем круг
    Paint paint = Paint()..color = color;
    canvas.drawCircle(size.center(Offset.zero), 100, paint);

    // Рисуем текст температуры
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: '${temperature.toStringAsFixed(1)}°C',
        style: TextStyle(color: Colors.white, fontSize: 36),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
