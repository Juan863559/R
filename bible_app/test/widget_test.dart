import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bible_app/main.dart';

void main() {
  testWidgets('Bible app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BibleApp());

    // Verify that the title of the first book is shown.
    expect(find.text('Génesis'), findsOneWidget);

    // Open the drawer using the leading icon.
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Verify that the drawer shows "ANTIGUO TESTAMENTO".
    expect(find.text('ANTIGUO TESTAMENTO'), findsOneWidget);

    // Check that we can see books in the drawer
    expect(find.text('Éxodo'), findsOneWidget);
  });
}
