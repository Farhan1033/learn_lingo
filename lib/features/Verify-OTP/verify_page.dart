import 'package:flutter/material.dart';
import 'package:learn_lingo/core/theme/button_app.dart';
import 'package:learn_lingo/core/theme/text_filed.dart';
import 'package:learn_lingo/core/theme/typography.dart';
import 'package:learn_lingo/features/Verify-OTP/verify_provider.dart';
import 'package:provider/provider.dart';

class VerifyPage extends StatelessWidget {
  const VerifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<VerifyProvider>(
      builder: (context, verifyProvider, _) {
        return SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 56.0, horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                      width: 100,
                      height: 100,
                      child: Image(
                        image: AssetImage(
                            "assets/images/465069695_9088934884464160_6872327217032702338_n-removebg-preview.png"),
                        fit: BoxFit.fill,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Tipografi().b1(
                      isiText: "Please input your OTP code",
                      warnaFont: Colors.black),
                  const SizedBox(
                    height: 15,
                  ),
                  AreaTeks().normal(
                    editingController: verifyProvider.codeVerifyController,
                    keamanan: false,
                    iconIsi: const Icon(Icons.lock_outline_rounded),
                    textIsi: "Code OTP",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Tombol().primaryLarge(
                    teksTombol: "Verification",
                    lebarTombol: double.maxFinite,
                    navigasiTombol: () {
                      verifyProvider.verifyOTP(
                          context, verifyProvider.codeVerifyController.text);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
