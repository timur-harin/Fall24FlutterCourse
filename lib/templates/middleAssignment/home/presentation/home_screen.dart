import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get_it/get_it.dart';

import '../../ui/foundation/app_label.dart';
import '../../home/presentation/ui/sessions/sessions.dart';
import '../../ui/theme/theme.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final AppTheme _theme = GetIt.instance<AppTheme>();

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: _appBar(context),
        backgroundColor: _theme.colors.background.primary,
        body: ShowerSessionsColumn(),
      );

  AppBar _appBar(BuildContext context) =>
      AppBar(
        centerTitle: false,
        leadingWidth: _theme.dimensions.padding.medium,
        title: AppLabel(text: AppLocalizations.of(context)!.shower_app_name),
        backgroundColor: _theme.colors.background.primary,
      );
}