// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wbc_counter/home/widget/wbc_widget.dart';
import 'package:wbc_counter/models/white_blood_cells_model.dart';
import 'package:wbc_counter/report/report_page.dart';
import 'package:wbc_counter/tips/tips_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAdicionarMode = true;
  Map<String, int> wbcQuantities = {
    'Neutrófilo': 0,
    'Basófilo': 0,
    'Eosinófilo': 0,
    'Monócito': 0,
    'Linfócito': 0,
  };

  List<WhiteBloodCell> whiteBloodCells = [
    WhiteBloodCell(
        name: 'Neutrófilo', quantity: 0, imagePath: 'neutrofilo.png'),
    WhiteBloodCell(name: 'Basófilo', quantity: 0, imagePath: 'basofilo.png'),
    WhiteBloodCell(
        name: 'Eosinófilo', quantity: 0, imagePath: 'eosinofilo.png'),
    WhiteBloodCell(name: 'Monócito', quantity: 0, imagePath: 'monocito.png'),
    WhiteBloodCell(name: 'Linfócito', quantity: 0, imagePath: 'linfocito.png'),
  ];

  void toggleMode() {
    setState(() {
      isAdicionarMode = !isAdicionarMode;
    });
  }

  void updateQuantity(String wbcName, int newQuantity) {
    setState(() {
      wbcQuantities[wbcName] = newQuantity;
    });
    _checkCellCountAndShowAlert();
  }

  int getTotalQuantity() {
    return wbcQuantities.values.reduce((a, b) => a + b);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/logo.svg',
          colorFilter:
              const ColorFilter.mode(Colors.deepPurple, BlendMode.srcIn),
          height: 32,
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TipsPage(),
                ),
              );
            },
          ),
          // IconButton(
          //   icon: const Icon(Icons.settings),
          //   onPressed: () {
          //     // Handle settings icon click
          //   },
          // ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: ${getTotalQuantity()}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: _clearAllValues,
                    child: const Text('Apagar tudo'),
                  ),
                ],
              ), // Display the total quantity

              Row(
                children: [
                  const Text(
                    'Clique para:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: toggleMode,
                    child: Text(isAdicionarMode ? 'Adicionar' : 'Remover'),
                  ),
                ],
              ),
              const SizedBox(height: 36),
              Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                runAlignment: WrapAlignment.center,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: whiteBloodCells.map((wbc) {
                  return WBCQuantityWidget(
                    name: wbc.name,
                    quantity: wbcQuantities[wbc.name]!,
                    imagePath: wbc.imagePath,
                    isAdicionarMode: isAdicionarMode,
                    onUpdateQuantity: (newQuantity) {
                      updateQuantity(wbc.name, newQuantity);
                    },
                  );
                }).toList(),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _navigateToReportPage(context);
                  },
                  child: const Text('Calcular',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _checkCellCountAndShowAlert() {
    int totalQuantity = getTotalQuantity();
    if (totalQuantity == 100) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Você adicionou 100 celulas'),
            content: const Text(
                'Deseja continuar adicionando ou gerar o relatório?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Continuar'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  _navigateToReportPage(context); // Navigate to the report page
                },
                child: const Text('Calcular',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      );
    }
  }

  void _navigateToReportPage(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ReportPage(wbcQuantities: wbcQuantities),
      ),
    );
  }

  void _clearAllValues() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Limpar Valores'),
          content:
              const Text('Tem certeza de que deseja limpar todos os valores?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Clear all values
                wbcQuantities = {
                  'Neutrófilo': 0,
                  'Basófilo': 0,
                  'Eosinófilo': 0,
                  'Monócito': 0,
                  'Linfócito': 0,
                };
                Navigator.of(context).pop(); // Close the dialog
                setState(() {}); // Update the UI
              },
              child: const Text('Confirmar',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
