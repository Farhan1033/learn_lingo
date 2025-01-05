import 'dart:convert';
import 'package:learn_lingo/core/models/exercise_gamification_api.dart';
import 'package:learn_lingo/core/utils/localhost.dart';
import 'package:http/http.dart' as http;

class ExcerciseModels {
  Future<ExerciseGamificationApi?> excercise(String token) async {
    final response = await http.get(
      Uri.parse("http://${Localhost.localhost}/gamification/user"),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ExerciseGamificationApi.fromJson(jsonData);
    } else {
      return null;
    }
  }
}
