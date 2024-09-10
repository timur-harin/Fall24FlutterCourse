import 'package:fall_24_flutter_course/templates/middleAssignment/appTheme/cold_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../presentation/screens/overview/session_overview_notifier.dart';
import 'hot_theme.dart';

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(coldTheme);

  void setTheme(Temperature temperature) {
    if (temperature == Temperature.cold) {
      state = coldTheme;
    } else {
      state = hotTheme;
    }
  }
}

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});
