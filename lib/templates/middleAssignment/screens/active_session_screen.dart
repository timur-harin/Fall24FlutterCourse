import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/active_session_provider.dart';
import '../widgets/temperature_transition_animation.dart';
import '../models/temperature_phase.dart';

class ActiveSessionScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeSession = ref.watch(activeSessionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Active Session'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TemperatureTransitionAnimation(
            isHot: activeSession.currentPhase == TemperaturePhase.hot,
          ),
          SizedBox(height: 20),
          Text(
            '${activeSession.currentPhase == TemperaturePhase.hot ? "Hot" : "Cold"} Phase',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            '${activeSession.remainingTime} seconds',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 20),
          _buildControlButtons(context, ref),
        ],
      ),
    );
  }

  Widget _buildControlButtons(BuildContext context, WidgetRef ref) {
    final isActive = ref.watch(activeSessionProvider.select((session) => session.isActive));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          child: Text(isActive ? 'Pause' : 'Resume'),
          onPressed: () {
            if (isActive) {
              ref.read(activeSessionProvider.notifier).pauseSession();
            } else {
              ref.read(activeSessionProvider.notifier).resumeSession( context);
            }
          },
        ),
        ElevatedButton(
          child: Text('End Session'),
          onPressed: () {
            ref.read(activeSessionProvider.notifier).endSession( context);
            Navigator.pushReplacementNamed(context, '/summary');
          },
        ),
      ],
    );
  }
}
