import 'package:fall_24_flutter_course/templates/lab7/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter',
        (tester) async {
      // TODO add pumpWidget with MyApp
      await tester.pumpWidget(const MyApp());

      // TODO verify the counter starts at 0, so find the text '0' 
      expect(find.text('0'), findsOneWidget);

      // TODO finds the floating action button by key in counter.dart
      final Finder fab = find.byKey(const ValueKey('Increment fab'));

      // TODO emulate a tap on the floating action button by tester.tap(fab)
      await tester.tap(fab);

      // TODO trigger a frame by calling tester.pumpAndSettle
      await tester.pumpAndSettle();

      // TODO verify the counter increments by 1, so find the text '1'
      expect(find.text('1'), findsOneWidget);
    });
  });
}
