import 'package:learn_lingo/core/models/analysis_detail_api.dart';
import 'package:learn_lingo/core/service/analysis_detail_models.dart';
import 'package:learn_lingo/core/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class AnalysisDetailProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _hasError = false;
  AnalysisDetailApi? _analysisDetailApi;
  final AnalysisDetailModels _analysisDetailModels = AnalysisDetailModels();

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  AnalysisDetailApi? get analysisDetailApi => _analysisDetailApi;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(bool value) {
    _hasError = value;
    notifyListeners();
  }

  void setAnalysisDetailApi(AnalysisDetailApi? value) {
    _analysisDetailApi = value;
    notifyListeners();
  }

  Future<void> analysisDetail() async {
    setLoading(true);
    setError(false);
    try {
      final token = await Token().getToken();
      final analysisData = await _analysisDetailModels
          .analysisDetailModels(token ?? 'Token Not Found!');
      if (analysisData != null) {
        setAnalysisDetailApi(analysisData);
      }
    } catch (e) {
      setError(true);
    } finally {
      setLoading(false);
    }
  }

  void cleanData(){
    setError(false);
    setAnalysisDetailApi(null);
    notifyListeners();
  }
}
