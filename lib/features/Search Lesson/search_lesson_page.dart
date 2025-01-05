import 'package:flutter/material.dart';
import 'package:learn_lingo/core/theme/button_app.dart';
import 'package:learn_lingo/core/theme/color_primary.dart';
import 'package:learn_lingo/core/theme/text_filed.dart';
import 'package:learn_lingo/core/theme/typography.dart';
import 'package:learn_lingo/features/Search%20Lesson/search_lesson_provider.dart';
import 'package:provider/provider.dart';

class SearchLessonPage extends StatefulWidget {
  const SearchLessonPage({super.key});

  @override
  State<SearchLessonPage> createState() => _SearchLessonPageState();
}

class _SearchLessonPageState extends State<SearchLessonPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SearchLessonProvider>(context, listen: false)
          .fetchInitialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Tipografi().h6(
          isiText: "Search Lesson",
          warnaFont: Warna.primary1,
        ),
        backgroundColor: Warna.primary3,
        iconTheme: const IconThemeData(color: Warna.primary1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<SearchLessonProvider>(
            builder: (context, searchLessonProvider, child) {
              if (searchLessonProvider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final lessons = searchLessonProvider.searchLessonApi?.data ?? [];

              return Column(
                children: [
                  _buildRowSearchField(context),
                  const SizedBox(height: 20),
                  if (lessons.isEmpty)
                    const Center(
                      child: Text("Enter a keyword to search for lessons"),
                    )
                  else
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: lessons.length,
                        itemBuilder: (context, index) {
                          final lesson = lessons[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/lesson',
                                  arguments: lesson.id);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20.0),
                              margin: const EdgeInsets.only(bottom: 15.0),
                              decoration: BoxDecoration(
                                color: Warna.primary1,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2.0,
                                    offset: const Offset(0, 2),
                                    color: Warna.netral1.withOpacity(0.07),
                                  ),
                                  BoxShadow(
                                    blurRadius: 1.0,
                                    offset: const Offset(0, 3),
                                    color: Warna.netral1.withOpacity(0.06),
                                  ),
                                  BoxShadow(
                                    blurRadius: 10.0,
                                    offset: const Offset(0, 1),
                                    color: Warna.netral1.withOpacity(0.1),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset("assets/images/Rectangle 131.png",
                                      width: 100),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Tipografi().s1(
                                          isiText: lesson.name ?? '',
                                          warnaFont: Warna.netral1,
                                        ),
                                        const SizedBox(height: 5.0),
                                        Tipografi().C(
                                          isiText: lesson.description ?? '',
                                          warnaFont: Warna.netral4,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Row _buildRowSearchField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildSearchField(context),
        ),
        const SizedBox(width: 10),
        Tombol().primaryLarge(
          teksTombol: "Search",
          lebarTombol: MediaQuery.of(context).size.width * 0.3,
          navigasiTombol: () {
            final provider =
                Provider.of<SearchLessonProvider>(context, listen: false);
            if (provider.searchController.text.trim().isEmpty) {
              provider.setErrorMessage("Enter a keyword to search for lessons");
              return;
            }
            provider.searchQuery(provider.searchController.text);
          },
        ),
      ],
    );
  }

  Widget _buildSearchField(BuildContext context) {
    final searchController =
        Provider.of<SearchLessonProvider>(context, listen: false)
            .searchController;
    return AreaTeks().normal(
      editingController: searchController,
      keamanan: false,
      textIsi: "Search Lesson",
      iconIsi: const Icon(Icons.search),
    );
  }
}
