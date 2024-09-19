import 'package:fall_24_flutter_course/templates/lab7/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyHomePage displays "Hello World!"',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MyHomePage(),
      ),
    );

    final textFinder = find.text('Hello World!');
    expect(textFinder, findsOneWidget);
  });
}
