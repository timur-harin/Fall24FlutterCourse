import 'package:fall_24_flutter_course/templates/lab7/widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyWidget has a title', (WidgetTester tester) async {
    const testTitle = 'Test Title';

    await tester.pumpWidget(MyWidget(title: testTitle));

    final titleFinder = find.text(testTitle);
    expect(titleFinder, findsOneWidget);
  });
}
