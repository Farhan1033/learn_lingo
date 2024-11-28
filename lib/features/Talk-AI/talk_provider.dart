import 'package:flutter/material.dart';
import 'package:learn_lingo/core/models/talk_ai_api.dart';
import 'package:learn_lingo/core/service/talk_ai_models.dart';
import 'package:learn_lingo/core/utils/shared_preferences.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TalkProvider with ChangeNotifier {
  final SpeechToText _speechToText = SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  bool _isListening = false;
  bool _isLoading = false;
  String _lastWords = '';
  String _resultAiWord = '';
  TalkAiApi? _talkAiApi;
  final TalkAiModels _talkAiModels = TalkAiModels();

  bool get isListening => _isListening;
  bool get isLoading => _isLoading;
  String get lastWords => _lastWords;
  String get resultAiWord => _resultAiWord;
  TalkAiApi? get talkAiApi => _talkAiApi;

  Future<void> initializeSpeech() async {
    _isListening = await _speechToText.initialize();
    await initializeTTS(); // Inisialisasi TTS
    notifyListeners();
  }

  Future<void> startListening() async {
    if (_isListening) {
      debugPrint("Started listening");
      await _speechToText.listen(onResult: _onSpeechResult);
      _isListening = true;
      notifyListeners();
    }
  }

  Future<void> stopListening() async {
    debugPrint("Stopped listening");
    await _speechToText.stop();
    _isListening = false;
    notifyListeners();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords;
    if (result.finalResult) {
      _sendDataAI();
    }
    notifyListeners();
  }

  Future<void> _sendDataAI() async {
    _isLoading = true;
    notifyListeners();

    try {
      final token = await Token().getToken();
      final sendData =
          await _talkAiModels.talkAiModels(token ?? '', _lastWords);

      if (sendData != null) {
        _talkAiApi = sendData;
        _resultAiWord = "${sendData.answer}";

        // TTS untuk membaca hasil dari AI
        await _flutterTts.speak(_resultAiWord);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> initializeTTS() async {
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
  }

  void reset() {
    _lastWords = '';
    _resultAiWord = '';
    notifyListeners();
  }
}
