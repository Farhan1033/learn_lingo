import 'package:learn_lingo/core/theme/button_app.dart';
import 'package:learn_lingo/core/theme/color_primary.dart';
import 'package:learn_lingo/core/theme/text_filed.dart';
import 'package:learn_lingo/core/theme/typography.dart';
import 'package:learn_lingo/features/Register/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RegisterProvider>(builder: (context, registerProvider, _) {
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
                  Tipografi().h6(
                      isiText: "Sign up with email",
                      warnaFont: Warna.netral1,
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 15,
                  ),
                  Tipografi().b1(
                      isiText:
                          "Create your account and join us on this exciting journey!",
                      warnaFont: Warna.netral1,
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 15,
                  ),
                  AreaTeks().normal(
                    editingController: registerProvider.namaController,
                    keamanan: false,
                    iconIsi: const Icon(Icons.person),
                    textIsi: "Full Name",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AreaTeks().normal(
                    editingController: registerProvider.emailController,
                    keamanan: false,
                    iconIsi: const Icon(Icons.email),
                    textIsi: "Email",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AreaTeks().normal(
                      editingController: registerProvider.passwordController,
                      keamanan: registerProvider.keamananPass,
                      iconIsi: const Icon(Icons.key),
                      textIsi: "Password",
                      iconBelakang: IconButton(
                          onPressed: () {
                            registerProvider.toggleKeamananPass();
                          },
                          icon: Icon(registerProvider.keamananPass
                              ? Icons.remove_red_eye
                              : Icons.visibility_off))),
                  const SizedBox(
                    height: 15,
                  ),
                  AreaTeks().normal(
                      editingController:
                          registerProvider.confPasswordController,
                      keamanan: registerProvider.keamananConfPass,
                      iconIsi: const Icon(Icons.key),
                      textIsi: "Confirm Password",
                      iconBelakang: IconButton(
                          onPressed: () {
                            registerProvider.toggleKeamananConfPass();
                          },
                          icon: Icon(registerProvider.keamananConfPass
                              ? Icons.remove_red_eye
                              : Icons.visibility_off))),
                  const SizedBox(
                    height: 15,
                  ),
                  Tombol().primaryLarge(
                    teksTombol: "Register",
                    lebarTombol: double.maxFinite,
                    navigasiTombol: () {
                      registerProvider.register(
                          context,
                          registerProvider.emailController.text,
                          registerProvider.passwordController.text,
                          registerProvider.namaController.text);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Tipografi().s2(
                          isiText: "Already have an account?",
                          warnaFont: Warna.netral1),
                      Tombol().TextLarge(
                        teksTombol: "Login",
                        lebarTombol: double.infinity,
                        navigasiTombol: () {
                          registerProvider.moveLogin(context);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
