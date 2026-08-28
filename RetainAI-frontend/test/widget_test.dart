import 'package:flutter_test/flutter_test.dart';
import 'package:retainai/main.dart';

void main() {
  testWidgets('App renders RetainAI title test', (WidgetTester tester) async {
    await tester.pumpWidget(const RetainAIApp());
    expect(find.text('RETAIN'), findsWidgets);
  });
}
