import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get_it/get_it.dart';

import 'number_text_field.dart';
import '../../notifier.dart';
import '../../state.dart';
import '../../../../ui/theme/images.dart';
import '../../../../ui/theme/theme.dart';

const _hotIconSize = 24.0;
const _timeTextFieldWidth = 128.0;

class HotDurationCard extends ConsumerWidget {
  HotDurationCard({super.key});

  final _provider = GetIt.instance<StateNotifierProvider<PreferencesNotifier, PreferencesState>>();
  final _theme = GetIt.instance<AppTheme>();

  final _minutesController = TextEditingController();
  final _secondsController = TextEditingController();

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
        image: AssetImage(AppImages.load('ic_hot.png')),
        width: _hotIconSize,
        height: _hotIconSize,
      ),

      SizedBox(width: _theme.dimensions.padding.extraSmall),

      Text(
        AppLocalizations.of(context)!.shower_prefs_hot_duration,
        style: _theme.typography.body.copyWith(
          color: _theme.colors.text.onCard,
        ),
      ),
    ],
  );

  Widget _timeInput(BuildContext context, WidgetRef ref) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: _timeTextFieldWidth,
        ),
        child: NumberTextField(
          label: AppLocalizations.of(context)!.shower_minutes,
          textController: _minutesController,
          onChanged: (text) {
            ref.read(_provider.notifier).updateSessionPreferences(
              (state) => state.copyWith(hotMinutes: int.tryParse(text))
            );
          },
        ),
      ),

      SizedBox(width: _theme.dimensions.padding.medium),

      ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: _timeTextFieldWidth,
        ),
        child: NumberTextField(
          label: AppLocalizations.of(context)!.shower_seconds,
          textController: _secondsController,
          onChanged: (text) {
            ref.read(_provider.notifier).updateSessionPreferences(
              (state) => state.copyWith(hotSeconds: int.tryParse(text))
            );
          },
        ),
      ),
    ],
  );
}
