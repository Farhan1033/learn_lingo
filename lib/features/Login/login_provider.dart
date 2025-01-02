import 'package:learn_lingo/core/models/login_api.dart';
import 'package:learn_lingo/core/service/login_models.dart';
import 'package:learn_lingo/core/theme/color_primary.dart';
import 'package:learn_lingo/core/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _hasError = false;
  LoginApi? _loginData;
  bool _keamananPass = true;
  final LoginService _loginService = LoginService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool get keamananPass => _keamananPass;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  LoginApi? get loginData => _loginData;

  void toggleKeamananPass() {
    _keamananPass = !_keamananPass;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(bool value) {
    _hasError = value;
    notifyListeners();
  }

  void setLoginData(LoginApi data) {
    _loginData = data;
    notifyListeners();
  }

  bool isValidEmail(String email) {
    final emailReg = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailReg.hasMatch(email);
  }

  bool isValidPassword(String passLength) {
    return passLength.length >= 6;
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    // Validasi email
    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email tidak valid. Periksa format email Anda."),
          backgroundColor: Warna.salah,
        ),
      );
      return;
    }

    // Validasi password
    if (!isValidPassword(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password harus memiliki setidaknya 6 karakter."),
          backgroundColor: Warna.salah,
        ),
      );
      return;
    }

    setLoading(true);
    setError(false);

    try {
      final Token token = Token();
      final loginData = await _loginService.loginUser(email, password);

      // Validasi jika login gagal
      if (loginData != null) {
        setLoginData(loginData);
        token.saveToken(loginData.token ?? "Token Tidak Ditemukan");

        // Navigasi ke halaman berikutnya
        Navigator.pushReplacementNamed(
            // ignore: use_build_context_synchronously
            context,
            "/wrapper");
      } else {
        // Jika login gagal
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email atau password salah."),
            backgroundColor: Warna.salah,
          ),
        );
        _loginData = null;
      }
    } catch (e) {
      // Error saat proses login
      setError(true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Terjadi kesalahan. Silakan coba lagi."),
          backgroundColor: Warna.salah,
        ),
      );
    } finally {
      setLoading(false);
      clear();
    }
  }

  void clear() {
    emailController.clear();
    passwordController.clear();
    _isLoading = false;
    _hasError = false;
    _loginData = null;
    notifyListeners();
  }
}
