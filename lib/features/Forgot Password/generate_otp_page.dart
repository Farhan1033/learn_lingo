import 'package:flutter/material.dart';
import 'package:learn_lingo/core/theme/button_app.dart';
import 'package:learn_lingo/core/theme/color_primary.dart';
import 'package:learn_lingo/core/theme/text_filed.dart';
import 'package:learn_lingo/core/theme/typography.dart';
import 'package:learn_lingo/features/Forgot%20Password/generate_otp_provider.dart';
import 'package:provider/provider.dart';

class GenerateOtpPage extends StatelessWidget {
  const GenerateOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GenerateOtpProvider>(
        builder: (context, generateOtpProvider, child) {
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
                      image: AssetImage("assets/images/rafiki1.png"),
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
                        isiText:
                            "Please enter your email address. We will send you an email to reset your password.",
                        warnaFont: Warna.netral1),
                    const SizedBox(
                      height: 15,
                    ),
                    AreaTeks().normal(
                      editingController: generateOtpProvider.emailController,
                      keamanan: false,
                      iconIsi: const Icon(Icons.email),
                      textIsi: "Email",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Tombol().primaryLarge(
                      navigasiTombol: () async {
                        generateOtpProvider.generateOtp(
                            context, generateOtpProvider.emailController.text);
                      },
                      teksTombol: "Send Email",
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
