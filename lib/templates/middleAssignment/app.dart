import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'home/presentation/home_screen.dart';

class ContrastShowerApp extends StatelessWidget {
  const ContrastShowerApp({super.key});

  @override
  Widget build(BuildContext context) =>
      MaterialApp(
        title: 'Middle Assignment',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: HomeScreen(),
      );
}
