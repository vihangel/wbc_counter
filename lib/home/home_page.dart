import 'package:flutter/material.dart';
import 'package:wbc_counter/models/white_blood_cells_model.dart';
import 'package:wbc_counter/report/report_page.dart';

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
      appBar: AppBar(
        title: const Text('Calculadora'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              // Handle help icon click
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Handle settings icon click
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total: ${getTotalQuantity()}'), // Display the total quantity
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Text('Clique para:'),
                TextButton(
                  onPressed: toggleMode,
                  style: TextButton.styleFrom(primary: Colors.purple),
                  child: Text(isAdicionarMode ? 'Adicionar' : 'Remover'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
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
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  _navigateToReportPage(context);
                },
                child: const Text('Calcular'),
              ),
            ),
          ],
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
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  _navigateToReportPage(context); // Navigate to the report page
                },
                child: const Text('Gerar'),
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
}

class WBCQuantityWidget extends StatelessWidget {
  final String name;
  final int quantity;
  final String imagePath;
  final bool isAdicionarMode;
  final ValueChanged<int> onUpdateQuantity;

  const WBCQuantityWidget({
    required this.name,
    required this.quantity,
    required this.isAdicionarMode,
    required this.onUpdateQuantity,
    required this.imagePath,
  });

  void _onTap() {
    if (isAdicionarMode) {
      onUpdateQuantity(quantity + 1);
    } else {
      if (quantity > 0) {
        onUpdateQuantity(quantity - 1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              '$quantity',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: Image.asset(
              'assets/cells/$imagePath',
              fit: BoxFit.scaleDown,
            ),
          ),
          Text(
            name,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
