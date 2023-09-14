// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wbc_counter/home/pages/support_page.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: _scaffoldKey,
      extendBody: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: SvgPicture.asset(
          'assets/logo.svg',
          colorFilter:
              const ColorFilter.mode(Colors.deepPurple, BlendMode.srcIn),
          height: 32,
        ),
        centerTitle: true,
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
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/logo.svg',
                  height: 50,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.save_alt_outlined),
              title: const Text('Relatórios Salvos'),
              onTap: () {
                Navigator.pop(context);
                // Handle Relatórios Salvos
              },
            ),
            ListTile(
              leading: const Icon(Icons.monetization_on_outlined),
              title: const Text('Sobre'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SupportPage(),
                  ),
                );
                // Handle Apoie
              },
            ),
            ListTile(
              leading: const Icon(Icons.star_border_outlined),
              title: const Text('Avalie'),
              onTap: () {
                Navigator.pop(context);
                _showAppStoreAlert(context);
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
                // Handle Configurações
              },
            ),
          ],
        ),
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

  void _showAppStoreAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Avalie o App'),
          content: const Text(
            'Está gostando do app?\nDeixe uma avaliação na loja!\n\nIsso ajuda muito!',
            // textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Open the app store here (e.g., using url_launcher package)
              },
              child: const Text('Abrir Loja',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
