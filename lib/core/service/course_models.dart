import 'dart:convert';
import 'package:learn_lingo/core/models/course_api.dart';
import 'package:learn_lingo/core/utils/localhost.dart';
import 'package:http/http.dart' as http;

class CourseService {
  Future<CourseApi?> courses(
      String categoryCourses, String tokenCourse) async {
    final response = await http.get(
        Uri.parse(
            "http://${Localhost.localhost}/courses?coursename=speaking&coursecategory=$categoryCourses"),
        headers: {'Authorization': 'Bearer $tokenCourse'});
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return CourseApi.fromJson(jsonData['data']);
    } else {
      return null;
    }
  }
}
