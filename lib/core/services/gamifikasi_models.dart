import 'dart:convert';

import 'package:learn_lingo/core/models/gamification_api.dart';
import 'package:learn_lingo/core/utils/localhost.dart';
import 'package:http/http.dart' as http;

class GamifikasiModels {
  Future<GamificationApi?> gamifikasiModel(String token) async {
    final respons = await http.get(
        Uri.parse('http://${Localhost.localhost}/gamification'),
        headers: {'Authorization': 'Bearer $token'});

    if (respons.statusCode == 200) {
      final jsonData = jsonDecode(respons.body);
      return GamificationApi.fromJson(jsonData['data']);
    } else {
      return null;
    }
  }
}
