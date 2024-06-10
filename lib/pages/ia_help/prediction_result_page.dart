import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wbc_counter/generated/l10n.dart';
import 'package:wbc_counter/models/predicition_model.dart';
import 'package:wbc_counter/pages/ia_help/widget/prediction_widget.dart';

class ResultsPage extends StatelessWidget {
  final Uint8List imageData;
  final List<Prediction> predictions;

  const ResultsPage(
      {Key? key, required this.imageData, required this.predictions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).analysisResults),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.memory(imageData,
                height: 200, width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(
              S.of(context).experimentalFeature,
              style: const TextStyle(
                  color: Colors.red, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: predictions.length,
                itemBuilder: (context, index) {
                  return PredictionWidget(prediction: predictions[index]);
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).backToMenu),
            ),
          ],
        ),
      ),
    );
  }
}
