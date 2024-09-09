import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get_it/get_it.dart';

import 'notifier.dart';
import 'state.dart';
import '../../domain/shower_session.dart';
import '../../session/presentation/ui/valve/valve.dart';
import '../../ui/foundation/app_label.dart';
import '../../ui/theme/images.dart';
import '../../ui/theme/theme.dart';

const _topBarIcon = 24.0;

class SessionScreen extends ConsumerWidget {
  SessionScreen({super.key});

  final _provider = GetIt.instance<StateNotifierProvider<SessionNotifier, SessionState?>>();
  final _theme = GetIt.instance<AppTheme>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_provider);
    final notifier = ref.read(_provider.notifier);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: state == null ? null : _appBar(context, state),
      body: state == null ? _loadingStub() : _content(state, notifier),
    );
  }

  AppBar _appBar(BuildContext context, SessionState state) =>
      AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            // TODO: Show exit dialog
            // Navigator.of(context).pop()
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: _theme.colors.text.topBar,
          ),
        ),
        title: AppLabel(
          text: _topBarLabel(context, state),
          icon: Image(
            image: AssetImage(AppImages.load(_topBarIconRes(state.phase))),
            height: _topBarIcon,
          ),
        ),
        backgroundColor: _theme.colors.background.primary,
      );

  String _topBarLabel(BuildContext context, SessionState state) {
    final strings = AppLocalizations.of(context)!;

    final session = switch (state.phase) {
      ShowerPhase.cold => strings.shower_session_top_bar_cold,
      ShowerPhase.hot => strings.shower_session_top_bar_hot,
    };

    return '${strings.shower_session_top_bar_phase} ${state.currentPhaseNumber + 1}/${state.totalPhases}: $session';
  }

  String _topBarIconRes(ShowerPhase phase) => switch (phase) {
    ShowerPhase.hot => 'ic_fire.png',
    ShowerPhase.cold => 'ic_snowflake.png',
  };

  Widget _loadingStub() => Container(
    alignment: Alignment.center,
    width: double.infinity,
    height: double.infinity,
    color: _theme.colors.background.primary,
    child: CircularProgressIndicator(color: _theme.colors.button.primary),
  );

  // _theme.colors.background.primary

  Widget _content(SessionState state, SessionNotifier notifier) => Container(
    alignment: Alignment.center,
    width: double.infinity,
    height: double.infinity,
    decoration: BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            _theme.colors.background.primary,
            state.phase == ShowerPhase.hot
                ? _theme.colors.background.hot
                : _theme.colors.background.cold,
          ],
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // TODO: нарисовать вентиль, таймер, паузу
        Valve(
            phase: state.phase,
            onClick: () => notifier.onValveClick(),
        ),
      ],
    ),
  );
}
