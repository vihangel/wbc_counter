import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wbc_counter/models/saved_report_model.dart';
import 'package:wbc_counter/report/report_page.dart';

class LocalReportPage extends StatefulWidget {
  const LocalReportPage({super.key});

  @override
  LocalReportPageState createState() => LocalReportPageState();
}

class LocalReportPageState extends State<LocalReportPage> {
  late Box<SaveReportModel> _reportsBox;
  List<SaveReportModel> _reports = [];

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  Future<void> _loadReports() async {
    _reportsBox = await Hive.openBox<SaveReportModel>('reports');
    _reports = _reportsBox.values.toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salvos'),
      ),
      body: _buildReportList(),
    );
  }

  Widget _buildReportList() {
    if (_reports.isEmpty) {
      return const Center(
        child: Text('Ainda não há relatórios salvos'),
      );
    } else {
      return ListView.builder(
        itemCount: _reports.length,
        itemBuilder: (context, index) {
          final report = _reports[index];
          return GestureDetector(
            onTap: () {
              _openReportDetails(report);
            },
            child: Card(
              elevation: 0,
              surfaceTintColor: Colors.white,
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      ///total cells
                      report.bloodCells
                          .map((key, value) => MapEntry(key, value))
                          .values
                          .reduce((a, b) => a + b)
                          .toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                title: Text(report.name ?? ''),
                subtitle: Text('Idade: ${report.age}'),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
        },
      );
    }
  }

  void _openReportDetails(SaveReportModel report) {
    // Navigate to the report details page, passing the report data as arguments
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ReportPage(
          report: report,
          isReadOnly: true,
        ),
      ),
    );
  }
}
