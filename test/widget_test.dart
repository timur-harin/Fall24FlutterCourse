import 'package:fall_24_flutter_course/templates/lab7/widget.dart';
import 'package:flutter_test/flutter_test.dart';

const _title = 'The title';

void main() {
  testWidgets('MyWidget has a title', (WidgetTester tester) async {
    await tester.pumpWidget(const MyWidget(title: _title));

    final titleFinder = find.text(_title);
    expect(titleFinder, findsOneWidget);
  });
}
