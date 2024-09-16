import 'package:fall_24_flutter_course/templates/lab7/widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyWidget has a title', (WidgetTester tester) async {
    const title = 'Hello, Flutter!';
    await tester.pumpWidget(MyWidget(title: title));

    final titleFinder = find.text(title);
    
    expect(titleFinder, findsOneWidget);
  });
}
