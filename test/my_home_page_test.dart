import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fall_24_flutter_course/templates/lab8/main.dart'; 

void main() {
  testWidgets('MyHomePage displays "Hello World!"', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: MyHomePage(),
        ),
      ),
    );

    // Verify that our text is present.
    expect(find.text('Hello World!'), findsOneWidget);
  });
}