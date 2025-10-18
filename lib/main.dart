import 'package:flutter/material.dart';

class Circle {
  final Offset center;
  final double radius;

  Circle({required this.center, required this.radius});
}

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
  final List<Circle> _circles = [];

  void _addCircle(Offset position) {
    setState(() {
      _circles.add(Circle(center: position, radius: 25));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawing Canvas'),
      ),
      body: GestureDetector(
        onTapUp: (details) => _addCircle(details.localPosition),
        child: CustomPaint(
          painter: ShapePainter(circles: _circles),
          child: Container(),
        ),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  final List<Circle> circles;

  ShapePainter({required this.circles});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    for (final circle in circles) {
      canvas.drawCircle(circle.center, circle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ShapePainter oldDelegate) {
    return oldDelegate.circles != circles;
  }
}