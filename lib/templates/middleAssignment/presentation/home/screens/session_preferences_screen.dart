import 'package:auto_route/auto_route.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/appTheme/cold_theme.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/appTheme/hot_theme.dart';
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
      appBar: AppBar(
        title: Text('Session Preferences'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTimePicker(
              context,
              title: 'Choose Hot Interval: ${sessionState.hotIntervalSeconds}s',
              color: hotTheme.primaryColor,
              onChanged: (value) =>
                  stateNotifier.updateHotIntervalMinutes(value),
            ),
            const SizedBox(height: 16.0),
            _buildTimePicker(
              context,
              title: 'Choose Cold Interval: ${sessionState.coldIntervalSeconds}s',
              color: coldTheme.primaryColor,
              onChanged: (value) =>
                  stateNotifier.updateColdIntervalMinutes(value),
            ),
            const SizedBox(height: 24.0),
            _buildNumberOfSetsField(context, stateNotifier),
            const SizedBox(height: 24.0),
            _buildStartWithRadioGroup(context, sessionState, stateNotifier),
            const SizedBox(height: 32.0),
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

  Widget _buildTimePicker(
    BuildContext context, {
    required String title,
    required Color color,
    required ValueChanged<int> onChanged,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TimePickerWidget(
          onChanged: onChanged,
          accent: color,
          title: title,
          initialValue: 7,
        ),
      ),
    );
  }

  Widget _buildNumberOfSetsField(
      BuildContext context, CreateSessionNotifier stateNotifier) {
    return Row(
      children: [
        Icon(Icons.repeat, color: Theme.of(context).primaryColor),
        const SizedBox(width: 8.0),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Number of Sets (3 by Default)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) =>
                stateNotifier.updateNumberOfSets(int.tryParse(value) ?? 0),
          ),
        ),
      ],
    );
  }

  Widget _buildStartWithRadioGroup(
      BuildContext context, sessionState, CreateSessionNotifier stateNotifier) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Start with:'),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: Text('Cold'),
                    value: true,
                    groupValue: sessionState.startWithCold,
                    onChanged: (_) => stateNotifier.toggleStartWithCold(),
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text('Hot'),
                    value: false,
                    groupValue: sessionState.startWithCold,
                    onChanged: (_) => stateNotifier.toggleStartWithCold(),
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
