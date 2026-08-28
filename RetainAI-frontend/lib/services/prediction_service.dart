import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/prediction_model.dart';

class PredictionService {
  static const String endpointUrl = 'http://localhost:8000/predict';

  Future<EmployeePredictionResponse> predict(
    EmployeePredictionRequest request,
  ) async {
    try {
      final bodyJson = jsonEncode(request.toJson());
      debugPrint('Sending predict request to $endpointUrl: $bodyJson');

      final response = await http
          .post(
            Uri.parse(endpointUrl),
            headers: {'Content-Type': 'application/json'},
            body: bodyJson,
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(response.body) as Map<String, dynamic>;
        debugPrint('Predict response received: $decoded');
        return EmployeePredictionResponse.fromJson(decoded);
      } else {
        debugPrint('API Error: ${response.statusCode} - ${response.body}');
        // If API returned error status, fallback to simulation with note
        return EmployeePredictionResponse.fromSimulation(request);
      }
    } catch (e) {
      debugPrint('Network error contacting predict endpoint ($e). Falling back to simulation.');
      return EmployeePredictionResponse.fromSimulation(request);
    }
  }
}
