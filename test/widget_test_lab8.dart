import 'package:fall_24_flutter_course/templates/lab8/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Main page displays Hello World text', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MaterialApp()));
    expect(find.text('Hello World!'), findsOneWidget);
  });
} 


