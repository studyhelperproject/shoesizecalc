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
  testWidgets('Canvas setup test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our canvas is set up correctly.
    final gestureDetectorFinder = find.byType(GestureDetector);
    expect(gestureDetectorFinder, findsOneWidget);

    final customPaintFinder = find.descendant(
      of: gestureDetectorFinder,
      matching: find.byType(CustomPaint),
    );
    expect(customPaintFinder, findsOneWidget);
  });

  testWidgets('Drawing test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final gestureDetectorFinder = find.byType(GestureDetector);
    expect(gestureDetectorFinder, findsOneWidget);

    await tester.drag(gestureDetectorFinder, const Offset(100, 100));
    await tester.pump();

    final customPaint = tester.widget<CustomPaint>(find.byType(CustomPaint));
    final shapePainter = customPaint.painter as ShapePainter;

    expect(shapePainter.shapes.isNotEmpty, isTrue);
    expect(shapePainter.shapes.last.points.length, 2); // start, update
  });
}