import 'package:flutter/material.dart';

final ThemeData coldTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: const Color(0xFFE0E5EC),
  textTheme: TextTheme(
    headlineMedium: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
    headlineSmall: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.blue.shade700),
    bodyMedium: TextStyle(fontSize: 16.0, color: Colors.blue.shade800),
    bodySmall: TextStyle(fontSize: 14.0, color: Colors.blue.shade600),
  ),
);