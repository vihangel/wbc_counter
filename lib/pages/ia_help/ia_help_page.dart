import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wbc_counter/bloc/theme/theme_bloc.dart';
import 'package:wbc_counter/models/predicition_model.dart';
import 'package:wbc_counter/repositories/prediction_repository.dart';

class AiHelpPage extends StatefulWidget {
  const AiHelpPage({super.key});

  @override
  AiHelpPageState createState() => AiHelpPageState();
}

class AiHelpPageState extends State<AiHelpPage> {
  final ImagePicker _picker = ImagePicker();
  final PredictionRepository repository = PredictionRepository(
      baseUrl: "https://detect.roboflow.com/whitebloodcell-2/2",
      apiKey: "fk7VtI7nE6JeAvH5ZgsQ");
  bool _isLoading = false;

  // Function to capture image from camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    setState(() {
      _isLoading = true;
    });
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      // On web, use the bytes directly since File operations are not supported
      if (kIsWeb) {
        // Read the file as bytes
        final bytes = await pickedFile.readAsBytes();
        String extension = pickedFile.name.substring(
            pickedFile.name.lastIndexOf('.') + 1, pickedFile.name.length);
        _sendImageToAPI(bytes, extension);
      } else {
        // On mobile, you can continue using the File class
        File imageFile = File(pickedFile.path);
        String extension = pickedFile.name.substring(
            pickedFile.name.lastIndexOf('.') + 1, pickedFile.name.length);
        _sendImageToAPI(imageFile.readAsBytesSync(), extension);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _sendImageToAPI(Uint8List imageData, type) async {
    try {
      var predictions = await repository.fetchPredictions(imageData, type);
      _showPredictionDialog(predictions);
    } catch (e) {
      _showErrorDialog(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Help Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed:
                  _isLoading ? null : () => _pickImage(ImageSource.gallery),
              child: Text('Upload from Gallery',
                  style: TextStyle(
                    color: context.read<ThemeAppBloc>().theme == ThemeMode.light
                        ? Colors.white
                        : const Color.fromARGB(255, 42, 42, 42),
                  )),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed:
                  _isLoading ? null : () => _pickImage(ImageSource.camera),
              child: Text('Use Camera',
                  style: TextStyle(
                    color: context.read<ThemeAppBloc>().theme == ThemeMode.light
                        ? Colors.white
                        : const Color.fromARGB(255, 42, 42, 42),
                  )),
            ),
            if (_isLoading) const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  void _showPredictionDialog(List<Prediction> predictions) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Predictions"),
          content: SingleChildScrollView(
            child: ListBody(
              children: predictions
                  .map((p) => Text(
                      'Class: ${p.className}, Confidence: ${p.confidence.toStringAsFixed(2)}%'))
                  .toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text(message)],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
