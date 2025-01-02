import 'dart:convert';
import 'package:learn_lingo/core/models/forgot_password_models.dart';
import 'package:http/http.dart' as http;
import 'package:learn_lingo/core/utils/localhost.dart';

class ForgotPasswordServices {
  Future<ForgotPasswordModels?> forgotPassword(
      String email, String codeOTP, String newPassword) async {
    try {
      final response = await http
          .put(
        Uri.parse('http://${Localhost.localhost}/auth/forget-password'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'email': email,
          'code': codeOTP,
          'new_password': newPassword,
        }),
      )
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw Exception('Request timeout. Please try again later.');
      });

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ForgotPasswordModels.fromJson(jsonData);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception('Error: ${errorData['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      print('Exception: $e');
      rethrow;
    }
  }
}
