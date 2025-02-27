import 'dart:io';

import 'package:hive/hive.dart';

part 'report_image_model.g.dart';

@HiveType(typeId: 3)
class ReportImageModel {
  @HiveField(0)
  final String imagePath;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String coordinates;

  ReportImageModel(
      {required this.imagePath, this.name = '', this.coordinates = ''});

  ReportImageModel copyWith(
      {String? imagePath, String? name, String? coordinates}) {
    return ReportImageModel(
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  File get imageFile => File(imagePath);
}
