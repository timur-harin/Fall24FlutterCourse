import 'package:flutter/material.dart';

final ThemeData hotTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.red,
  scaffoldBackgroundColor: const Color(0xFFE0E5EC),
  textTheme: TextTheme(
    headlineMedium: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.red.shade900),
    headlineSmall: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.red.shade700),
    bodyMedium: TextStyle(fontSize: 16.0, color: Colors.red.shade800),
    bodySmall: TextStyle(fontSize: 14.0, color: Colors.red.shade600),
  ),
);