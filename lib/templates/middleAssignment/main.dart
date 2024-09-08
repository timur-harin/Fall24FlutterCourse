import 'package:fall_24_flutter_course/templates/middleAssignment/app.dart';
import 'package:fall_24_flutter_course/templates/middleAssignment/di/app_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  registerAppModule();
  runApp(const ProviderScope(child: ContrastShowerApp()));
}
