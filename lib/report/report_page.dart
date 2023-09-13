import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ReportPage extends StatelessWidget {
  final Map<String, int>
      wbcQuantities; // Pass the WBC quantities to the report screen

  ReportPage({required this.wbcQuantities});

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
        title: const Text('Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total: $totalQuantity'),
            const SizedBox(height: 16.0),
            // Display the chart
            PieChart(dataMap: wbcPercentages),
            const SizedBox(height: 16.0),
            // Display the report table
            DataTable(
              columns: const [
                DataColumn(label: Text('Tipos')),
                DataColumn(label: Text('Quantidade')),
                DataColumn(label: Text('Porcentagem')),
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
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Compartilhar relatório'),
            ),
          ],
        ),
      ),
    );
  }
}
