import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:learn_lingo/core/models/generate_otp_models.dart';
import 'package:learn_lingo/core/utils/localhost.dart';

class GenerateOtpService {
  Future<GenerateOtpModels?> talkModels(String email) async {
    final response = await http.post(
        Uri.parse('http://${Localhost.localhost}/auth/generate-new-otp'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'email': email,
        }));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return GenerateOtpModels.fromJson(jsonData);
    } else {
      return null;
    }
  }
}
