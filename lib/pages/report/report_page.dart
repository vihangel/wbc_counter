import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wbc_counter/bloc/cell%20count/cell_count_bloc.dart';
import 'package:wbc_counter/bloc/local_reports/local_reports_bloc.dart';
import 'package:wbc_counter/generated/l10n.dart';
import 'package:wbc_counter/models/blood_cells_model.dart';
import 'package:wbc_counter/models/saved_report_model.dart';
import 'package:wbc_counter/pages/home/home_page.dart';
import 'package:wbc_counter/pages/home/model/total_cells_blood_model.dart';
import 'package:wbc_counter/pages/home/widget/add_report_informations_widget.dart';
import 'package:wbc_counter/pages/local_reports/local_reports_page.dart';

class ReportPage extends StatefulWidget {
  final SaveReportModel report;
  final bool isReadOnly;

  const ReportPage({super.key, required this.report, this.isReadOnly = false});

  @override
  ReportPageState createState() => ReportPageState();
}

class ReportPageState extends State<ReportPage> {
  late final TextEditingController _nameController =
      TextEditingController(text: widget.report.name);
  late final TextEditingController _ageController =
      TextEditingController(text: '${widget.report.age ?? 0}');
  late final TextEditingController _observationController =
      TextEditingController(text: widget.report.observation);

  late bool isReadOnly = widget.isReadOnly;

  @override
  void initState() {
    super.initState();
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
    int totalQuantity = widget.report.bloodCells?.totalWbcCount ?? 0;

    Map<String, double> wbcPercentages = {};
    widget.report.bloodCells?.countCells.forEach((BloodCellModel cell) {
      final percentage = (cell.quantity / totalQuantity) * 100;
      wbcPercentages[cell.name] = percentage.isNaN ? 0 : percentage;
    });

    return PopScope(
      onPopInvokedWithResult: (value, result) async {
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
                      Text(
                        S.of(context).explainCount,
                        style: TextStyle(
                          color: Colors.red.shade400,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
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
                        legendOptions: const LegendOptions(
                          showLegendsInRow: true,
                          legendPosition: LegendPosition.bottom,
                          showLegends: true,
                          legendTextStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
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
                          Color.fromARGB(255, 58, 137, 183),
                          Color.fromARGB(255, 204, 229, 255),
                          Color.fromARGB(255, 204, 255, 204),
                          Color.fromARGB(255, 255, 230, 204),
                          Color.fromARGB(255, 255, 204, 204),
                          Color.fromARGB(255, 255, 204, 255),
                          Color.fromARGB(255, 229, 204, 255),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      // Display the report table
                      DataTable(
                        columnSpacing: 16.0,
                        columns: [
                          DataColumn(label: Text(S.of(context).type)),
                          DataColumn(label: Text(S.of(context).quantity)),
                          const DataColumn(label: Text('%')),
                        ],
                        rows: generateDataRows(
                            widget.report.bloodCells!, context),
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
                      if (widget.report.findings?.isNotEmpty ?? false)
                        AddReportInformations(
                          onlyShow: true,
                          images: widget.report.findings!,
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
                              in widget.report.bloodCells!.allCells) {
                            reportText +=
                                '${entry.title}: ${entry.quantity} (${wbcPercentages[entry.name]!.toStringAsFixed(2)}%)\n';
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

  List<DataRow> generateDataRows(TotalCellsBlood report, BuildContext context) {
    final allCells = report.allCells;
    final int totalQuantity = report.totalWbcCount;

    return allCells.map((BloodCellModel cell) {
      double percentage = (cell.quantity / totalQuantity) * 100;
      percentage = percentage.isNaN ? 0 : percentage;
      return DataRow(
        cells: [
          DataCell(Text(cell.title)),
          DataCell(Text('${cell.quantity}')),
          DataCell(Text('${percentage.toStringAsFixed(2)}%')),
        ],
      );
    }).toList();
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

  /// TODO: Implement this method
  // ignore: unused_element
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
