import 'package:flutter/material.dart';
import 'package:learn_lingo/core/models/forgot_password_models.dart';
import 'package:learn_lingo/core/service/forgot_password_services.dart';
import 'package:learn_lingo/core/theme/color_primary.dart';
import 'package:learn_lingo/features/Forgot%20Password/generate_otp_provider.dart';
import 'package:provider/provider.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  ForgotPasswordModels? _forgotPasswordModels;
  final ForgotPasswordServices _forgotPasswordServices =
      ForgotPasswordServices();
  final TextEditingController codeVerifyController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  ForgotPasswordModels? get forgotPasswordModels => _forgotPasswordModels;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _errorMessage = value;
    notifyListeners();
  }

  void _setForgotPasswordModels(ForgotPasswordModels? data) {
    _forgotPasswordModels = data;
    notifyListeners();
  }

  bool _isValidCodeVerify(String codeVerify) {
    return codeVerify.length == 6;
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  Future<void> forgotPassword(
      BuildContext context, String codeVerify, String newPassword) async {
    _setLoading(true);
    _setError(null);

    if (!_isValidCodeVerify(codeVerify)) {
      _showSnackBar(context, "OTP code not valid. Please check your OTP code.",
          Warna.salah);
      _setLoading(false);
      return;
    }

    try {
      final emailProvider =
          Provider.of<GenerateOtpProvider>(context, listen: false);
      final response = await _forgotPasswordServices.forgotPassword(
          emailProvider.emailController.text, codeVerify, newPassword);

      if (response != null) {
        _setForgotPasswordModels(response);
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/login');
        }
      } else {
        _setError("OTP code not valid");
        _showSnackBar(
            context,
            _errorMessage ?? "Something went wrong while verifying OTP code.",
            Warna.salah);
      }
    } catch (e) {
      _setError(e.toString());
      _showSnackBar(context, "Error occurred: ${e.toString()}", Warna.salah);
    } finally {
      _setLoading(false);
      clean();
    }
  }

  void clean() {
    codeVerifyController.clear();
    newPasswordController.clear();
    _errorMessage = null;
    _forgotPasswordModels = null;
    notifyListeners();
  }
}
