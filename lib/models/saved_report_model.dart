import 'package:hive/hive.dart';
import 'package:wbc_counter/pages/home/model/report_image_model.dart';
import 'package:wbc_counter/pages/home/model/total_cells_blood_model.dart';

part 'saved_report_model.g.dart';

@HiveType(typeId: 0)
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
  final TotalCellsBlood? bloodCells;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  final String? id;

  @HiveField(7)
  String? observation;

  @HiveField(8)
  final List<ReportImageModel>? findings;

  SaveReportModel({
    this.name,
    this.type,
    this.referenceValues,
    this.age,
    required this.bloodCells,
    this.observation,
    this.id,
    this.findings,
  }) : createdAt = DateTime.now();

  SaveReportModel copyWith({
    String? name,
    String? type,
    String? referenceValues,
    int? age,
    TotalCellsBlood? bloodCells,
    String? observation,
    String? id,
    List<ReportImageModel>? findings,
  }) {
    return SaveReportModel(
      name: name ?? this.name,
      type: type ?? this.type,
      referenceValues: referenceValues ?? this.referenceValues,
      age: age ?? this.age,
      bloodCells: bloodCells ?? this.bloodCells,
      observation: observation ?? this.observation,
      id: id ?? this.id,
      findings: findings ?? this.findings,
    );
  }
}
