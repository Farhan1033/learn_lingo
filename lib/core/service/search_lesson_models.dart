import 'dart:convert';

import 'package:learn_lingo/core/models/search_lesson_api.dart';
import 'package:http/http.dart' as http;
import 'package:learn_lingo/core/utils/localhost.dart';

class SearchLessonModels {
  Future<SearchLessonApi?> searchLessonModel(
      String token, String querySearch) async {
    final response = await http.get(
        Uri.parse(
            "http://${Localhost.localhost}/lesson-parts/search/$querySearch"),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return SearchLessonApi.fromJson(jsonData);
    } else {
      return null;
    }
  }
}
