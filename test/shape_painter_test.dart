import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drawing_app/main.dart';

void main() {
  test('ShapePainter shouldRepaint returns false', () {
    final painter = ShapePainter();
    final oldDelegate = ShapePainter();
    expect(painter.shouldRepaint(oldDelegate), isFalse);
  });

  test('ShapePainter paint method runs without errors', () {
    final painter = ShapePainter();
    final canvas = FakeCanvas();
    const size = Size(100, 100);

    // Execute the paint method and expect no errors.
    expect(() => painter.paint(canvas, size), returnsNormally);
  });
}

class FakeCanvas implements Canvas {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}