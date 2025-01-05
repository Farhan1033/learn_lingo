import 'package:learn_lingo/core/theme/color_primary.dart';
import 'package:learn_lingo/core/theme/typography.dart';
import 'package:learn_lingo/features/Course/course_provider.dart';
import 'package:learn_lingo/features/Home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).gamifikasi();
      Provider.of<HomeProvider>(context, listen: false).progressLesson();
      final course = Provider.of<CourseProvider>(context, listen: false);
      course.fetchCourse(course.categoryForApi ?? "beginner");
    });
    return Scaffold(
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, _) {
          if (homeProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (homeProvider.hasError != false) {
            return const Center(
              child: Text('Data not valid'),
            );
          }
          if (homeProvider.gamifikasiApi == null) {
            return const Center(
              child: Text('Data not found!'),
            );
          }
          final home = homeProvider.gamifikasiApi!;
          final progress = homeProvider.progressApi;
          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 2));
              homeProvider.gamifikasi();
              homeProvider.progressLesson();
            },
            child: SingleChildScrollView(
                child: Column(
              children: [
                _buildHeader(
                  context,
                  home.level.toString(),
                  home.totalPoints.toString(),
                  (home.currentExp! / home.nextLevelExp!).toDouble(),
                  progress?.lesson ?? '',
                  progress?.status ?? '',
                  (progress?.progressPercentage ?? 0).toDouble(),
                ),
                _buildContent(context),
              ],
            )),
          );
        },
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    String level,
    String poin,
    double progress,
    String title,
    String label,
    double percentProgress,
  ) {
    return Container(
      color: Warna.primary3,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
      child: Column(
        children: [
          _buildLevelAndCurrencyRow(context, level, poin, progress),
          const SizedBox(
            height: 30,
          ),
          _buildUserProfileRow(),
          const SizedBox(
            height: 30,
          ),
          _buildOngoingCourseCard(context, title, label, percentProgress)
        ],
      ),
    );
  }

  Widget _buildLevelAndCurrencyRow(
      BuildContext context, String level, String poin, double progress) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLevelIndicator(level, progress),
        Row(
          children: [
            _buildCurrencyBox(poin),
            const SizedBox(
              width: 10,
            ),
            _buildSearchButton(context),
          ],
        )
      ],
    );
  }

  Widget _buildLevelIndicator(String level, double progress) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Warna.primary1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Tipografi().s2(isiText: 'Level $level', warnaFont: Warna.netral1),
          const SizedBox(
            height: 5,
          ),
          LinearPercentIndicator(
            padding: EdgeInsets.zero,
            barRadius: const Radius.circular(8),
            lineHeight: 6.0,
            percent: (progress * 100) / 100,
            width: 84,
            progressColor: Warna.primary4,
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyBox(String poin) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      child: Row(
        children: [
          Image.asset('assets/images/Group 137.png'),
          const SizedBox(
            width: 5,
          ),
          Tipografi().s2(isiText: poin, warnaFont: Warna.netral1)
        ],
      ),
    );
  }

  Widget _buildSearchButton(BuildContext context) {
    return IconButton(
        style: const ButtonStyle(
            fixedSize: WidgetStatePropertyAll(Size(46, 46)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)))),
            backgroundColor: WidgetStatePropertyAll(Warna.primary1)),
        onPressed: () {
          Navigator.pushNamed(context, '/search-lesson');
        },
        icon: const Icon(
          Icons.search_outlined,
          color: Warna.primary3,
        ));
  }

  Widget _buildUserProfileRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildProfilePicture(),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      color: Warna.primary1),
                ),
                Text(
                  'Nice to meet you!',
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      color: Warna.primary1),
                ),
              ],
            ),
          ],
        ),
        Image.asset("assets/images/ilus_1.png", width: 71, height: 74.27),
      ],
    );
  }

  Widget _buildProfilePicture() {
    return Container(
      height: 62,
      width: 62,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
            color: Warna.primary4, width: 2, style: BorderStyle.solid),
        image: const DecorationImage(
            image: AssetImage("assets/images/profile.png"),
            fit: BoxFit.contain),
      ),
    );
  }

  Widget _buildOngoingCourseCard(BuildContext context, String title,
      String label, double percentProgress) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Warna.primary1,
        boxShadow: [
          BoxShadow(
              blurRadius: 10,
              offset: const Offset(1, 0),
              color: Warna.netral1.withOpacity(0.1))
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isSmallScreen = constraints.maxWidth < 600;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isSmallScreen) ...[
                _buildCourseImage("assets/images/lesson.png"),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildOngoingLabel(label),
                      const SizedBox(height: 5.0),
                      Tipografi().s2(
                          isiText: percentProgress == 0
                              ? "You haven't started the course"
                              : title,
                          warnaFont: Warna.netral1,
                          oververFlow: TextOverflow.ellipsis,
                          maxLines: 2)
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                _buildCircularProgressIndicator(percentProgress),
              ] else ...[
                Row(
                  children: [
                    _buildCourseImage("assets/images/lesson.png"),
                    const SizedBox(width: 20),
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildOngoingLabel(label),
                          const SizedBox(height: 5.0),
                          Tipografi().s2(
                              isiText: percentProgress == 0
                                  ? "You haven't started the course"
                                  : title,
                              warnaFont: Warna.netral1,
                              oververFlow: TextOverflow.ellipsis,
                              maxLines: 2)
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: _buildCircularProgressIndicator(percentProgress),
                    ),
                  ],
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildOngoingLabel(String label) {
    return Container(
      height: 22,
      width: 100,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: _getColorBasedOnStatus(label),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Tipografi().C(
        isiText: label,
        warnaFont: Warna.primary1,
      ),
    );
  }

  Color _getColorBasedOnStatus(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Warna.benar;
      case 'ongoing':
        return Warna.ongoing;
      case 'failed':
        return Warna.salah;
      default:
        return Warna.primary1;
    }
  }

  Widget _buildCourseImage(String imagePath) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Warna.primary1,
        image: DecorationImage(image: AssetImage(imagePath)),
        boxShadow: [
          BoxShadow(
              blurRadius: 4.0,
              offset: const Offset(0, 2),
              color: Warna.netral1.withOpacity(0.2))
        ],
      ),
    );
  }

  Widget _buildCircularProgressIndicator(double percentProgress) {
    return CircularPercentIndicator(
      radius: 30.0,
      lineWidth: 6.5,
      percent: percentProgress / 100,
      reverse: true,
      center: Tipografi()
          .C(isiText: percentProgress.toString(), warnaFont: Warna.netral1),
      progressColor: Warna.primary3,
      backgroundColor: Warna.primary2,
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _buildSearchField(),
          // const SizedBox(height: 30),
          _buildLearningChoices(context),
          // const SizedBox(height: 10),
          // _buildChoiceAI(context),
          const SizedBox(height: 30),
          const Text(
            "Recommend For You",
            style: TextStyle(
                fontFamily: "Poppins", fontSize: 16, color: Warna.netral1),
          ),
          const SizedBox(height: 15),
          _buildRecommendationList(),
        ],
      ),
    );
  }

  Widget _buildLearningChoices(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Warna.primary1,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                blurRadius: 2.0,
                offset: const Offset(0, 2),
                spreadRadius: 0.0,
                color: Warna.netral1.withOpacity(0.07)),
            BoxShadow(
                blurRadius: 1.0,
                offset: const Offset(0, 3),
                spreadRadius: 0.0,
                color: Warna.netral1.withOpacity(0.06)),
            BoxShadow(
                blurRadius: 10.0,
                offset: const Offset(0, 1),
                spreadRadius: 0.0,
                color: Warna.netral1.withOpacity(0.1)),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Tipografi().s1(isiText: 'English Courses', warnaFont: Warna.netral1),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildChoiceBox(
                  context, "assets/images/Group 141.png", "Speaking", () {
                Navigator.pushNamed(context, '/speaking');
              }),
              _buildChoiceBox(
                  context, "assets/images/Group 149.png", "Check\nGrammar", () {
                Navigator.pushNamed(context, '/check-grammar');
              }),
              _buildChoiceBox(context, "assets/images/Group 148.png", "Chat AI",
                  () {
                Navigator.pushNamed(context, '/chat-ai');
              }),
              // _buildChoiceBox(
              //     context, "assets/images/Group 142.png", "Reading", () {}),
              // _buildChoiceBox(
              //     context, "assets/images/Group 143.png", "Writing", () {}),
              // _buildChoiceBox(
              //     context, "assets/images/Group 144.png", "Listening", () {}),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  // Widget _buildChoiceAI(BuildContext context) {
  //   final List<Map<String, String>> items = [
  //     {
  //       "image": "assets/images/Group 149.png",
  //       "text": "Check\nGrammar",
  //     },
  //     {
  //       "image": "assets/images/Group 148.png",
  //       "text": "Chat AI",
  //     },
  //   ];

  //   return GridView.builder(
  //     padding: const EdgeInsets.only(top: 10),
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 2,
  //       crossAxisSpacing: 10,
  //       mainAxisSpacing: 10,
  //       childAspectRatio: 3,
  //     ),
  //     itemCount: items.length,
  //     itemBuilder: (context, index) {
  //       if (index == 0) {
  //         return _buildIOnTapNavigatorAI(items, index, () {
  //           Navigator.pushNamed(context, '/check-grammar');
  //         });
  //       } else if (index == 1) {
  //         return _buildIOnTapNavigatorAI(items, index, () {
  //           Navigator.pushNamed(context, '/chat-ai');
  //         });
  //       } else {
  //         return Container();
  //       }
  //     },
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //   );
  // }

  // GestureDetector _buildIOnTapNavigatorAI(
  //     List<Map<String, String>> items, int index, VoidCallback navigatorAI) {
  //   return GestureDetector(
  //     onTap: navigatorAI,
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 10),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(8),
  //         color: Warna.primary1,
  //         boxShadow: [
  //           BoxShadow(
  //             blurRadius: 2.0,
  //             offset: const Offset(0, 2),
  //             spreadRadius: 0.0,
  //             color: Warna.netral1.withOpacity(0.07),
  //           ),
  //           BoxShadow(
  //             blurRadius: 1.0,
  //             offset: const Offset(0, 3),
  //             spreadRadius: 0.0,
  //             color: Warna.netral1.withOpacity(0.06),
  //           ),
  //           BoxShadow(
  //             blurRadius: 10.0,
  //             offset: const Offset(0, 1),
  //             spreadRadius: 0.0,
  //             color: Warna.netral1.withOpacity(0.1),
  //           ),
  //         ],
  //       ),
  //       child: Row(
  //         children: [
  //           SizedBox(
  //             width: 30,
  //             height: 30,
  //             child: Image.asset(items[index]["image"]!),
  //           ),
  //           const SizedBox(
  //             width: 5,
  //           ),
  //           Tipografi().s2(
  //             isiText: items[index]["text"]!,
  //             warnaFont: Warna.netral1,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildChoiceBox(BuildContext context, String imagePath, String label,
      VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          _buildCourseImage(imagePath),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
                fontFamily: "Poppins", fontSize: 14, color: Warna.netral1),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationList() {
    return Consumer<CourseProvider>(
      builder: (context, coursesProvider, _) {
        if (coursesProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (coursesProvider.errorMessage != null) {
          return const Center(
            child: Text('Database not found!'),
          );
        }
        if (coursesProvider.course == null) {
          return const Center(
            child: Text('Data not found!'),
          );
        }
        final course = coursesProvider.course!;
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: course.listLessons!.length,
            itemBuilder: (context, index) {
              final listCourse = course.listLessons![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/lesson',
                      arguments: listCourse.idLesson);
                },
                child: Container(
                  width: 237,
                  margin: const EdgeInsets.only(right: 12.0, bottom: 5.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Warna.primary1,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2.0,
                          offset: const Offset(0, 2),
                          spreadRadius: 0.0,
                          color: Warna.netral1.withOpacity(0.07)),
                      BoxShadow(
                          blurRadius: 1.0,
                          offset: const Offset(0, 3),
                          spreadRadius: 0.0,
                          color: Warna.netral1.withOpacity(0.06)),
                      BoxShadow(
                          blurRadius: 10.0,
                          offset: const Offset(0, 1),
                          spreadRadius: 0.0,
                          color: Warna.netral1.withOpacity(0.1)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 177,
                        width: 217,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/Rectangle 11.png"))),
                      ),
                      const SizedBox(height: 20.0),
                      Flexible(
                        child: _buildRecommendationHeader(
                            listCourse.lessonsName!, listCourse.description!),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildRecommendationHeader(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Tipografi().s1(isiText: title, warnaFont: Warna.netral1),
        const SizedBox(height: 5.0),
        Tipografi().b2(isiText: description, warnaFont: Warna.netral1),
      ],
    );
  }
}
