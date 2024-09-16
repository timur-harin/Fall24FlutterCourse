import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:fall_24_flutter_course/templates/lab7/counter.dart' as app;


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter',
        (WidgetTester tester) async {
      // TODO add pumpWidget with MyApp
      app.main();
      await tester.pumpAndSettle();

      expect(find.text('0'), findsOneWidget);

      final fab = find.byKey(const ValueKey('inctement_fab'));

      await tester.tap(fab);

      await tester.pumpAndSettle();

      expect(find.text('0'), findsOneWidget);
    });
  });
}
