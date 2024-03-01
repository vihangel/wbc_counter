import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:share/share.dart';
import 'package:wbc_counter/bloc/cell%20count/cell_count_bloc.dart';
import 'package:wbc_counter/bloc/local_reports/local_reports_bloc.dart';
import 'package:wbc_counter/generated/l10n.dart';
import 'package:wbc_counter/local_reports/local_reports_page.dart';
import 'package:wbc_counter/models/saved_report_model.dart';
import 'package:wbc_counter/pages/home/home_page.dart';

class ReportPage extends StatefulWidget {
  final SaveReportModel report;
  final bool isReadOnly;

  const ReportPage({super.key, required this.report, this.isReadOnly = false});

  @override
  ReportPageState createState() => ReportPageState();
}

class ReportPageState extends State<ReportPage> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _observationController;
  bool isReadOnly = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.report.name);
    _ageController = TextEditingController(text: '${widget.report.age ?? 0}');
    _observationController =
        TextEditingController(text: widget.report.observation);
    isReadOnly = widget.isReadOnly;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _observationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the total quantity
    int totalQuantity = widget.report.bloodCells?.totalWbcCount ?? 0;

    // Calculate the percentages
    Map<String, double> wbcPercentages = {};
    widget.report.bloodCells?.allCells.forEach((key, value) {
      double percentage = (value / totalQuantity) * 100;
      wbcPercentages[key] = percentage;
    });

    return PopScope(
      onPopInvoked: (value) {
        context.read<LocalReportsBloc>().add(ListLocalReportEvent());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).report),
          actions: [
            if (isReadOnly)
              IconButton(
                onPressed: _editReport,
                icon: const Icon(Icons.edit),
              ),
          ],
        ),
        body: BlocConsumer<CellCountBloc, CellCountState>(
          listener: (context, state) {
            if (state is CellCountSavedState) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(S.of(context).reportSaved),
                    content: Text(S.of(context).msg_agreeing),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                              (route) => false);
                        },
                        child: Text(S.of(context).close),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const LocalReportPage()),
                          );
                        },
                        child: Text(S.of(context).seeReports),
                      ),
                    ],
                  );
                },
              );
            }
          },
          builder: (context, state) {
            if (state is CellCountLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Text(
                              S.of(context).patientName,
                            ),
                          ),
                          TextFormField(
                            controller: _nameController,
                            readOnly: isReadOnly,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Text(
                              S.of(context).patientAge,
                            ),
                          ),
                          TextFormField(
                            controller: _ageController,
                            readOnly: isReadOnly,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),

                      Text(
                        '${S.of(context).total}: $totalQuantity',
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
                        columns: [
                          DataColumn(label: Text(S.of(context).type)),
                          DataColumn(label: Text(S.of(context).quantity)),
                          const DataColumn(label: Text('%')),
                        ],
                        rows: widget.report.bloodCells!.allCells.entries
                            .map((entry) {
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
                        decoration: InputDecoration(
                            labelText: S.of(context).observation),
                        textInputAction: TextInputAction.newline,
                        maxLines: null,
                        readOnly: isReadOnly,
                      ),
                      const SizedBox(height: 32.0),
                      if (!isReadOnly) ...[
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _saveReport,
                            child: Text(
                              S.of(context).save,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],

                      TextButton(
                        onPressed: () {
                          String reportText =
                              '${S.of(context).total}: $totalQuantity\n\n';
                          for (var entry
                              in widget.report.bloodCells!.allCells.entries) {
                            reportText +=
                                '${entry.key}: ${entry.value} (${wbcPercentages[entry.key]!.toStringAsFixed(2)}%)\n';
                          }
                          Share.share(reportText);
                        },
                        child: Text(
                          S.of(context).shareReport,
                        ),
                      ),
                      if (isReadOnly) ...[
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[400]),
                            onPressed: _deleteReport,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.delete, color: Colors.white),
                                const SizedBox(width: 8.0),
                                Text(
                                  S.of(context).delete,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _saveReport() async {
    final String name = _nameController.text;
    final int age = int.tryParse(_ageController.text) ?? 0;
    final String observation = _observationController.text;

    // Create a SaveReportModel instance with patient data and report data
    final SaveReportModel report = widget.report.copyWith(
      name: name,
      age: age,
      observation: observation,
      bloodCells: widget.report.bloodCells,
    );

    context.read<CellCountBloc>().add(CellCountSaveEvent(report: report));
  }

  void _deleteReport() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocConsumer<CellCountBloc, CellCountState>(
          listener: (context, state) {
            if (state is CellCountDeletedState) {
              Navigator.of(context).pop();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(S.of(context).msg_reportDeleted),
                ),
              );
            }
          },
          builder: (context, state) {
            return AlertDialog(
              title: Text(S.of(context).deleteReport),
              content: Text(S.of(context).confirmDeleteReport),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(S.of(context).cancel),
                ),
                TextButton(
                  onPressed: () {
                    context
                        .read<CellCountBloc>()
                        .add(CellCountDeleteEvent(id: widget.report.id!));
                  },
                  child: Text(S.of(context).delete),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _checkSaveReport() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Antes de sair'),
            content: const Text('Deseja salvar o relatório?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Não'),
              ),
              TextButton(
                onPressed: () {
                  _saveReport();
                },
                child: const Text('Sim'),
              ),
            ],
          );
        });
  }

  void _editReport() async {
    isReadOnly = false;
    setState(() {});
  }
}
