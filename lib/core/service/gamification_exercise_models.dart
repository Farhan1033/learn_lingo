import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:learn_lingo/core/models/gamification_exercise_api.dart';
import 'package:learn_lingo/core/utils/localhost.dart';

class GamificationExerciseModels {
  Future<GamificationExerciseApi?> gamificationExercise(String token) async {
    final respons = await http.get(
        Uri.parse('http://${Localhost.localhost}/gamification/user'),
        headers: {'Authorization': 'Bearer $token'});

    if (respons.statusCode == 200) {
      final jsonData = jsonDecode(respons.body);
      return GamificationExerciseApi.fromJson(jsonData);
    } else {
      return null;
    }
  }
}
