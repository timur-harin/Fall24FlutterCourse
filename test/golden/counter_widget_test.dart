import 'package:fall_24_flutter_course/templates/lab7/golden.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Generate goldens with
// flutter test --update-goldens test/golden/counter_widget_test.dart
void main() {
  testWidgets('CounterWidget Golden Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: const CounterWidget(),
        ),
      ),
    );

    await expectLater(
      find.byType(CounterWidget),
      matchesGoldenFile('goldens/counter_widget_0.png'),
    );

    await tester.tap(find.byType(ElevatedButton));
    
    await tester.pump();

    await expectLater(
      find.byType(CounterWidget),
      matchesGoldenFile('goldens/counter_widget_1.png'),
    );
  });
}

// After updating the golden files, check that they match with
// flutter test test/golden/counter_widget_test.dart
