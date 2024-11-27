import 'package:learn_lingo/core/models/lesson_api.dart';
import 'package:learn_lingo/core/service/lesson_models.dart';
import 'package:learn_lingo/core/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class LessonProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  LessonApi? _lessonApi;
  final LessonModels _lessonModels = LessonModels();
  String _idLesson = '';

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  LessonApi? get lessonApi => _lessonApi;
  String get idLesson => _idLesson;

  void setIDLesson(String id) {
    _idLesson = id;
    notifyListeners();
  }

  Future<void> lessonFetch(String idCourses) async {
    _isLoading = true;
    _errorMessage = null;

    try {
      final token = await Token().getToken();
      final lessonData = await _lessonModels.lessonAPI(idCourses, token ?? '');
      if (lessonData != null) {
        _lessonApi = lessonData;
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void cleanData() {
    _lessonApi = null;
    _errorMessage = null;
    notifyListeners();
  }
}
