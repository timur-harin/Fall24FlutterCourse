import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_preferences.dart';
import '../providers/user_preferences_provider.dart';
import '../providers/current_session_provider.dart';
import '../models/shower_session.dart';
import '../models/temperature_phase.dart';

class PreferencesScreen extends ConsumerWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(userPreferencesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Preferences'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Select Temperature Intervals:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<int>(
              value: preferences.numberOfPhases,
              items: List.generate(5, (index) => index + 2).map((int value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text('$value Intervals'),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  ref.read(userPreferencesProvider.notifier).update(
                    (state) => UserPreferences(
                      phaseDurations: List.generate(value, (index) => const Duration(seconds: 60)), // Default to 60 seconds
                      numberOfPhases: value,
                      isHotFirst: state.isHotFirst,
                    ),
                  );
                }
              },
            ),

            const SizedBox(height: 16),
            _buildPhaseSwitch(
              isHotFirst: preferences.isHotFirst,
              onChanged: (value) {
                ref.read(userPreferencesProvider.notifier).update(
                  (state) => state.copyWith(
                    isHotFirst: value,
                  ),
                );
              },
            ),

            const SizedBox(height: 16),
            // Scrollable block for sliders
            Expanded(
              child: SingleChildScrollView(  // Only this section is scrollable
                child: Column(
                  children: List.generate(preferences.numberOfPhases, (index) {
                    final phaseDuration = preferences.phaseDurations[index];
                    final isHot = (preferences.isHotFirst && index % 2 == 0) || (!preferences.isHotFirst && index % 2 == 1);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: _buildPhaseSlider(
                        index: index,
                        label: isHot ? 'Hot Phase ${(index) ~/ 2 + 1} Duration' : 'Cold Phase ${(index) ~/ 2 + 1} Duration',
                        duration: phaseDuration,
                        onChanged: (value) {
                          final updatedDurations = List<Duration>.from(preferences.phaseDurations);
                          updatedDurations[index] = Duration(seconds: value.toInt());
                          ref.read(userPreferencesProvider.notifier).update(
                            (state) => state.copyWith(
                              phaseDurations: updatedDurations,
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ),
              ),
            ),

            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                final session = createSessionFromPreferences(ref);

                ref.read(currentSessionProvider.notifier).startSession(session);

                Navigator.pushNamed(context, '/session_overview');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text(
                'Proceed to Overview',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhaseSlider({
    required int index,
    required String label,
    required Duration duration,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ${duration.inSeconds} seconds',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Slider(
          value: duration.inSeconds.toDouble(),
          min: 10,
          max: 300,
          divisions: 29,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildPhaseSwitch({
    required bool isHotFirst,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'First Phase Type:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Switch(
          value: isHotFirst,
          onChanged: onChanged,
        ),
        Text(
          isHotFirst ? 'Hot' : 'Cold',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.blueAccent,
          ),
        ),
      ],
    );
  }

  ShowerSession createSessionFromPreferences(WidgetRef ref) {
    final preferences = ref.read(userPreferencesProvider);

    List<TemperaturePhase> phases = [];
    int totalTimeTaken = 0;

    for (int i = 0; i < preferences.numberOfPhases; i++) {
      bool isHot = (preferences.isHotFirst && i % 2 == 0) || (!preferences.isHotFirst && i % 2 == 1);
      phases.add(
        TemperaturePhase(
          isHot: isHot,
          duration: preferences.phaseDurations[i],
        ),
      );
      totalTimeTaken += preferences.phaseDurations[i].inSeconds;
    }
    return ShowerSession(
      phases: phases,
      totalTime: Duration(seconds: totalTimeTaken),
      dateTime: DateTime.now(), 
      rating: 5,
    );
  }
}

extension on UserPreferences {
  UserPreferences copyWith({
    List<Duration>? phaseDurations,
    int? numberOfPhases,
    bool? isHotFirst,
  }) {
    return UserPreferences(
      phaseDurations: phaseDurations ?? this.phaseDurations,
      numberOfPhases: numberOfPhases ?? this.numberOfPhases,
      isHotFirst: isHotFirst ?? this.isHotFirst,
    );
  }
}
