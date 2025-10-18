import 'package:flutter/material.dart';
import 'shape.dart';
import 'shape_painter.dart';

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
  List<Shape> shapes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawing Canvas'),
      ),
      body: GestureDetector(
        onPanStart: (details) {
          setState(() {
            shapes.add(Shape(points: [details.localPosition]));
          });
        },
        onPanUpdate: (details) {
          setState(() {
            shapes.last.points.add(details.localPosition);
          });
        },
        child: CustomPaint(
          painter: ShapePainter(shapes: shapes),
          child: Container(),
        ),
      ),
    );
  }
}