import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drawing_app/shape.dart';

void main() {
  group('Shape', () {
    test('Shape should be created with default values', () {
      final shape = Shape(
        points: const [Offset(0, 0), Offset(100, 0), Offset(100, 100), Offset(0, 100)],
        color: Colors.blue,
      );
      expect(shape.points, const [Offset(0, 0), Offset(100, 0), Offset(100, 100), Offset(0, 100)]);
      expect(shape.color, Colors.blue);
      expect(shape.scale, 1.0);
      expect(shape.rotation, 0.0);
      expect(shape.isSelected, false);
      expect(shape.id, isNotNull);
    });

    test('copyWith should create a new instance with updated values', () {
      final shape = Shape(
        points: const [Offset(0, 0), Offset(100, 0), Offset(100, 100), Offset(0, 100)],
        color: Colors.blue,
      );
      final newShape = shape.copyWith(
        points: const [Offset(10, 10), Offset(60, 10), Offset(60, 60), Offset(10, 60)],
        color: Colors.red,
        scale: 1.5,
        rotation: 0.5,
        isSelected: true,
      );
      expect(newShape.points, const [Offset(10, 10), Offset(60, 10), Offset(60, 60), Offset(10, 60)]);
      expect(newShape.color, Colors.red);
      expect(newShape.scale, 1.5);
      expect(newShape.rotation, 0.5);
      expect(newShape.isSelected, true);
      expect(newShape.id, shape.id);
    });
  });
}