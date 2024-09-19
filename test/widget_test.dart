import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fall_24_flutter_course/templates/lab7/widget.dart';

void main() {
  testWidgets('MyHomePage has a Hello World text', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: MyHomePage(),
        ),
      ),
    );

    final helloWorldTextFinder = find.text('Hello World!');

    expect(helloWorldTextFinder, findsOneWidget);
  });
}
