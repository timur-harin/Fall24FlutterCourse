import 'package:flutter/material.dart';

class AppTheme {
  // Light theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.blue,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: Colors.blue,
      inactiveTrackColor: Colors.grey,
      thumbColor: Colors.blue,
      overlayColor: Colors.blue.withAlpha(32),
    ),
  );

  // Dark theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.blueGrey,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: Colors.blue,
      inactiveTrackColor: Colors.grey,
      thumbColor: Colors.blue,
      overlayColor: Colors.blue.withAlpha(32),
    ),
  );
}
