import 'package:hive_flutter/hive_flutter.dart';
import 'package:wbc_counter/models/saved_report_model.dart';

class HiveHelper {
  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(SaveReportModelAdapter());
  }

  static Future<void> openBox() async {
    await Hive.openBox<SaveReportModel>('reports');
  }

  static Future<void> addReport(SaveReportModel report) async {
    final box = await Hive.openBox<SaveReportModel>('reports');

    await box.add(report);
  }

  static Future<List<SaveReportModel>> getReports() async {
    final box = await Hive.openBox<SaveReportModel>('reports');
    return box.values.toList();
  }

  static Future<void> updateReport(SaveReportModel updatedReport) async {
    final box = await Hive.openBox<SaveReportModel>('reports');
    final existingReport = box.get(updatedReport.id);
    if (existingReport != null) {
      await box.put(updatedReport.id, updatedReport);
    }
  }

  static Future<void> deleteReport(String id) async {
    final box = await Hive.openBox<SaveReportModel>('reports');
    await box.delete(id);
  }
}
