
import 'package:flutter_test/flutter_test.dart';
import 'package:tashus_maditationapp/main.dart';

void main() {
  testWidgets('App starts successfully', (WidgetTester tester) async {
    // Build the TasHu app.
    await tester.pumpWidget(const TasHuApp());

    // Check that the app starts and displays the Home screen.
    expect(find.text('TasHu'), findsNothing);
    expect(find.byType(TasHuApp), findsOneWidget);
  });
}
