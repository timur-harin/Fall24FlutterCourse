import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:showerPackage/bubble_painter.dart';
import 'shower_session.dart';
import 'session_provider.dart';
import 'session_completion_screen.dart';

class SessionActiveScreen extends ConsumerStatefulWidget {
  final ShowerSession session;

  const SessionActiveScreen({super.key, required this.session});

  @override
  _SessionActiveScreenState createState() => _SessionActiveScreenState();
}

class _SessionActiveScreenState extends ConsumerState<SessionActiveScreen>
    with SingleTickerProviderStateMixin {
  int currentPhaseIndex = 0;
  late TemperaturePhase currentPhase;
  late int remainingTime;
  late AnimationController _bubbleController;

  @override
  void initState() {
    super.initState();
    currentPhase = widget.session.phases[currentPhaseIndex];
    remainingTime = currentPhase.duration;

    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();

    startTimer();
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    super.dispose();
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
        startTimer();
      } else {
        if (currentPhaseIndex < widget.session.phases.length - 1) {
          setState(() {
            currentPhaseIndex++;
            currentPhase = widget.session.phases[currentPhaseIndex];
            remainingTime = currentPhase.duration;
          });
          startTimer();
        } else {
          _saveSession(widget.session);
          ref.read(sessionProvider.notifier).endSession();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SessionCompletionScreen(),
            ),
          );
        }
      }
    });
  }

  Future<void> _saveSession(ShowerSession session) async {
    final box = await Hive.openBox<ShowerSession>('sessionsBox');
    await box.add(session);
    await box.close();
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        currentPhase.isHot ? Colors.red.shade100 : Colors.blue.shade100;
    final Color buttonColor =
        currentPhase.isHot ? Colors.pink.shade200 : Colors.purple.shade200;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Active Shower Session'),
        backgroundColor: backgroundColor,
      ),
      body: Stack(
        children: [
          Center(
            child: CustomPaint(
              size: Size.infinite,
              painter: BubblePainter(
                _bubbleController,
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(height: 140),
                Text(
                  currentPhase.isHot ? 'Hot Phase' : 'Cold Phase',
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 170),
                ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(100),
                    textStyle: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text(
                    '$remainingTime',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
