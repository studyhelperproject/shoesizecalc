import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:drawing_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Drawing App Integration Tests', () {
    testWidgets('Tap on the screen to draw a circle and verify it appears', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Initially, no circles should be on the canvas.
      final dynamic painterBefore = tester.widget<CustomPaint>(find.byType(CustomPaint)).painter;
      expect(painterBefore.circles.isEmpty, isTrue);

      // Tap the center of the screen to draw a circle.
      await tester.tap(find.byType(CustomPaint));
      await tester.pumpAndSettle();

      // Verify that a circle has been drawn.
      final dynamic painterAfter = tester.widget<CustomPaint>(find.byType(CustomPaint)).painter;
      expect(painterAfter.circles.length, 1);
    });
  });
}