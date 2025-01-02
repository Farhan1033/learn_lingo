import 'package:flutter/material.dart';
import 'package:learn_lingo/core/models/generate_otp_models.dart';
import 'package:learn_lingo/core/service/generate_otp_service.dart';
import 'package:learn_lingo/core/theme/color_primary.dart';

class GenerateOtpProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  GenerateOtpModels? _otpModels;
  String? _email;
  final GenerateOtpService _otpService = GenerateOtpService();

  final TextEditingController emailController = TextEditingController();

  GenerateOtpModels? get otpModels => _otpModels;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get email => _email;

  GenerateOtpProvider() {
    // Tambahkan listener untuk menyimpan nilai email
    emailController.addListener(() {
      _email = emailController.text;
      notifyListeners(); // Memanggil listener agar UI diperbarui jika perlu
    });
  }

  void _setLoading(bool value) {
    _isLoading = value;
  }

  void _setError(String value) {
    _errorMessage = value;
  }

  void _setOtpModels(GenerateOtpModels data) {
    _otpModels = data;
  }

  bool _isValidEmail(String email) {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  Future<void> generateOtp(BuildContext context, String email) async {
    if (!_isValidEmail(email)) {
      _showSnackBar(
          context, "Email not valid. Please check your email.", Warna.salah);
      return;
    }

    _setLoading(true);
    _setError("");

    try {
      final response = await _otpService.talkModels(email);
      if (response != null) {
        _setOtpModels(response);
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/forgot-password');
        }
      } else {
        _setError("Email not found");
        _showSnackBar(
            context, "Email not valid. Please check your email.", Warna.salah);
      }
    } catch (e) {
      _setError(e.toString());
      _showSnackBar(context, "Error occured: ${e.toString()}", Warna.salah);
    } finally {
      _setLoading(false);
      clear();
    }
  }

  void clear() {
    // emailController.clear();
    _otpModels = null;
    _errorMessage = null;
    _isLoading = false;
  }
}
