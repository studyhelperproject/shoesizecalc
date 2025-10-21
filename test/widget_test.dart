import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:drawing_app/main.dart';
import 'package:drawing_app/shape.dart';

void main() {
  testWidgets('DrawingCanvas allows drawing and dragging shapes', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify that there are no shapes initially.
    final stateBefore = tester.state<DrawingCanvasState>(find.byType(DrawingCanvas));
    expect(stateBefore.shapes.length, 0);

    // Simulate a pan gesture to draw a new shape.
    await tester.drag(find.byType(GestureDetector), const Offset(100, 100));
    await tester.pump();

    // Verify that a shape has been drawn.
    final stateAfter = tester.state<DrawingCanvasState>(find.byType(DrawingCanvas));
    expect(stateAfter.shapes.length, 1);
    final initialShape = stateAfter.shapes.first;

    // Simulate dragging a vertex of the shape.
    final vertexToDrag = initialShape.points[0];
    final dragVector = const Offset(50, -50);
    await tester.dragFrom(vertexToDrag, dragVector);
    await tester.pump();

    // Verify that the vertex has moved.
    final stateAfterDrag = tester.state<DrawingCanvasState>(find.byType(DrawingCanvas));
    final finalShape = stateAfterDrag.shapes.first;
    expect(finalShape.points[0], vertexToDrag + dragVector);
  });
}