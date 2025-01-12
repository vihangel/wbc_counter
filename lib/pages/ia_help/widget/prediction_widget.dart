import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wbc_counter/bloc/theme/theme_bloc.dart';
import 'package:wbc_counter/models/predicition_model.dart';

class PredictionWidget extends StatelessWidget {
  final Prediction prediction;

  const PredictionWidget({super.key, required this.prediction});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.read<ThemeAppBloc>().theme == ThemeMode.light
            ? Colors.white
            : const Color.fromARGB(255, 42, 42, 42),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Classe: ${prediction.className}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
              'Confiança: ${(prediction.confidence * 100).toStringAsFixed(2)}%'),
          const SizedBox(height: 5),
          Text('Posição: (${prediction.x}, ${prediction.y})'),
          const SizedBox(height: 5),
          Text('Tamanho: ${prediction.width} x ${prediction.height}'),
        ],
      ),
    );
  }
}
