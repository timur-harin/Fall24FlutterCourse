import 'package:auto_route/auto_route.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/presentation/home/screens/session_preferences_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';

import '../../../appTheme/theme_notifier.dart';
import 'session_overview_notifier.dart';
import 'session_overview_state.dart';

final sessionOverviewNotifierProvider = StateNotifierProvider.family<
    SessionOverviewNotifier, SessionOverviewState, CreateSessionState>(
  (ref, createdSession) => SessionOverviewNotifier(
    SessionOverviewState(
      createdSession: createdSession,
      secondsLeft: createdSession.startWithCold
          ? createdSession.coldIntervalMinutes
          : createdSession.hotIntervalMinutes,
    ),
    ref.read(themeNotifierProvider.notifier).setTheme,
  ),
);

@RoutePage()
class SessionOverviewScreen extends ConsumerWidget {
  const SessionOverviewScreen({super.key, required this.createdSession});

  final CreateSessionState createdSession;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionOverviewState =
        ref.watch(sessionOverviewNotifierProvider(createdSession));
    final sessionOverviewNotifier =
        ref.read(sessionOverviewNotifierProvider(createdSession).notifier);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            NeumorphicButton(
              style: NeumorphicStyle(
                boxShape: const NeumorphicBoxShape.circle(),
                color: Theme.of(context).primaryColor,
              ),
              onPressed: _action(sessionOverviewState, sessionOverviewNotifier),
              child: Container(
                width: 128.0,
                height: 128.0,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Center(
                  child: Text(_actionButtonText(sessionOverviewState)),
                ),
              ),
            ),
            Text('Current set: ${sessionOverviewState.currentSet}'),
          ],
        ),
      ),
    );
  }

  VoidCallback? _action(
          SessionOverviewState state, SessionOverviewNotifier notifier) =>
      state.sessionState == SessionState.notStarted
          ? notifier.startTimer
          : null;

  String _actionButtonText(SessionOverviewState state) =>
      state.sessionState == SessionState.notStarted
          ? 'Start'
          : state.sessionState == SessionState.finished
              ? 'Finished'
              : state.secondsLeft.toString();
}
