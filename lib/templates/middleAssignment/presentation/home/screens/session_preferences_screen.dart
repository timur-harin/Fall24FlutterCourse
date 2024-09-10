import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';

import '../../../app_router/app_router.gr.dart';
import '../widgets/start_session_floating_button.dart';
import '../widgets/time_picker_widget.dart';
import 'session_preferences_notifier.dart';
import 'session_preferences_state.dart';

final _localProvider =
    StateNotifierProvider<CreateSessionNotifier, CreateSessionState>(
  (ref) => CreateSessionNotifier(),
);

@RoutePage()
class SessionPreferencesScreen extends ConsumerWidget {
  const SessionPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionState = ref.watch(_localProvider);
    final stateNotifier = ref.read(_localProvider.notifier);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimePickerWidget(
              onChanged: (int value) =>
                  stateNotifier.updateColdIntervalMinutes(value),
              accent: Colors.red,
              title: 'Choose hot interval',
            ),
            const SizedBox(height: 16.0),
            TimePickerWidget(
              onChanged: (int value) =>
                  stateNotifier.updateHotIntervalMinutes(value),
              title: 'Choose cold interval',
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Number of Sets:'),
                SizedBox(
                  width: 64,
                  child: TextFormField(
                    initialValue: '3',
                    onChanged: (value) => stateNotifier
                        .updateNumberOfSets(int.tryParse(value) ?? 0),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Start with:'),
                NeumorphicRadio(
                  groupValue: sessionState.startWithCold,
                  value: true,
                  onChanged: (_) => stateNotifier.toggleStartWithCold(),
                  child: const Text('Cold'),
                ),
                NeumorphicRadio(
                  groupValue: sessionState.startWithCold,
                  value: false,
                  onChanged: (_) => stateNotifier.toggleStartWithCold(),
                  child: const Text('Hot'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: StartSessionFloatingButton(
        title: 'Start Shower',
        onPressed: () {
          context.pushRoute(SessionOverviewRoute(createdSession: sessionState));
        },
      ),
    );
  }
}
