import 'package:fall_24_flutter_course/templates/middleAssignment/ui/theme/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get_it/get_it.dart';

import '../../ui/theme/theme.dart';
import 'notifier.dart';
import 'state.dart';

const _iconSize = 20.0;

class ApplyButton extends ConsumerWidget {
  ApplyButton({super.key});

  final _provider = GetIt.instance<StateNotifierProvider<PreferencesNotifier, PreferencesState>>();
  final _theme = GetIt.instance<AppTheme>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEnabled = ref.watch(_provider.notifier).isSessionCreationReady;

    return OutlinedButton.icon(
      icon: Image(
        image: AssetImage(AppImages.load('ic_shower.png')),
        color: _theme.colors.button.primary,
        width: _iconSize,
        height: _iconSize,
      ),
      onPressed: !isEnabled ? null : () {
        /* TODO: Show Session screen */
        // Navigator.of(context).push(
        //     MaterialPageRoute(
        //         builder: (context) {
        //           /* TODO: Show Session screen */
        //         },
        //         settings: const RouteSettings()
        //     )
        // )
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: _theme.colors.button.primary,
        side: BorderSide(color: _theme.colors.button.primary),
        padding: EdgeInsets.only(
          top: _theme.dimensions.padding.extraMedium,
          bottom: _theme.dimensions.padding.extraMedium,
          left: _theme.dimensions.padding.extraMedium,
          right: _theme.dimensions.padding.extraMedium,
        ),
      ),
      label: Text(
        AppLocalizations.of(context)!.shower_pref_begin,
        style: _theme.typography.body.copyWith(
          color: _theme.colors.text.onButton,
        ),
      ),
    );
  }
}