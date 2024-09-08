import 'package:fall_24_flutter_course/templates/middleAssignment/session_preferences/ui/cards/phases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get_it/get_it.dart';

import '../../../ui/theme/theme.dart';
import 'cold.dart';
import 'hot.dart';

class PreferencesCards extends ConsumerWidget {
  PreferencesCards({super.key});

  final _theme = GetIt.instance<AppTheme>();

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HotDurationCard(),
            SizedBox(height: _theme.dimensions.padding.extraMedium),
            ColdDurationCard(),
            SizedBox(height: _theme.dimensions.padding.extraMedium),
            PhasesCard(),
          ],
        ),
      );
}
