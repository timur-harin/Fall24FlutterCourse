import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  final int totalDuration;
  final int hotDuration;
  final int coldDuration;
  final Duration remainingTime;
  final bool isHotPhase;

  const TimerWidget({
    super.key,
    required this.totalDuration,
    required this.hotDuration,
    required this.coldDuration,
    required this.remainingTime,
    required this.isHotPhase,
  });

  @override
  Widget build(BuildContext context) {
    String timeText = _formatDuration(remainingTime);
    Color phaseColor = isHotPhase ? Colors.red : Colors.blue;

    return Column(
      children: [
        Text(timeText, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: phaseColor,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
