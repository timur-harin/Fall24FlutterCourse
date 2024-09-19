import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:your_project/main.dart';

void main() {
  testWidgets('Test if Hello World is displayed', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: MyHomePage())),
    );

    expect(find.text('Hello World!'), findsOneWidget);
  });
}
