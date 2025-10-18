import 'package:flutter/material.dart';
import 'shape.dart';

class ShapePainter extends CustomPainter {
  final List<Shape> shapes;

  ShapePainter({required this.shapes});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (final shape in shapes) {
      for (int i = 0; i < shape.points.length - 1; i++) {
        canvas.drawLine(shape.points[i], shape.points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant ShapePainter oldDelegate) {
    return oldDelegate.shapes != shapes;
  }
}