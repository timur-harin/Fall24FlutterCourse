import 'package:fall_24_flutter_course/templates/lab7/widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyWidget has a title', (WidgetTester tester) async {
    // TODO add pumpWidget with title
    await tester.pumpWidget(MyWidget(title: 'Test Title'));
   
    // TODO add titleFinder with find.text
    final titleFinder = find.text('Test Title');

    // TODO add expect with findsOneWidget
    expect(titleFinder, findsOneWidget);
  });
}

