import 'package:equatable/equatable.dart';

class Prediction extends Equatable {
  final double x;
  final double y;
  final double width;
  final double height;
  final double confidence;
  final String className;
  final int classId;

  const Prediction({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.confidence,
    required this.className,
    required this.classId,
  });

  @override
  List<Object?> get props =>
      [x, y, width, height, confidence, className, classId];

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      x: json['x'],
      y: json['y'],
      width: json['width'],
      height: json['height'],
      confidence: json['confidence'],
      className: json['class'],
      classId: json['class_id'],
    );
  }
}
