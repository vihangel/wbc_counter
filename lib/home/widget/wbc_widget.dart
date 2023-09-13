import 'package:flutter/material.dart';

class WBCQuantityWidget extends StatelessWidget {
  final String name;
  final int quantity;
  final String imagePath;
  final bool isAdicionarMode;
  final ValueChanged<int> onUpdateQuantity;

  const WBCQuantityWidget({
    super.key,
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
      child: Container(
        constraints: const BoxConstraints(maxWidth: 100, minWidth: 90),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding:
            const EdgeInsets.only(top: 0, bottom: 8.0, left: 8.0, right: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(8.0),
              ),
              width: double.infinity,
              child: Text(
                '$quantity',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 90,
              height: 90,
              child: Image.asset(
                'assets/cells/$imagePath',
                fit: BoxFit.fitWidth,
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
      ),
    );
  }
}
