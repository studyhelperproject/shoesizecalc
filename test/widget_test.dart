// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:drawing_app/main.dart';
import 'package:drawing_app/shape_painter.dart';

void main() {
  testWidgets('Drawing a shape on tap test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify that initially there are no shapes drawn.
    ShapePainter painter = tester.widget<CustomPaint>(find.byKey(const Key('drawing_canvas'))).painter as ShapePainter;
    expect(painter.shapes.isEmpty, isTrue);

    // Tap the screen to draw a shape.
    await tester.tapAt(const Offset(100, 150));
    await tester.pump();

    // Verify that a shape has been added.
    painter = tester.widget<CustomPaint>(find.byKey(const Key('drawing_canvas'))).painter as ShapePainter;
    expect(painter.shapes.length, 1);
  });
}