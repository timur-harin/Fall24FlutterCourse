import 'package:fall_24_flutter_course/templates/lab7/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter',
        (tester) async {
      await tester.pumpWidget(MyApp());

      expect(find.text('0'), findsOneWidget);

      final fab = find.byKey(ValueKey('increment_btn'));

      await tester.tap(fab);

      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);
    });
  });
}
