import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wbc_counter/generated/l10n.dart';
import 'package:wbc_counter/pages/ia_help/prediction_result_page.dart';
import 'package:wbc_counter/repositories/prediction_repository.dart';

class AiHelpPage extends StatefulWidget {
  const AiHelpPage({super.key});

  @override
  AiHelpPageState createState() => AiHelpPageState();
}

class AiHelpPageState extends State<AiHelpPage> {
//    'wbc_dataset/1';
//  'whitebloodcell-2/2';
  final ImagePicker _picker = ImagePicker();
  final PredictionRepository repository = PredictionRepository(
      baseUrl: "https://detect.roboflow.com/wbc_dataset/1",
      apiKey: "fk7VtI7nE6JeAvH5ZgsQ");
  bool _isLoading = false;

  Future<void> _pickImage(ImageSource source) async {
    setState(() {
      _isLoading = true;
    });
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final String extension = pickedFile.name.split('.').last;
      _sendImageToAPI(bytes, extension);
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _sendImageToAPI(Uint8List imageData, String type) async {
    try {
      var predictions = await repository.fetchPredictions(imageData, type);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResultsPage(
            imageData: imageData,
            predictions: predictions,
          ),
        ),
      );
    } catch (e) {
      _showErrorDialog(e.toString());
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).aiHelpPage),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              S.of(context).experimentalFeature,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            Text(
              S.of(context).dataDisclaimer,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed:
                  _isLoading ? null : () => _pickImage(ImageSource.gallery),
              child: Text(
                S.of(context).uploadFromGallery,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed:
                  _isLoading ? null : () => _pickImage(ImageSource.camera),
              child: Text(
                S.of(context).useCamera,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).error),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text(message)],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
