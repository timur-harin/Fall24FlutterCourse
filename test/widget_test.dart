import 'package:fall_24_flutter_course/templates/lab7/widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyWidget has a title', (WidgetTester tester) async {
    // Pump the widget with a title
    await tester.pumpWidget(MyWidget(title: 'Test Title'));

    final titleFinder = find.text('Test Title');

    expect(titleFinder, findsOneWidget);
  });
}
