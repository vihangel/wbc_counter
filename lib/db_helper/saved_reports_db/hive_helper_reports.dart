import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:wbc_counter/home/mixin/provider_cells.dart';
import 'package:wbc_counter/models/saved_report_model.dart';

class HiveHelper {
  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(SaveReportModelAdapter());
    Hive.registerAdapter(TotalCellsBloodAdapter());
  }

  static Future<void> openBox() async {
    await Hive.openBox<SaveReportModel>('reports');
  }

  static Future<void> addReport(SaveReportModel report) async {
    final box = await Hive.openBox<SaveReportModel>('reports');

    const uuid = Uuid();
    bool existingReport =
        box.toMap().values.any((r) => r.id == report.id && report.id != null);
    existingReport
        ? await updateReport(report)
        : await box.add(report.copyWith(id: uuid.v4()));
  }

  static Future<List<SaveReportModel>> getReports() async {
    final box = await Hive.openBox<SaveReportModel>('reports');
    return box.values.toList();
  }

  static Future<void> updateReport(SaveReportModel updatedReport) async {
    final box = await Hive.openBox<SaveReportModel>('reports');
    final existingReport = box
        .toMap()
        .values
        .firstWhere((report) => report.id == updatedReport.id);

    await box.put(existingReport.key, updatedReport);
  }

  static Future<void> deleteReport(String id) async {
    final box = await Hive.openBox<SaveReportModel>('reports');
    final existingReport =
        box.toMap().values.firstWhere((report) => report.id == id);
    await box.delete(existingReport.key);
  }

  static Future<void> deleteAllReports() async {
    final box = await Hive.deleteFromDisk();
  }
}
