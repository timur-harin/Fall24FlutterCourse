import 'package:fall_24_flutter_course/templates/lab7/golden.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// TODO generate goldens with
// flutter test --update-goldens test/golden/counter_widget_test.dart
void main() {
  testWidgets('CounterWidget Golden Test', (WidgetTester tester) async {
    // TODO build our app with MaterialApp, Scaffold, and CounterWidget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: const CounterWidget(),
        )
      ),
    );
    
    // TODO add expectLater with matchesGoldenFile with find.byType(CounterWidget) and file from 'goldens/counter_widget_0.png'
    expectLater(find.byType(CounterWidget), matchesGoldenFile('goldens/counter_widget_0.png'));

    // TODO add tap on the button by find.byType(ElevatedButton)
    // TODO add pump
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // TODO add expectLater with matchesGoldenFile with find.byType(CounterWidget) and file from 'goldens/counter_widget_1.png'
    expectLater(find.byType(CounterWidget), matchesGoldenFile('goldens/counter_widget_1.png'));
  });
}

// TODO after update golden -> check that it works and matched
// flutter test test/golden/counter_widget_test.dart
