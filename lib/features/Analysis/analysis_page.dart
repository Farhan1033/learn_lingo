import 'package:learn_lingo/core/models/analysis_detail_api.dart';
import 'package:learn_lingo/core/theme/color_primary.dart';
import 'package:learn_lingo/core/theme/typography.dart';
import 'package:learn_lingo/features/Analysis/analysis_detail_provider.dart';
import 'package:learn_lingo/features/Home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().gamifikasi();
      context.read<AnalysisDetailProvider>().analysisDetail();
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [_buildConsumerAnalysisDetail()],
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: Warna.primary3,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          _buildUserProfileRow(),
        ],
      ),
    );
  }

  Widget _buildUserProfileRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildProfilePicture(),
            const SizedBox(width: 20),
            const Column(
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
                  "Morgan Breum!",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20,
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
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        image:
            DecorationImage(image: AssetImage("assets/images/Ellipse 8.png")),
      ),
    );
  }

  Consumer<AnalysisDetailProvider> _buildConsumerAnalysisDetail() {
    return Consumer<AnalysisDetailProvider>(
      builder: (context, analysisDetailProvider, _) {
        if (analysisDetailProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (analysisDetailProvider.hasError) {
          return const Center(child: Text('Database not found!'));
        }
        if (analysisDetailProvider.analysisDetailApi == null) {
          return const Center(child: Text('Data not found!'));
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: analysisDetailProvider.analysisDetailApi!.data!.length,
          itemBuilder: (context, index) {
            final item = analysisDetailProvider.analysisDetailApi!.data![index];
            final imagePaths = [
              'assets/images/Component 1.png',
              'assets/images/Property 1=Writting.png',
              'assets/images/Property 1=Listening.png',
              'assets/images/Property 1=Reading.png',
            ];
            if (index < imagePaths.length) {
              return _buildAnalysisCategory(context, item, imagePaths[index]);
            } else {
              return const SizedBox.shrink();
            }
          },
        );
      },
    );
  }

  Widget _buildAnalysisCategory(
      BuildContext context, Data item, String imageCourse) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Warna.primary1,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            offset: const Offset(0, 2),
            spreadRadius: 0.0,
            color: Warna.netral1.withOpacity(0.07),
          ),
          BoxShadow(
            blurRadius: 10.0,
            offset: const Offset(0, 1),
            spreadRadius: 0.0,
            color: Warna.netral1.withOpacity(0.1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRowContent(context, item, imageCourse),
          const SizedBox(height: 10),
          Tipografi().s1(isiText: 'Skill Level', warnaFont: Warna.netral1),
          const SizedBox(height: 5),
          _buildColumnSkillLevel(context, item.progress ?? []),
        ],
      ),
    );
  }

  Widget _buildRowContent(
      BuildContext context, Data analysis, String imageCourse) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.width * 0.2,
          child: Image.asset(imageCourse, fit: BoxFit.contain),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Tipografi()
                  .h6(isiText: analysis.course ?? '', warnaFont: Warna.netral1),
              const SizedBox(height: 5),
              Tipografi().b2(
                  isiText: analysis.description ?? '',
                  warnaFont: Warna.netral1),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColumnSkillLevel(
      BuildContext context, List<Progress> progressList) {
    return Column(
      children: progressList.map((item) {
        return _buildSkillLevel(
            context, item.category ?? '', item.progressPercentage ?? 0);
      }).toList(),
    );
  }

  Widget _buildSkillLevel(
      BuildContext context, String category, int progressPercentage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Tipografi().b2(isiText: category, warnaFont: Warna.netral1),
              Tipografi().b2(
                  isiText: '${progressPercentage.toString()}%',
                  warnaFont: Warna.netral1),
            ],
          ),
          const SizedBox(height: 5),
          LinearPercentIndicator(
            padding: EdgeInsets.zero,
            barRadius: const Radius.circular(8),
            lineHeight: 6.0,
            percent: progressPercentage / 100,
            progressColor: Warna.primary4,
            backgroundColor: Warna.primary2,
          ),
        ],
      ),
    );
  }
}
