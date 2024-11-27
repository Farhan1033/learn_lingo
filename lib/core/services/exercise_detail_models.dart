import 'dart:convert';

import 'package:learn_lingo/core/models/exercise_detail.dart';
import 'package:learn_lingo/core/utils/localhost.dart';
import 'package:http/http.dart' as http;

class ExerciseDetailModels {
  Future<ExerciseDetail?> exerciseDetailModels(
      String token, String exerciseId, double score) async {
    final response = await http.post(
        Uri.parse('http://${Localhost.localhost}/exercise-progress'),
        headers: {'Authorization': 'Bearer $token'},
        body: jsonEncode({'exercise_id': exerciseId, 'score': score}));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print(response.body);
      return ExerciseDetail.fromJson(jsonData['data']);
    } else {
      print(response.body);
      return null;
    }
  }
}
