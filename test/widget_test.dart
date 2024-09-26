import 'package:fall_24_flutter_course/templates/lab8/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _title = "test";

void main() {
  testWidgets('MyHomePage has a title', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MyHomePage(title: _title)));
    final titleFinder = find.text(_title);
    expect(titleFinder, findsOneWidget);
  });
}