import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/session_provider.dart';
import 'session_summary.dart';

class ActiveSessionScreen extends ConsumerWidget {
  const ActiveSessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(showerSessionProvider);
    final sessionNotifier = ref.read(showerSessionProvider.notifier);
    if (session == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final lastSession = ref.read(sessionHistoryProvider).isNotEmpty
            ? ref.read(sessionHistoryProvider).last
            : null;

        if (lastSession != null && lastSession.key != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SessionSummaryScreen(
                session: lastSession,
                sessionKey: lastSession.key as int,
              ),
            ),
          );
        }
      });
    }
    
    final remainingTime = session?.totalDuration ?? 0;
    final remainingPhaseTime = sessionNotifier.remainingPhaseTime;
    final isPaused = session?.isPaused ?? false;
    final currentPhase = session?.phases[sessionNotifier.currentPhaseIndex].type ?? 'N/A';

    final isHotPhase = currentPhase.toLowerCase() == 'hot';
    final backgroundColor = isHotPhase ? Colors.orange : Colors.blue;
    final phaseIcon = isHotPhase ? Icons.wb_sunny : Icons.ac_unit;

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: backgroundColor,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$remainingPhaseTime s left in phase',
              style: const TextStyle(
                fontSize: 22, 
                fontWeight: FontWeight.w400, 
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              currentPhase,
              style: const TextStyle(
                fontSize: 28, 
                fontWeight: FontWeight.w500, 
                color: Colors.white,
              ),
            ),
            Icon(
              phaseIcon,
              size: 80,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            Text(
              '$remainingTime s',
              style: const TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.w300, 
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    if (isPaused) {
                      sessionNotifier.resumeSession();
                    } else {
                      sessionNotifier.pauseSession();
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 2.0, color: Colors.white),
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    isPaused ? 'Resume' : 'Pause',
                    style: const TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.w500, 
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: () {
                    sessionNotifier.endSession();
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 2.0, color: Colors.red),
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'End',
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.w500, 
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
