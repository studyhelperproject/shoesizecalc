import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drawing_app/shape.dart';
import 'package:drawing_app/shape_painter.dart';

void main() {
  group('ShapePainter', () {
    test('shouldRepaint returns true when shapes list is different', () {
      final painter = ShapePainter(shapes: [Shape(rect: Rect.fromLTWH(0, 0, 10, 10), color: Colors.red)]);
      final oldDelegate = ShapePainter(shapes: [Shape(rect: Rect.fromLTWH(10, 10, 20, 20), color: Colors.blue)]);
      expect(painter.shouldRepaint(oldDelegate), isTrue);
    });

    test('shouldRepaint returns false when shapes list is the same', () {
      final shapes = [Shape(rect: Rect.fromLTWH(0, 0, 10, 10), color: Colors.red)];
      final painter = ShapePainter(shapes: shapes);
      final oldDelegate = ShapePainter(shapes: shapes);
      expect(painter.shouldRepaint(oldDelegate), isFalse);
    });
  });
}