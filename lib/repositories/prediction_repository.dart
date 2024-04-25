import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:wbc_counter/models/predicition_model.dart';

class PredictionRepository {
  final String baseUrl;
  final String apiKey;

  PredictionRepository({required this.baseUrl, required this.apiKey});
  Future<List<Prediction>> fetchPredictions(
      Uint8List imageData, String type) async {
    // Encode the image data to base64
    String base64Image = base64Encode(imageData);

    Uri apiUri =
        Uri.parse('$baseUrl?api_key=$apiKey&format=image&labels=on&stroke=2');

    try {
      // Create the data URI for the image and prepare the body as a key-value pair
      // String body = 'data:image/$type;base64,$base64Image';
      Object body = jsonEncode({"data:image/$type;base64,$base64Image"});

// Send the HTTP POST request
      var response = await http.post(
        apiUri,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: body,
      );

      // Handle the response from the server
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
