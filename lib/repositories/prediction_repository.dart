import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wbc_counter/models/predicition_model.dart';

class PredictionRepository {
  final String baseUrl;
  final String apiKey;

  PredictionRepository({required this.baseUrl, required this.apiKey});

  Future<String> uploadImageToFirebase(
      Uint8List imageData, String fileName) async {
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('images/$fileName');
      final uploadTask = storageRef.putData(imageData);
      await uploadTask;
      final downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image to Firebase: $e');
    }
  }

  Future<List<Prediction>> fetchPredictions(
      Uint8List imageData, String type) async {
    final fileName = 'image.${type.split('/').last}';
    final imageUrl = await uploadImageToFirebase(imageData, fileName);

    // Ensure that the URL is correctly formatted
    Uri apiUri = Uri.parse(
        '$baseUrl?api_key=$apiKey&image=${Uri.encodeComponent(imageUrl)}');

    try {
      var response = await http.get(apiUri);

      if (response.statusCode == 200) {
        List<dynamic> predictionsJson =
            jsonDecode(response.body)['predictions'];
        return predictionsJson
            .map((json) => Prediction.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Failed to load predictions: Status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to send image to API: $e');
    }
  }
}
