import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'di/app_module.dart';

void main() {
  registerAppModule();
  runApp(const ProviderScope(child: ContrastShowerApp()));
}
