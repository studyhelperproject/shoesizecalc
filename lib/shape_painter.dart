import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import './shape.dart';

/// A custom painter that draws a list of shapes on a canvas.
class ShapePainter extends CustomPainter {
  /// The list of shapes to be drawn.
  final List<Shape> shapes;

  ShapePainter({required this.shapes});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Iterate through the shapes and draw each one.
    for (final shape in shapes) {
      final path = Path();
      path.addPolygon(shape.points, true);

      paint
        ..color = shape.color
        ..style = PaintingStyle.fill;
      canvas.drawPath(path, paint);

      if (shape.isSelected) {
        paint
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0;
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant ShapePainter oldDelegate) {
    // Always repaint for simplicity, to ensure updates are shown.
    return true;
  }
}