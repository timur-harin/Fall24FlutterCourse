import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.blue,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
    displayMedium: TextStyle(fontSize: 24.0),
    displaySmall: TextStyle(fontSize: 16.0),
    titleSmall: TextStyle(fontSize: 16.0, color: Colors.white),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
    secondary: Colors.redAccent,
  ),
);
