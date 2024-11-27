import 'dart:convert';

import 'package:learn_lingo/core/models/progress_api.dart';
import 'package:learn_lingo/core/utils/localhost.dart';
import 'package:http/http.dart' as http;

class ProgressModels {
  Future<ProgressApi?> progressModels(String token) async {
    final response = await http.get(
        Uri.parse('http://${Localhost.localhost}/progress/latest'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ProgressApi.fromJson(jsonData['data']);
    } else {
      return null;
    }
  }
}
