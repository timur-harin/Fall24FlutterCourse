import 'package:fall_24_flutter_course/templates/lab7/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyWidget has a title and random widgets', (WidgetTester tester) async {
    await tester.pumpWidget(MyWidget(title: 'Test Title'));

    final titleFinder = find.text('Test Title');
    expect(titleFinder, findsOneWidget);

    final helloWorldFinder = find.text('Hello World');
    expect(helloWorldFinder, findsOneWidget);

    final sliderFinder = find.byType(Slider);
    expect(sliderFinder, findsOneWidget);

    final checkboxFinder = find.byType(Checkbox);
    expect(checkboxFinder, findsOneWidget);

    final buttonFinder = find.widgetWithText(ElevatedButton, 'Press Me');
    expect(buttonFinder, findsOneWidget);
  });
}
