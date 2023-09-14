import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:share/share.dart';

class ReportPage extends StatelessWidget {
  final Map<String, int>
      wbcQuantities; // Pass the WBC quantities to the report screen

  const ReportPage({super.key, required this.wbcQuantities});

  @override
  Widget build(BuildContext context) {
    // Calculate the total quantity
    int totalQuantity = wbcQuantities.values.reduce((a, b) => a + b);

    // Calculate the percentages
    Map<String, double> wbcPercentages = {};
    wbcQuantities.forEach((key, value) {
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
          child: Column(
            children: [
              Text('Total: $totalQuantity'),
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
                rows: wbcQuantities.entries.map((entry) {
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
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Salvar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  String reportText = 'Total: $totalQuantity\n\n';
                  for (var entry in wbcQuantities.entries) {
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
    );
  }
}
