import 'package:flutter/material.dart';

class AppTypography {
  final AppHTypo h = AppHTypo();

  final TextStyle body = const TextStyle(
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    fontSize: 16,
    letterSpacing: 0,
  );

  final TextStyle regular = const TextStyle(
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    fontSize: 14,
    letterSpacing: 0.4,
  );

  final TextStyle caption = const TextStyle(
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    fontSize: 12,
    letterSpacing: 0.4,
  );

  final TextStyle captionSm = const TextStyle(
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    fontSize: 10,
    letterSpacing: 0,
  );
}

class AppHTypo {
  final h1 = const TextStyle(
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    fontSize: 32,
    letterSpacing: 0,
  );

  final h2 = const TextStyle(
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    fontSize: 24,
    letterSpacing: 0,
  );

  final h3 = const TextStyle(
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    fontSize: 18,
    letterSpacing: 0,
  );
}