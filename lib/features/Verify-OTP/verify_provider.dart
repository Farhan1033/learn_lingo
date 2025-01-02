import 'package:flutter/material.dart';
import 'package:learn_lingo/core/models/verify_api.dart';
import 'package:learn_lingo/core/service/verify_models.dart';
import 'package:learn_lingo/core/theme/color_primary.dart';
import 'package:learn_lingo/core/utils/shared_preferences.dart';

class VerifyProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _hasError;
  VerifyApi? _verifyApi;
  final VerifyModels _verifyModels = VerifyModels();

  final TextEditingController codeVerifyController = TextEditingController();

  VerifyApi? get verifyApi => _verifyApi;
  String? get hasError => _hasError;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(String value) {
    _hasError = value;
    notifyListeners();
  }

  void setVerifyApi(VerifyApi data) {
    _verifyApi = data;
    notifyListeners();
  }

  Future<void> verifyOTP(BuildContext context, String codeVerify) async {
    setLoading(true);
    setError("");

    if (!isValidCodeVerify(codeVerify)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Kode OTP tidak valid. Periksa kembali kode OTP Anda."),
          backgroundColor: Warna.salah,
        ),
      );
      setLoading(false);
      return;
    }

    try {
      final token = await Token().getName();
      final response = await _verifyModels.talkModels(
          token ?? 'Email not found!', codeVerify);

      if (response != null) {
        setVerifyApi(response);

        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      } else {
        setError('Kode OTP tidak valid');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                _hasError ?? "Terjadi kesalahan saat memverifikasi kode OTP."),
            backgroundColor: Warna.salah,
          ),
        );
      }
    } catch (e) {
      setError(e.toString());
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Terjadi kesalahan: ${e.toString()}"),
          backgroundColor: Warna.salah,
        ),
      );
    } finally {
      setLoading(false);
      clean();
    }
  }

  bool isValidCodeVerify(String codeVerify) {
    return codeVerify.length == 6;
  }

  void clean() {
    codeVerifyController.clear();
    _hasError = null;
    notifyListeners();
  }
}
