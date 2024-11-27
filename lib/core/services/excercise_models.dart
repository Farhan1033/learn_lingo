import 'dart:convert';
import 'package:learn_lingo/core/models/exercise_api.dart';
import 'package:learn_lingo/core/utils/localhost.dart';
import 'package:http/http.dart' as http;

class ExcerciseModels {
  Future<ExcerciseApi?> excercise(String idExcercise, String token) async {
    final response = await http.get(
      Uri.parse("http://${Localhost.localhost}/exercise-parts/$idExcercise"),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ExcerciseApi.fromJson(jsonData['data']);
    } else {
      return null;
    }
  }
}
