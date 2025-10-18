import 'package:flutter/material.dart';
import './shape.dart';
import './shape_painter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drawing App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DrawingCanvas(),
    );
  }
}

class DrawingCanvas extends StatefulWidget {
  const DrawingCanvas({super.key});

  @override
  State<DrawingCanvas> createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<DrawingCanvas> {
  final List<Shape> _shapes = [];
  Offset? _startPoint;

  void _onPanStart(DragStartDetails details) {
    _startPoint = details.localPosition;
    final newShape = Shape(
      rect: Rect.fromPoints(_startPoint!, _startPoint!),
      color: Colors.blue,
    );
    setState(() {
      _shapes.add(newShape);
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_startPoint == null) return;
    setState(() {
      final lastShapeIndex = _shapes.length - 1;
      _shapes[lastShapeIndex] = Shape(
        rect: Rect.fromPoints(_startPoint!, details.localPosition),
        color: _shapes[lastShapeIndex].color,
      );
    });
  }

  void _onPanEnd(DragEndDetails details) {
    _startPoint = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawing Canvas'),
      ),
      body: GestureDetector(
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        child: CustomPaint(
          key: const Key('drawing_canvas'),
          painter: ShapePainter(shapes: _shapes),
          child: Container(),
        ),
      ),
    );
  }
}