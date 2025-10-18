// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:drawing_app/main.dart';

void main() {
  testWidgets('Drawing a circle on tap test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify that initially there are no circles drawn.
    final painter = tester.widget<CustomPaint>(find.byType(CustomPaint)).painter as ShapePainter;
    expect(painter.circles.isEmpty, isTrue);

    // Tap the screen to draw a circle.
    const tapPosition = Offset(100, 150);
    await tester.tapAt(tapPosition);
    await tester.pump();

    // Verify that a circle has been added.
    final updatedPainter = tester.widget<CustomPaint>(find.byType(CustomPaint)).painter as ShapePainter;
    expect(updatedPainter.circles.length, 1);
    expect(updatedPainter.circles.first.center, tapPosition);
  });
}