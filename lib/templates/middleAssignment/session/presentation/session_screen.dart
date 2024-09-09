import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get_it/get_it.dart';

import 'notifier.dart';
import 'state.dart';
import '../../domain/shower_session.dart';
import '../../ui/foundation/app_label.dart';
import '../../ui/theme/theme.dart';

class SessionScreen extends ConsumerWidget {
  SessionScreen({super.key});

  final _provider = GetIt.instance<StateNotifierProvider<SessionNotifier, SessionState?>>();
  final AppTheme _theme = GetIt.instance<AppTheme>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_provider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _appBar(context),
      body: state == null ? _loadingStub() : _content(state),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
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
    title: AppLabel(text: AppLocalizations.of(context)!.shower_prefs_top_bar),
    backgroundColor: _theme.colors.background.primary,
  );

  Widget _loadingStub() => Container(
    alignment: Alignment.center,
    width: double.infinity,
    height: double.infinity,
    color: _theme.colors.background.primary,
    child: CircularProgressIndicator(color: _theme.colors.button.primary),
  );

  // _theme.colors.background.primary

  Widget _content(SessionState state) => Container(
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
  );
}
