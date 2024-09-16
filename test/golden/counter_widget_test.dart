import 'package:fall_24_flutter_course/templates/lab7/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CounterWidget Golden Test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CounterPage(),
      ),
    );

    await expectLater(
      find.byType(CounterPage),
      matchesGoldenFile('goldens/counter_widget_0.png'),
    );

    await tester.tap(find.byKey(const ValueKey('increment_button')));
    await tester.pump();

    await expectLater(
      find.byType(CounterPage),
      matchesGoldenFile('goldens/counter_widget_1.png'),
    );
  });
}

