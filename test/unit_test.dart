import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drawing_app/shape.dart';

void main() {
  group('Shape', () {
    test('Shape should be created with a rect and color', () {
      final shape = Shape(
        rect: const Rect.fromLTWH(0, 0, 100, 100),
        color: Colors.blue,
      );
      expect(shape.rect, const Rect.fromLTWH(0, 0, 100, 100));
      expect(shape.color, Colors.blue);
    });
  });
}