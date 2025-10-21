import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

/// Represents a shape to be drawn on the canvas.
class Shape extends Equatable {
  /// A unique identifier for the shape.
  final String id;
  /// The points that define the vertices of the shape.
  final List<Offset> points;
  /// The rectangle that defines the shape's position and size.
  Rect get rect => Rect.fromPoints(points[0], points[2]);
  /// The color of the shape.
  final Color color;
  /// The scale of the shape.
  final double scale;
  /// The rotation of the shape in radians.
  final double rotation;
  /// Whether the shape is currently selected.
  final bool isSelected;

  Shape({
    String? id,
    required this.points,
    required this.color,
    this.scale = 1.0,
    this.rotation = 0.0,
    this.isSelected = false,
  }) : id = id ?? const Uuid().v4();

  @override
  List<Object?> get props => [id, points, color, scale, rotation, isSelected];

  /// Creates a copy of this Shape but with the given fields replaced with the new values.
  Shape copyWith({
    List<Offset>? points,
    Color? color,
    double? scale,
    double? rotation,
    bool? isSelected,
  }) {
    return Shape(
      id: id,
      points: points != null ? List.of(points) : this.points,
      color: color ?? this.color,
      scale: scale ?? this.scale,
      rotation: rotation ?? this.rotation,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}