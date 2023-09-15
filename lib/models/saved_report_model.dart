import 'package:hive/hive.dart';

part 'saved_report_model.g.dart';

@HiveType(typeId: 0) // Assign a unique typeId for your model
class SaveReportModel extends HiveObject {
  @HiveField(0)
  final String? name;

  @HiveField(1)
  final String? type;

  @HiveField(2)
  final String? referenceValues;

  @HiveField(3)
  final int? age;

  @HiveField(4)
  final Map<String, int> bloodCells;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  final String? id;

  @HiveField(7)
  String? observation;

  SaveReportModel({
    this.name,
    this.type,
    this.referenceValues,
    this.age,
    required this.bloodCells,
    this.observation,
    this.id,
  }) : createdAt = DateTime.now();
}
