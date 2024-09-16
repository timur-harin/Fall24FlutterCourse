import 'package:fall_24_flutter_course/templates/lab7/widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyWidget has a title', (WidgetTester tester) async {
    const title = 'This is test title';
    // TODO add pumpWidget with title
    await tester.pumpWidget(MyWidget(title: title));

    // TODO add titleFinder with find.text
    final titleFinder = find.text(title);

    // TODO add expect with findsOneWidget
    expect(titleFinder, findsOneWidget);
  });
}
