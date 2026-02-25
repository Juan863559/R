import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bible_app/main.dart';

void main() {
  testWidgets('Bible app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BibleApp());

    // Wait for data loading
    for (int i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    // Check if there's an error message
    final errorFinder = find.textContaining('No se pudo cargar');
    if (tester.any(errorFinder)) {
      final Text errorText = tester.widget(errorFinder);
      print('Load failed with message: ${errorText.data}');
    }

    // Verify that the title of the first book is shown.
    expect(find.text('Génesis'), findsOneWidget);
  });
}
