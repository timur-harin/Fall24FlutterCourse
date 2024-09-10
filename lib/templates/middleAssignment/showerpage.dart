import 'dart:math';
import 'package:fall_24_flutter_course/templates/middleAssignment/providers.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/showersession.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowerPage extends ConsumerWidget {
  const ShowerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.read(settingsProvider);
    //ref.read(phaseElapsedProvider.notifier).restart();
    final phaseElapsed = ref.watch(phaseElapsedProvider);
    //print('${phase.elapsedTime}');

    return Scaffold(
      appBar: AppBar(
        title: Text('Contrast Shower Companion'),
        centerTitle: true,
        backgroundColor: Colors.blue
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 16),
            Text(
              'You decided to do ${settings.reps} repetitions of ${settings.hotDuration}s under hot water (${settings.hotTemperature} C), '
              'then ${settings.coldDuration}s under cold water (${settings.coldTemperature} C).',
              style: TextStyle(fontSize: 20)
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: (phaseElapsed[5] == 0) ? ([
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Go back to Settings'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => {ref.read(phaseElapsedProvider.notifier).startUpdating(
                    settings.hotDuration, settings.coldDuration, settings.reps)},
                  child: Text('Start'),
                ),
              ]) : (phaseElapsed[5] == 2) ? ([
                ElevatedButton(
                  onPressed: () {
                    settings.timeCompleted = DateTime.now();
                    ref.read(historyProvider.notifier).appendSession(settings);
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                  child: Text('Return to Home page'),
                ),
              ]) : ([
                ElevatedButton(
                  onPressed: () {
                    ref.read(phaseElapsedProvider.notifier).stopUpdating();
                  },
                  child: Text('Pause'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    ref.read(phaseElapsedProvider.notifier).stopUpdating();
                    ref.read(phaseElapsedProvider.notifier).finish();
                  },
                  child: Text('Finish'),
                ),
              ])
            ),
            SizedBox(height: 16),
            Text(
              (phaseElapsed[5] == 0) ? "Get ready!" :
              (phaseElapsed[5] == 2) ? "You finished, congratulations! You can return to Home page now." : 
              'Turn on ${phaseElapsed[1]%2 == 0 ? 'hot':'cold'} shower now. Remaining phases: ${(settings.reps*2 - phaseElapsed[1]).round()}',
              style: TextStyle(fontSize: 20)
            ),
            PhaseWidget(phase: phaseElapsed)
        ],
        )
      )
    );
  }
}

class PhaseWidget extends StatefulWidget {
  final List<double> phase;

  const PhaseWidget({super.key, required this.phase});

  @override
  PhaseWidgetState createState() => PhaseWidgetState();
}

class PhaseWidgetState extends State<PhaseWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height - 401,
      child: PhasePainterWidget(phase: widget.phase),
    );
  }
}

class PhasePainterWidget extends StatefulWidget {
  final List<double> phase;

  const PhasePainterWidget({super.key, required this.phase});

  @override
  PhasePainterState createState() => PhasePainterState();
}

class PhasePainterState extends State<PhasePainterWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PhasePainter(
        phase: widget.phase,
      ),
    );
  }
}

class PhasePainter extends CustomPainter {
  final List<double> phase;

  PhasePainter({required this.phase});

  @override
  void paint(Canvas canvas, Size size) {
    const double dt = 2;
    final double centerH = size.height / 2;
    final double centerW = size.width / 2;
    final double radius = min(size.height, size.width) / 4;
    final double targetTime = phase[2+phase[1].round()%2];
    final double progress = (phase[0]) / targetTime * 2 * pi;

    Color cp, cs;
    if(phase[1].round() == 0) {
      cp = Colors.red.shade600;
      cs = Colors.blue.shade600;
    } else {
      cp = Colors.blue.shade600;
      cs = Colors.red.shade600;
    }
    //print(targetTime / dt);
    final paint = Paint()
      ..color = (phase[0] > dt ? cp : Color.lerp(cs, cp, phase[0] / dt))!.withOpacity(1-min(phase[0] / dt * 0.8, 0.8))
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius / 4.0;

    canvas.drawCircle(Offset(centerW, centerH), radius, paint);
    paint.color = paint.color.withOpacity(1);
    canvas.drawArc(Rect.fromCircle(center: Offset(centerW, centerH), radius: radius), 0, progress, false, paint);
  }

  @override
  bool shouldRepaint(covariant PhasePainter oldDelegate) => true;
}