import 'package:flutter/material.dart';
import 'package:learn_lingo/core/models/search_lesson_api.dart';
import 'package:learn_lingo/core/service/search_lesson_models.dart';
import 'package:learn_lingo/core/utils/shared_preferences.dart';

class SearchLessonProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  SearchLessonApi? _searchLessonApi;
  final SearchLessonModels searchLessonModels = SearchLessonModels();

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  SearchLessonApi? get searchLessonApi => _searchLessonApi;

  final TextEditingController searchController = TextEditingController();

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setErrorMessage(String value) {
    _errorMessage = value;
    notifyListeners();
  }

  void setSearchLessonApi(SearchLessonApi value) {
    _searchLessonApi = value;
    notifyListeners();
  }

  Future<void> searchQuery(String query) async {
    setLoading(true);
    setErrorMessage("");

    try {
      final token = await Token().getToken();
      final searchLessonData = await searchLessonModels.searchLessonModel(
          token ?? "Token not found!", query);

      if (searchLessonData != null) {
        setSearchLessonApi(searchLessonData);
      } else {
        setErrorMessage("Data not found!");
      }
    } catch (e) {
      setErrorMessage("Error: ${e.toString()}");
    } finally {
      setLoading(false);
    }
  }

  Future<void> fetchInitialData() async {
    setLoading(true);
    setErrorMessage("");
    try {
      final token = await Token().getToken();
      final searchLessonData = await searchLessonModels.searchLessonModel(
          token ?? "Token not found!", "");
      if (searchLessonData != null) {
        setSearchLessonApi(searchLessonData);
      } else {
        setErrorMessage("Data not found!");
      }
    } catch (e) {
      setErrorMessage("Error: ${e.toString()}");
    } finally {
      setLoading(false);
      cleanSearch();
      cleanData();
    }
  }

  void cleanSearch() {
    searchController.clear();
    cleanData();
  }

  void cleanData() {
    _isLoading = false;
    _errorMessage = null;
    _searchLessonApi = null;
    notifyListeners();
  }
}
