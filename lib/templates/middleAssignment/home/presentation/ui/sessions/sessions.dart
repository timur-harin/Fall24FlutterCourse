import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get_it/get_it.dart';

import '../../../../domain/shower_session.dart';
import '../../../../session_preferences/presentation/preferences_screen.dart';
import '../../../../ui/theme/images.dart';
import '../../../../ui/theme/theme.dart';
import 'notifier.dart';

const _imageStubSize = 256.0;

class ShowerSessionsColumn extends ConsumerWidget {
  ShowerSessionsColumn({super.key});

  final _provider = GetIt.instance<StateNotifierProvider<ShowerSessionsNotifier, List<ShowerSession>>>();
  final _theme = GetIt.instance<AppTheme>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(_provider);
    final notifier = ref.read(_provider.notifier);
    return sessions.isEmpty ? _emptyStub(context, notifier) : _sessionsColumn();
  }

  Widget _sessionsColumn() => Column();

  Widget _emptyStub(BuildContext context, ShowerSessionsNotifier notifier) =>
      Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.only(bottom: _theme.dimensions.padding.large),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: AssetImage(AppImages.load('bath.png')),
              width: _imageStubSize,
              height: _imageStubSize,
            ),
            SizedBox(height: _theme.dimensions.padding.extraBig),
            _startSessionsButton(context, notifier, isFirstSession: true)
          ],
        ),
      );

  Widget _startSessionsButton(
      BuildContext context,
      ShowerSessionsNotifier notifier,
      {required bool isFirstSession}
  ) {
    final local = AppLocalizations.of(context)!;

    final text = isFirstSession
        ? local.shower_home_start_first_session
        : local.shower_home_start_session;

    return OutlinedButton.icon(
      icon: Icon(Icons.add, color: _theme.colors.button.primary),
      onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => SessionPreferencesScreen(),
              settings: const RouteSettings()
          )
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: _theme.colors.button.primary,
        side: BorderSide(color: _theme.colors.button.primary),
        padding: EdgeInsets.only(
          top: _theme.dimensions.padding.medium,
          bottom: _theme.dimensions.padding.medium,
          left: _theme.dimensions.padding.extraMedium,
          right: _theme.dimensions.padding.extraMedium,
        ),
      ),
      label: Text(
        text,
        style: _theme.typography.body.copyWith(
          color: _theme.colors.text.onButton,
        ),
      ),
    );
  }
}
