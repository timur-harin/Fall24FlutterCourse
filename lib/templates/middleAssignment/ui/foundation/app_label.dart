import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import '../../ui/theme/theme.dart';

class AppLabel extends StatelessWidget {
  final String text;
  final Image? icon;

  final AppTheme _theme = GetIt.instance<AppTheme>();

  AppLabel({super.key, required this.text, this.icon});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      icon,
      icon == null ? null : SizedBox(width: _theme.dimensions.padding.small),
      Text(
        text,
        style: _theme.typography.h.h2.copyWith(
          color: _theme.colors.text.topBar,
        ),
      ),
    ].whereType<Widget>().toList(),
  );
}
