import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:drawing_app/main.dart' as app;
import 'package:drawing_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Drawing App Integration Tests', () {
    testWidgets('Complete user flow test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // 1. Draw a shape
      final gesture = await tester.startGesture(const Offset(100, 150));
      await gesture.moveTo(const Offset(200, 250));
      await gesture.up();
      await tester.pumpAndSettle();

      // 2. Tap to display coordinates
      await tester.tapAt(const Offset(300, 300));
      await tester.pumpAndSettle();

      // 3. Select the shape
      await tester.tapAt(const Offset(150, 200));
      await tester.pumpAndSettle();

      // 4. Move, scale, and rotate the shape
      final moveGesture = await tester.startGesture(const Offset(150, 200));
      await moveGesture.moveTo(const Offset(250, 300));
      await moveGesture.up();
      await tester.pumpAndSettle();

      // No explicit assertions, just checking for crashes.
      // In a real app, you would add more robust checks.
      expect(find.byType(DrawingCanvas), findsOneWidget);
    });
  });
}