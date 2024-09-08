import 'package:flutter/material.dart';

const _Verdigris = Color(0xFF5FBFB1);
const _Vanila = Color(0xFFF2DFA8);
const _GhostWhite = Color(0xFFF4F4F8);
const _EerieBlack = Color(0xFF1A1D07);
const _Moonstone = Color(0xFF2AB7CA);
const _Tomato = Color(0xFFFE4A49);

class AppColors {
  final AppBackgroundColors background = AppBackgroundColors();
  final AppTextColors text = AppTextColors();
  final AppButtonColors button = AppButtonColors();
  final Color error = _Tomato;
}

class AppBackgroundColors {
  final Color primary;
  final Color item;
  final Color card;

  AppBackgroundColors({
    this.primary = _Verdigris,
    this.item = _GhostWhite,
    this.card = _Moonstone,
  });
}

class AppTextColors {
  final Color topBar;
  final Color onBackground;
  final Color onItem;
  final Color onCard;
  final Color onButton;

  AppTextColors({
    this.topBar = _Vanila,
    this.onBackground = _GhostWhite,
    this.onItem = _EerieBlack,
    this.onCard = _GhostWhite,
    this.onButton = _Vanila,
  });
}

class AppButtonColors {
  final Color primary;

  AppButtonColors({
    this.primary = _Vanila,
  });
}
