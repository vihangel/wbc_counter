import 'dart:io';

import 'package:hive/hive.dart';

part 'report_image_model.g.dart';

@HiveType(typeId: 3)
class ReportImageModel {
  @HiveField(0)
  final File image;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String coordinates;

  ReportImageModel(
      {required this.image, this.name = '', this.coordinates = ''});

  ReportImageModel copyWith({File? image, String? name, String? coordinates}) {
    return ReportImageModel(
      image: image ?? this.image,
      name: name ?? this.name,
      coordinates: coordinates ?? this.coordinates,
    );
  }
}
