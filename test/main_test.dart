import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fall_24_flutter_course/templates/lab8/main.dart';

void main() {
  testWidgets('Main app loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MyHomePage());
    expect(find.text('Hello World!'), findsOneWidget);
  });
}
