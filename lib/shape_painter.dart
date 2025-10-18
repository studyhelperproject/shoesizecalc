import 'package:flutter/material.dart';
import './shape.dart';

class ShapePainter extends CustomPainter {
  final List<Shape> shapes;

  ShapePainter({required this.shapes});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final shape in shapes) {
      paint.color = shape.color;
      canvas.drawRect(shape.rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ShapePainter oldDelegate) {
    return oldDelegate.shapes != shapes;
  }
}