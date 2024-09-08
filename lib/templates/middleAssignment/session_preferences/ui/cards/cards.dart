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
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HotDurationCard(),
          SizedBox(height: _theme.dimensions.padding.extraMedium),
          ColdDurationCard(),
        ],
      );
}
