import 'dart:convert';

import 'package:learn_lingo/core/models/help_exercise_api.dart';
import 'package:http/http.dart' as http;
import 'package:learn_lingo/core/utils/localhost.dart';

class HelpExerciseModels {
  Future<HelpExerciseApi?> helpExerciseModels(String token) async {
    final response = await http.put(
      Uri.parse('http://${Localhost.localhost}/gamification/redeem/bantuan'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return HelpExerciseApi.fromJson(jsonData);
    } else {
      return null;
    }
  }
}
