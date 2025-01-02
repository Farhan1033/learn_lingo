import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learn_lingo/core/models/verify_api.dart';
import 'package:learn_lingo/core/utils/localhost.dart';

class VerifyModels {
  Future<VerifyApi?> talkModels(String email, String codeVerify) async {
    final response = await http.post(
        Uri.parse('http://${Localhost.localhost}/auth/verif-otp'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'email': email,
          'code': codeVerify,
        }));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return VerifyApi.fromJson(jsonData);
    } else {
      return null;
    }
  }
}
