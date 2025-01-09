import 'package:flutter/material.dart';
import 'package:learn_lingo/core/theme/color_primary.dart';
import 'package:learn_lingo/core/theme/typography.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Warna.primary3,
        iconTheme: const IconThemeData(color: Warna.primary1),
        title: Tipografi().s1(isiText: 'About Page', warnaFont: Warna.primary1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                  width: 100,
                  height: 100,
                  child: Image(
                    image: AssetImage(
                        "assets/images/465069695_9088934884464160_6872327217032702338_n-removebg-preview.png"),
                    fit: BoxFit.fill,
                  )),
              const SizedBox(height: 15),
              Tipografi().b1(isiText: """
Welcome to English Class, an innovative English learning app developed specifically for SMP Negeri 1 Karangreja. The app combines interactive lessons, fun challenges and gamified experiences to help students master English vocabulary, grammar, speaking and listening skills. Designed to align with the school curriculum, English Calss provides a personalized learning journey for each student, ensuring progress is at their own pace.Earn points, unlock achievements and enjoy learning English like never before! With a focus on real-life communication and engaging activities, this app is here to make learning English interesting and effective. English Class was created by Aden Hidayatuloh and Farhan Fadillah, dedicated students and developers who collaborated with SMP Negeri 1 Karangreja to realize this project. Their mission is to support students in achieving their language goals with confidence and enthusiasm. Let's learn and grow together with the English Class App-a step forward in modern education for SMP Negeri 1 Karangreja!
              """, warnaFont: Warna.netral1, textAlign: TextAlign.justify),
            ],
          ),
        ),
      ),
    );
  }
}
