import 'package:learn_lingo/core/models/exercise_api.dart';
import 'package:learn_lingo/core/models/exercise_detail.dart';
import 'package:learn_lingo/core/models/gamification_exercise_api.dart';
import 'package:learn_lingo/core/service/event_lesson_models.dart';
import 'package:learn_lingo/core/service/excercise_models.dart';
import 'package:learn_lingo/core/service/exercise_detail_models.dart';
import 'package:flutter/material.dart';
import 'package:learn_lingo/core/service/gamification_exercise_models.dart';
import 'package:learn_lingo/core/theme/button_app.dart';
import 'package:learn_lingo/core/theme/color_primary.dart';
import 'package:learn_lingo/core/theme/typography.dart';
import 'package:learn_lingo/core/utils/shared_preferences.dart';

class ExerciseProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  ExcerciseApi? _exerciseApi;
  final ExcerciseModels _exerciseModels = ExcerciseModels();
  ExerciseDetail? _exerciseDetail;
  final ExerciseDetailModels _exerciseDetailModels = ExerciseDetailModels();
  bool _isAnswerSelected = false;
  int _currentIndex = 0;
  int _selectedAnswerIndex = -1;
  int _gradeExercise = 0;
  double? _totalGrade;
  final EventLessonModels _eventLessonModels = EventLessonModels();
  int _exerciseLife = 5;
  GamificationExerciseApi? _gamificationExerciseApi;
  final GamificationExerciseModels _gamificationExerciseModels =
      GamificationExerciseModels();

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  ExcerciseApi? get exerciseApi => _exerciseApi;
  ExerciseDetail? get exerciseDetail => _exerciseDetail;
  bool get isAnswerSelected => _isAnswerSelected;
  int get currentIndex => _currentIndex;
  int get selectedAnswerIndex => _selectedAnswerIndex;
  int get gradeExercise => _gradeExercise;
  double? get totalGrade => _totalGrade;
  int get exerciseLife => _exerciseLife;
  GamificationExerciseApi? get gamificationExerciseApi =>
      _gamificationExerciseApi;

  String get statusKelulusan {
    if (_exerciseApi == null) {
      return 'Belum ada nilai';
    }
    _totalGrade = (_gradeExercise / _exerciseApi!.quiz!.length) * 100;
    return _totalGrade! >= 75 ? 'Lulus' : 'Tidak Lulus';
  }

  void checkAndSetAnswer(int index, BuildContext context) {
    _selectedAnswerIndex = index;
    _isAnswerSelected = true;

    final isCorrect = _exerciseApi!.quiz![_currentIndex].correctAnswer == index;

    if (isCorrect) {
      _gradeExercise += 1;
      _showSnackBar(context, 'Jawaban Benar!', Warna.benar);
    } else {
      _exerciseLife = (_exerciseLife - 1).clamp(0, _exerciseLife);
      _showSnackBar(context, 'Jawaban Salah. Coba Lagi!', Warna.salah);

      if (_exerciseLife == 0) {
        _showOutOfLivesDialog(context);
        return;
      }
    }

    notifyListeners();
  }

  bool _isDialogShown = false;

  void _showOutOfLivesDialog(BuildContext context) {
    if (_isDialogShown) return;
    _isDialogShown = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: Warna.primary1,
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Warna.primary1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Tipografi().h6(
                  isiText: 'Try Again',
                  warnaFont: Warna.netral1,
                ),
                const SizedBox(height: 10),
                Image.asset(
                  'assets/images/Clip path group.png',
                  scale: 3,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Your life runs out, You failed to complete the quiz',
                  style: TextStyle(
                    color: Warna.netral1,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Tombol().primarySmall(
                  teksTombol: 'Retry',
                  lebarTombol: double.maxFinite,
                  navigasiTombol: () {
                    Navigator.pop(context);
                    resetQuiz();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void nextQuiz() {
    if (_currentIndex + 1 < _exerciseApi!.quiz!.length) {
      _selectedAnswerIndex = -1;
      _isAnswerSelected = false;
      _currentIndex++;
      notifyListeners();
    }
  }

  void resetQuiz() {
    _selectedAnswerIndex = -1;
    _isAnswerSelected = false;
    _currentIndex = 0;
    _exerciseLife = 5;
    _gradeExercise = 0;
    loadExercise(_exerciseApi!.exerciseId!);
    notifyListeners();
  }

  Future<void> saveValue(String exerciseId, double score) async {
    _setLoadingState(true);
    _errorMessage = null;

    try {
      final token = await Token().getToken();
      final exerciseData = await _exerciseDetailModels.exerciseDetailModels(
          token ?? '', exerciseId, score);
      if (exerciseData != null) {
        _exerciseDetail = exerciseData;
      } else {
        _exerciseDetail = null;
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoadingState(true);
    }
  }

  Future<void> loadExercise(String exerciseId) async {
    _setLoadingState(true);
    _errorMessage = null;

    try {
      final token = await Token().getToken();
      final exerciseData =
          await _exerciseModels.excercise(exerciseId, token ?? '');
      if (exerciseData != null) {
        _exerciseApi = exerciseData;
      } else {
        _errorMessage = 'Data exercise tidak ditemukan.';
      }
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan: ${e.toString()}';
      cleanData();
    } finally {
      _setLoadingState(false);
    }
  }

  Future<void> gamificationExercise() async {
    _setLoadingState(true);
    _errorMessage = null;

    try {
      final token = await Token().getToken();
      final gamificationExerciseData =
          await _gamificationExerciseModels.gamificationExercise(token ?? '');
      if (gamificationExerciseData != null) {
        _gamificationExerciseApi = gamificationExerciseData;
      } else {
        _errorMessage = 'Data exercise tidak ditemukan.';
      }
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan: ${e.toString()}';
      cleanData();
    } finally {
      _setLoadingState(false);
    }
  }

  Future<void> completeExercise(String courseId, String lessonId) async {
    _setLoadingState(true);
    _errorMessage = null;

    try {
      final token = await Token().getToken();
      await _eventLessonModels.eventExcerciseCompleted(
          token ?? 'Token Not Found', lessonId, courseId, 'exercise');
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoadingState(false);
    }
  }

  void cleanData() {
    _errorMessage = null;
    _exerciseApi = null;
    notifyListeners();
  }

  void _setLoadingState(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _showSnackBar(
      BuildContext context, String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
