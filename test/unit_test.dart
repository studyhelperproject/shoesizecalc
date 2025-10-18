import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// A dummy Shape class for demonstration purposes.
class Shape {
  Offset center;
  double radius;

  Shape({required this.center, this.radius = 50.0});

  void move(Offset offset) {
    center = center + offset;
  }
}

void main() {
  group('Shape', () {
    test('Shape should be created with a center point', () {
      final shape = Shape(center: const Offset(100, 100));
      expect(shape.center, const Offset(100, 100));
      expect(shape.radius, 50.0);
    });

    test('Moving a shape updates its center', () {
      final shape = Shape(center: const Offset(100, 100));
      shape.move(const Offset(50, -50));
      expect(shape.center, const Offset(150, 50));
    });
  });
}