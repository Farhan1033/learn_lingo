import 'package:flutter/material.dart';
import 'package:learn_lingo/core/theme/button_app.dart';
import 'package:learn_lingo/core/theme/color_primary.dart';
import 'package:learn_lingo/core/theme/text_filed.dart';
import 'package:learn_lingo/core/theme/typography.dart';
import 'package:learn_lingo/features/Forgot%20Password/forgot_password_provider.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ForgotPasswordProvider>(
        builder: (context, forgotPasswordProvider, child) {
          return SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 56.0, horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                        width: 178,
                        height: 57,
                        child: Image(
                          image: AssetImage("assets/images/LearnLingo.png"),
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                        child: Image(
                      image: AssetImage("assets/images/rafiki3.png"),
                      fit: BoxFit.cover,
                    )),
                    const SizedBox(
                      height: 15,
                    ),
                    Tipografi().s1(
                        isiText: "Reset Password", warnaFont: Warna.netral1),
                    const SizedBox(
                      height: 15,
                    ),
                    Tipografi().b2(
                        isiText: "Please enter your new password.",
                        warnaFont: Warna.netral1),
                    const SizedBox(
                      height: 15,
                    ),
                    AreaTeks().normal(
                      editingController:
                          forgotPasswordProvider.codeVerifyController,
                      keamanan: false,
                      iconIsi: const Icon(Icons.lock),
                      textIsi: "OTP Code",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AreaTeks().normal(
                      editingController:
                          forgotPasswordProvider.newPasswordController,
                      keamanan: false,
                      iconIsi: const Icon(Icons.key),
                      textIsi: "New Password",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Tombol().primaryLarge(
                      navigasiTombol: () async {
                        forgotPasswordProvider.forgotPassword(
                            context,
                            forgotPasswordProvider.codeVerifyController.text,
                            forgotPasswordProvider.newPasswordController.text);
                      },
                      teksTombol: "Change Password",
                      lebarTombol: double.maxFinite,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
