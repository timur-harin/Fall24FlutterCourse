import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fall_24_flutter_course/templates/lab8/main.dart';

void main() {
  testWidgets('MyHomePage has a text "Hello World!"', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: MyHomePage(),
        ),
      ),
    );

    expect(find.text('Hello World!'), findsOneWidget);
  });
}

