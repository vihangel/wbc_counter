import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:share/share.dart';
import 'package:wbc_counter/db_helper/saved_reports_db/hive_helper_reports.dart';
import 'package:wbc_counter/home/home_page.dart';
import 'package:wbc_counter/local_reports/local_reports_page.dart';
import 'package:wbc_counter/models/saved_report_model.dart';

class ReportPage extends StatefulWidget {
  final SaveReportModel report;
  final bool isReadOnly;

  const ReportPage({Key? key, required this.report, this.isReadOnly = false})
      : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _observationController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.report.name);
    _ageController = TextEditingController(text: '${widget.report.age ?? 0}');
    _observationController =
        TextEditingController(text: widget.report.observation);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _observationController.dispose();
    super.dispose();
  }

  void _saveReport() async {
    final String name = _nameController.text;
    final int age = int.tryParse(_ageController.text) ?? 0;
    final String observation = _observationController.text;

    // Create a SaveReportModel instance with patient data and report data
    final SaveReportModel report = SaveReportModel(
      name: name,
      type: 'Type', // Replace with actual type
      referenceValues:
          'Reference Values', // Replace with actual reference values
      age: age,
      bloodCells: widget.report.bloodCells,
      observation: observation,
    );

    HiveHelper.addReport(report);

    // Display a confirmation dialog
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Relatório salvo'),
          content: const Text('Algum texto concordando aqui'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text('Fechar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => const LocalReportPage()),
                );
              },
              child: const Text('Ver relatórios'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the total quantity
    int totalQuantity = widget.report.bloodCells.values.reduce((a, b) => a + b);

    // Calculate the percentages
    Map<String, double> wbcPercentages = {};
    widget.report.bloodCells.forEach((key, value) {
      double percentage = (value / totalQuantity) * 100;
      wbcPercentages[key] = percentage;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatório'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: Text(
                        'Nome do paciente',
                      ),
                    ),
                    TextFormField(
                      controller: _nameController,
                      readOnly: widget.isReadOnly,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: Text(
                        'Idade do paciente',
                      ),
                    ),
                    TextFormField(
                      controller: _ageController,
                      readOnly: widget.isReadOnly,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),

                Text(
                  'Total: $totalQuantity',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 16.0),
                // Display the chart
                PieChart(
                  dataMap: wbcPercentages,
                  colorList: const [
                    Colors.deepPurple,
                    Color.fromARGB(255, 58, 137, 183),
                    Color.fromARGB(255, 58, 183, 106),
                    Color.fromARGB(255, 150, 183, 58),
                    Color.fromARGB(255, 183, 133, 58),
                    Color.fromARGB(255, 183, 58, 58),
                    Color.fromARGB(255, 183, 58, 131),
                    Color.fromARGB(255, 143, 58, 183),
                  ],
                ),
                const SizedBox(height: 16.0),
                // Display the report table
                DataTable(
                  columns: const [
                    DataColumn(label: Text('Tipos')),
                    DataColumn(label: Text('Quantidade')),
                    DataColumn(label: Text('%')),
                  ],
                  rows: widget.report.bloodCells.entries.map((entry) {
                    return DataRow(
                      cells: [
                        DataCell(Text(entry.key)),
                        DataCell(Text(entry.value.toString())),
                        DataCell(Text(
                            '${wbcPercentages[entry.key]!.toStringAsFixed(2)}%')),
                      ],
                    );
                  }).toList(),
                ),
                const SizedBox(height: 32.0),

                TextFormField(
                  controller: _observationController,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(labelText: 'Observação'),
                  textInputAction: TextInputAction.newline,
                  maxLines: null,
                  readOnly: widget.isReadOnly,
                ),
                const SizedBox(height: 32.0),
                if (!widget.isReadOnly) ...[
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveReport,
                      child: const Text(
                        'Salvar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],

                TextButton(
                  onPressed: () {
                    String reportText = 'Total: $totalQuantity\n\n';
                    for (var entry in widget.report.bloodCells.entries) {
                      reportText +=
                          '${entry.key}: ${entry.value} (${wbcPercentages[entry.key]!.toStringAsFixed(2)}%)\n';
                    }
                    Share.share(reportText);
                  },
                  child: const Text(
                    'Compartilhar relatório',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
