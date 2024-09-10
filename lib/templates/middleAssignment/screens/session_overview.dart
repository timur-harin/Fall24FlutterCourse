import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/shower_session.dart';
import '../providers/session_provider.dart';
import 'active_session.dart';

class SessionOverviewScreen extends ConsumerWidget {
  const SessionOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPreferences = ref.watch(userPreferencesProvider);

    final cycleDuration = userPreferences.hotPhaseDuration + userPreferences.coldPhaseDuration;
    final hotPhaseRatio = userPreferences.hotPhaseDuration / cycleDuration;
    final coldPhaseRatio = userPreferences.coldPhaseDuration / cycleDuration;
    final totalSessionSeconds = userPreferences.sessionLength * 60;
    final numberOfCycles = (totalSessionSeconds / cycleDuration).floor();
    final actualSessionTime = numberOfCycles * cycleDuration;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Session Overview',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: const Size(120, 120),
                    painter: DualProgressPainter(hotPhaseRatio, coldPhaseRatio),
                  ),
                  Text(
                    '$numberOfCycles',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Icon(Icons.wb_sunny, color: Colors.orange, size: 30),
                const SizedBox(width: 8),
                Text(
                  'Hot Phase: ${userPreferences.hotPhaseDuration} seconds',
                  style: const TextStyle(fontSize: 18, color: Colors.orange),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.ac_unit, color: Colors.blue, size: 30),
                const SizedBox(width: 8),
                Text(
                  'Cold Phase: ${userPreferences.coldPhaseDuration} seconds',
                  style: const TextStyle(fontSize: 18, color: Colors.blue),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Icon(Icons.timer, color: Colors.black, size: 30),
                const SizedBox(width: 8),
                Text(
                  'Total Length: ${userPreferences.sessionLength} min',
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.loop, color: Colors.black, size: 30),
                const SizedBox(width: 8),
                Text(
                  'Cycles: $numberOfCycles',
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.black, size: 30),
                const SizedBox(width: 8),
                Text(
                  'Actual Time: $actualSessionTime s',
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final phases = List.generate(numberOfCycles, (_) => [
                    TemperaturePhase(type: 'HOT', duration: userPreferences.hotPhaseDuration),
                    TemperaturePhase(type: 'COLD', duration: userPreferences.coldPhaseDuration),
                  ]).expand((i) => i).toList();

                  ref.read(showerSessionProvider.notifier).startSession(phases);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ActiveSessionScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Start',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DualProgressPainter extends CustomPainter {
  final double hotPhaseRatio;
  final double coldPhaseRatio;

  DualProgressPainter(this.hotPhaseRatio, this.coldPhaseRatio);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint hotPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0
      ..strokeCap = StrokeCap.round;

    final Paint coldPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0
      ..strokeCap = StrokeCap.round;

    const double startAngle = -90.0 * 3.1415926535897932 / 180.0;
    final double hotSweepAngle = 360.0 * hotPhaseRatio * 3.1415926535897932 / 180.0;
    final double coldSweepAngle = 360.0 * coldPhaseRatio * 3.1415926535897932 / 180.0;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2),
      startAngle,
      hotSweepAngle,
      false,
      hotPaint,
    );
    
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2),
      startAngle + hotSweepAngle,
      coldSweepAngle,
      false,
      coldPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
