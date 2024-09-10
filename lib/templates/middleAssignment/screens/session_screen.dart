import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/animated_phase_widget.dart';
import '../providers/current_session_provider.dart';

class SessionScreen extends ConsumerStatefulWidget {
  const SessionScreen({super.key});

  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends ConsumerState<SessionScreen> {
  bool isPaused = false;

  void _pauseOrResume() {
    setState(() {
      isPaused = !isPaused;
      final notifier = ref.read(currentSessionProvider.notifier);
      if (isPaused) {
        notifier.pauseSession();
      } else {
        notifier.resumeSession();
      }
    });
  }

  void _endSession() {
    if (!isPaused) {
      _pauseOrResume();
    }
    
    final notifier = ref.read(currentSessionProvider.notifier);
    notifier.endSession();
    Navigator.pushNamed(context, '/session_summary');
  }

  @override
  Widget build(BuildContext context) {
    final currentSession = ref.watch(currentSessionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shower Session'),
        backgroundColor: Colors.blueAccent,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: AnimatedPhaseWidget(
                currentSession: currentSession,
                isPaused: isPaused,
                onPause: () {},
                onResume: () {},
                onSessionEnd: () {
                  ref.read(currentSessionProvider.notifier).endSession();
                  Navigator.pushNamed(context, '/session_summary');
                },
                onStopTimer: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _pauseOrResume,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    backgroundColor: isPaused ? Colors.green : Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: Icon(isPaused ? Icons.play_arrow : Icons.pause, size: 20),
                  label: Text(isPaused ? 'Resume' : 'Pause', style: const TextStyle(fontSize: 16)),
                ),
                ElevatedButton.icon(
                  onPressed: _endSession,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.stop, size: 20),
                  label: const Text('End Session', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
