import 'package:learn_lingo/core/service/course_models.dart';
import 'package:learn_lingo/core/utils/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:learn_lingo/core/models/course_api.dart';

class CourseProvider with ChangeNotifier {
  final CourseService _courseService = CourseService();
  CourseApi? _courses;
  bool _isLoading = false;
  String? _errorMessage;
  final List<String> _displayedCategories = [
    'Bab 1 - 3',
    'Bab 4 - 6',
    'Bab 7 - 9'
  ];

  // Mapping displayed categories to API categories
  final Map<String, String> _apiCategories = {
    'Bab 1 - 3': 'beginner',
    'Bab 4 - 6': 'advanced',
    'Bab 7 - 9': 'intermediate'
  };

  String? _categoryCourse = 'Bab 1 - 3';
  String _idCourses = '';

  set categoryCourse(String? newCategory) {
    if (newCategory != null && newCategory != _categoryCourse) {
      _categoryCourse = newCategory;
      notifyListeners();
    }
  }

  String get idCourses => _idCourses;
  CourseApi? get course => _courses;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<String> get categories => _displayedCategories;
  String? get categoryCourse => _categoryCourse;

  // Get API category from displayed category
  String? get categoryForApi => _apiCategories[_categoryCourse];

  void setIdCourses(String id) {
    _idCourses = id;
    notifyListeners();
  }

  Future<void> fetchCourse(String categoryCourses) async {
    _isLoading = true;
    _errorMessage = null;
    try {
      final token = await Token().getToken();
      final fetchedCourse =
          await _courseService.courses(categoryCourses, token ?? 'Token null');
      if (fetchedCourse != null) {
        _courses = fetchedCourse;
      } else {
        _errorMessage = "Course not found.";
      }
    } catch (e) {
      _errorMessage = "An error occurred: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearData() {
    _courses = null;
    _errorMessage = null;
    notifyListeners();
  }
}
