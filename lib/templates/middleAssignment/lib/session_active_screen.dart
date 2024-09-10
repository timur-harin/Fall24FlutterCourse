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
    )
      ..repeat();

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
          _saveSession(widget.session, interrupted: false);
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

  Future<void> _saveSession(ShowerSession session, {bool interrupted = false}) async {
    final box = await Hive.openBox<ShowerSession>('sessionsBox');
    if (interrupted) {
      final interruptedSession = ShowerSession(
        phases: session.phases,
        date: session.date,
        totalDuration: session.totalDuration,
        interrupted: true,
      );
      await box.add(interruptedSession);
    } else {
      await box.add(session);
    }
    await box.close();
  }

  Future<bool> _onWillPop() async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('End Session?'),
        content: Text('Do you really want to end the session?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes'),
          ),
        ],
      ),
    ) ?? false;

    if (shouldExit) {
      // Save the session as "interrupted"
      await _saveSession(widget.session, interrupted: true);
      ref.read(sessionProvider.notifier).endSession();
      Navigator.of(context).pop(); // Go back to the previous screen
    }

    return false; // Prevent default back navigation
  }

  @override
  Widget build(BuildContext context) {
    // Define colors for hot phase
    final Color hotButtonColor = const Color(0xFFF28B82);
    final Color hotTextColor = const Color(0xFFFEF7FF);
    final Color hotTextColorOutsideButton = const Color(0xFF6750A4);
    final Color hotAppBarColor = hotTextColorOutsideButton;
    final Color hotBackgroundColor = const Color(0xFFFAD2CF);
    final Color hotCircleColor = const Color(0xFFFF9999);

    // Define colors for cold phase
    final Color coldButtonColor = const Color(0xFFA7C7E7);
    final Color coldTextColor = hotTextColor;
    final Color coldTextColorOutsideButton = hotTextColorOutsideButton;
    final Color coldAppBarColor = coldTextColorOutsideButton;
    final Color coldBackgroundColor = const Color(0xFFE1F3FF);
    final Color coldCircleColor = const Color(0xFFB3D9FF);

    final Color backgroundColor = currentPhase.isHot ? hotBackgroundColor
        : coldBackgroundColor;
    final Color buttonColor = currentPhase.isHot
        ? hotButtonColor : coldButtonColor;
    final Color appBarColor = currentPhase
        .isHot ? hotAppBarColor : coldAppBarColor;
    final Color circleColor
    = currentPhase.isHot ? hotCircleColor : coldCircleColor;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Active Shower Session',
            style: TextStyle(color: appBarColor),
          ),
          backgroundColor: backgroundColor,
        ),
        body: Stack(
          children: [
            // Circle decoration behind button, aligned with button
            Center(
                child: Column(
                  children: [
                    const SizedBox(height: 345,),
                    CustomPaint(
                      size: const Size(270, 270), // Adjust size as needed
                      painter: CirclePainter(color: circleColor),
                    ),
                  ],
                )
            ),
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
                    currentPhase.isHot ? 'Hot!' : 'Cold!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: hotTextColorOutsideButton,
                    ),
                  ),
                  const SizedBox(height: 170),
                  ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(100),
                    ),
                    child: Text(
                      '$remainingTime',
                      style: TextStyle(
                        color: hotTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 48,),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CirclePainter for drawing the circle
class CirclePainter extends CustomPainter {
  final Color color;

  CirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Draw circle at the center of the canvas
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
