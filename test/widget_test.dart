import 'package:fall_24_flutter_course/templates/lab7/widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyWidget has a title', (WidgetTester tester) async {
    await tester.pumpWidget(const MyWidget(title: 'Title'));
   
    final Finder titleFinder = find.text('Title');

    expect(titleFinder, findsOneWidget);
  });
}
