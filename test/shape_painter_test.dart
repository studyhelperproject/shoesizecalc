import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drawing_app/shape.dart';
import 'package:drawing_app/shape_painter.dart';

void main() {
  group('ShapePainter', () {
    test('shouldRepaint returns true when shapes list is different', () {
      final painter = ShapePainter(shapes: [Shape(points: [Offset(0,0), Offset(10,0), Offset(10,10), Offset(0,10)], color: Colors.red)]);
      final oldDelegate = ShapePainter(shapes: [Shape(points: [Offset(10,10), Offset(20,10), Offset(20,20), Offset(10,20)], color: Colors.blue)]);
      expect(painter.shouldRepaint(oldDelegate), isTrue);
    });

    test('shouldRepaint returns false when shapes list is the same', () {
      final shapes = [Shape(points: [Offset(0,0), Offset(10,0), Offset(10,10), Offset(0,10)], color: Colors.red)];
      final painter = ShapePainter(shapes: shapes);
      final oldDelegate = ShapePainter(shapes: shapes);
      expect(painter.shouldRepaint(oldDelegate), isFalse);
    });
  });
}