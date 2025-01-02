import 'package:learn_lingo/core/theme/color_primary.dart';
import 'package:learn_lingo/features/Login/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget textArea(
      {required TextEditingController editingController,
      bool keamanan = false,
      required Icon iconIsi,
      IconButton? iconBelakang,
      required String textIsi}) {
    return TextFormField(
        controller: editingController,
        obscureText: keamanan,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Warna.primary4)),
            floatingLabelStyle: const TextStyle(color: Warna.primary4),
            alignLabelWithHint: true,
            prefixIcon: iconIsi,
            prefixIconColor: Warna.primary4,
            suffixIcon: iconBelakang,
            labelText: textIsi,
            labelStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16.0,
                fontWeight: FontWeight.w500),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginProvider>(
        builder: (context, loginProvider, _) {
          return SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 56.0),
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
                        width: 178,
                        child: Image(
                          image: AssetImage("assets/images/rafiki.png"),
                          fit: BoxFit.fill,
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    textArea(
                        editingController: loginProvider.emailController,
                        iconIsi: const Icon(Icons.email),
                        textIsi: "Email"),
                    const SizedBox(
                      height: 15,
                    ),
                    textArea(
                        editingController: loginProvider.passwordController,
                        iconIsi: const Icon(Icons.key),
                        keamanan: loginProvider.keamananPass,
                        textIsi: "Password",
                        iconBelakang: IconButton(
                            onPressed: () {
                              setState(() {
                                loginProvider.toggleKeamananPass();
                              });
                            },
                            icon: Icon(loginProvider.keamananPass
                                ? Icons.remove_red_eye
                                : Icons.visibility_off))),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/generate-otp');
                          },
                          child: const Text(
                            "Lupa Password?",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 14,
                                color: Warna.primary4,
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (loginProvider.isLoading)
                      const CircularProgressIndicator()
                    else
                      ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Warna.primary3),
                            fixedSize: WidgetStatePropertyAll(
                                Size(double.maxFinite, 51))),
                        onPressed: () {
                          final email = loginProvider.emailController.text;
                          final password =
                              loginProvider.passwordController.text;
                          Provider.of<LoginProvider>(context, listen: false)
                              .login(context, email, password);
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              color: Warna.primary1,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    if (loginProvider.hasError)
                      const Text("Login failed",
                          style: TextStyle(color: Colors.red)),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Belum Punya Akun?",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              color: Warna.netral1,
                              fontWeight: FontWeight.w500),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/register');
                            },
                            child: const Text(
                              "Daftar",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color: Warna.primary4,
                                  fontWeight: FontWeight.w500),
                            )),
                      ],
                    )
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
