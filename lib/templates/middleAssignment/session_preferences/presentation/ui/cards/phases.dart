import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get_it/get_it.dart';

import 'number_text_field.dart';
import '../../notifier.dart';
import '../../state.dart';
import '../../../../ui/theme/images.dart';
import '../../../../ui/theme/theme.dart';

const _phasesIconSize = 24.0;
const _phasesTextFieldWidth = 256.0;

class PhasesCard extends ConsumerWidget {
  PhasesCard({super.key});

  final _provider = GetIt.instance<StateNotifierProvider<PreferencesNotifier, PreferencesState>>();
  final _theme = GetIt.instance<AppTheme>();

  final _phasesController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) => Card(
    color: _theme.colors.background.card,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(_theme.dimensions.radius.small)),
    ),
    child: Container(
      margin: EdgeInsets.all(_theme.dimensions.padding.medium),
      child: _content(context, ref),
    ),
  );

  Widget _content(BuildContext context, WidgetRef ref) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _topLabel(context),
      SizedBox(height: _theme.dimensions.padding.small),
      _timeInput(context, ref),
    ],
  );

  Widget _topLabel(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Image(
        image: AssetImage(AppImages.load('ic_phases.png')),
        width: _phasesIconSize,
        height: _phasesIconSize,
        color: _theme.colors.text.onCard,
      ),

      SizedBox(width: _theme.dimensions.padding.small),

      Text(
        AppLocalizations.of(context)!.shower_prefs_hot_duration,
        style: _theme.typography.body.copyWith(
          color: _theme.colors.text.onCard,
        ),
      ),
    ],
  );

  Widget _timeInput(BuildContext context, WidgetRef ref) => ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: _phasesTextFieldWidth),
    child: NumberTextField(
      label: AppLocalizations.of(context)!.shower_pref_phases_label,
      textController: _phasesController,
      onChanged: (text) {
        ref.read(_provider.notifier).updateSessionPreferences(
          (state) => state.copyWith(phases: int.tryParse(text))
        );
      },
    ),
  );
}
