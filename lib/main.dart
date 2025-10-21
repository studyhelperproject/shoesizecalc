import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
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

/// A widget that provides a canvas for drawing shapes.
class DrawingCanvas extends StatefulWidget {
  const DrawingCanvas({super.key});

  @override
  State<DrawingCanvas> createState() => DrawingCanvasState();
}

class DrawingCanvasState extends State<DrawingCanvas> {
  /// List of shapes drawn on the canvas.
  final List<Shape> shapes = [];
  File? backgroundImage;
  Shape? _selectedShape;
  int? _draggedVertexIndex;
  Offset? _panStartOffset;
  Offset? _startPoint; // For drawing new shapes


  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        backgroundImage = File(pickedFile.path);
      });
    }
  }

  void onPanStart(DragStartDetails details) {
    final position = details.localPosition;
    Shape? tappedShape;
    int? tappedVertexIndex;

    for (final shape in shapes.reversed) {
      for (var i = 0; i < shape.points.length; i++) {
        if ((shape.points[i] - position).distance < 20.0) {
          tappedShape = shape;
          tappedVertexIndex = i;
          break;
        }
      }
      if (tappedShape != null) break;
    }

    setState(() {
      if (tappedShape != null) {
        _selectedShape = tappedShape;
        _draggedVertexIndex = tappedVertexIndex;
        _panStartOffset = position;
        _startPoint = null;
      } else {
        _startPoint = position;
        final newShape = Shape(
          points: [
            _startPoint!,
            _startPoint!,
            _startPoint!,
            _startPoint!,
          ],
          color: Colors.blue,
          isSelected: true,
        );
        shapes.add(newShape);
        _selectedShape = newShape;
      }
      for (var i = 0; i < shapes.length; i++) {
        shapes[i] = shapes[i].copyWith(isSelected: shapes[i].id == _selectedShape?.id);
      }
    });
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (_selectedShape == null) return;
    setState(() {
      final index = shapes.indexWhere((s) => s.id == _selectedShape!.id);
      if (index == -1) return;

      if (_startPoint != null) {
        // Drawing a new shape
        final newPoints = [
          _startPoint!,
          Offset(details.localPosition.dx, _startPoint!.dy),
          details.localPosition,
          Offset(_startPoint!.dy, details.localPosition.dx),
        ];
        shapes[index] = shapes[index].copyWith(points: newPoints);
      } else if (_draggedVertexIndex != null) {
        // Resizing an existing shape
        final newPoints = List<Offset>.from(shapes[index].points);
        newPoints[_draggedVertexIndex!] = details.localPosition;
        shapes[index] = shapes[index].copyWith(points: newPoints);
      } else if (_panStartOffset != null) {
        // Moving an existing shape
        final delta = details.localPosition - _panStartOffset!;
        final newPoints = shapes[index].points.map((p) => p + delta).toList();
        shapes[index] = shapes[index].copyWith(points: newPoints);
        _panStartOffset = details.localPosition;
      }
      _selectedShape = shapes[index];
    });
  }

  void onPanEnd(DragEndDetails details) {
    setState(() {
      if (_startPoint != null) {
        // Finalize the shape drawing
        final index = shapes.indexWhere((s) => s.id == _selectedShape!.id);
        if (index != -1) {
          // Deselect the shape after drawing is complete
          shapes[index] = shapes[index].copyWith(isSelected: false);
        }
      }
      _selectedShape = null;
      _draggedVertexIndex = null;
      _panStartOffset = null;
      _startPoint = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawing Canvas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: _pickImage,
          ),
        ],
      ),
      body: GestureDetector(
        onPanStart: onPanStart,
        onPanUpdate: onPanUpdate,
        onPanEnd: onPanEnd,
        child: CustomPaint(
          painter: ShapePainter(shapes: shapes),
          size: Size.infinite,
        ),
      ),
    );
  }
}