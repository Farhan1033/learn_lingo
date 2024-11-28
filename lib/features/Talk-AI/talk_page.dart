import 'package:learn_lingo/core/theme/color_primary.dart';
import 'package:learn_lingo/core/theme/typography.dart';
import 'package:learn_lingo/features/Talk-AI/talk_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TalkPage extends StatefulWidget {
  const TalkPage({super.key});

  @override
  State<TalkPage> createState() => _TalkPageState();
}

class _TalkPageState extends State<TalkPage> {
  @override
  void initState() {
    super.initState();
    final talkProvider = Provider.of<TalkProvider>(context, listen: false);
    talkProvider.initializeSpeech();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Warna.primary3,
        iconTheme: const IconThemeData(color: Warna.primary1),
        title:
            Tipografi().s1(isiText: 'Talk With AI', warnaFont: Warna.primary1),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
        child: Consumer<TalkProvider>(
          builder: (context, talkProvider, _) {
            return Column(
              children: [
                ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      if (talkProvider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return messageBox(context, talkProvider.resultAiWord,
                          CrossAxisAlignment.start, 'Gen-AI');
                    } else if (index == 1) {
                      return messageBox(context, talkProvider.lastWords,
                          CrossAxisAlignment.end, 'Me');
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildCircleButton(
                      context,
                      icon: Icons.restart_alt,
                      size: 25,
                      tinggi: 0.15,
                      lebar: 0.15,
                      onPressed: talkProvider.reset,
                    ),
                    _buildCircleButton(context,
                        icon: talkProvider.isListening
                            ? Icons.mic
                            : Icons.mic_off,
                        size: 25,
                        tinggi: 0.15,
                        lebar: 0.15, onPressed: () {
                      if (talkProvider.isListening) {
                        talkProvider.startListening();
                      } else {
                        talkProvider.stopListening();
                      }
                    }),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCircleButton(
    BuildContext context, {
    required IconData icon,
    required double size,
    required VoidCallback onPressed,
    required double tinggi,
    required double lebar,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * lebar,
      height: MediaQuery.of(context).size.width * tinggi,
      decoration: const BoxDecoration(
        color: Warna.primary3,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, size: size, color: Warna.primary1),
        onPressed: onPressed,
      ),
    );
  }

  Widget messageBox(BuildContext context, String chat, CrossAxisAlignment align,
      String person) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Warna.primary1,
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            offset: const Offset(0, 2),
            spreadRadius: 0.0,
            color: Warna.netral1.withOpacity(0.07),
          ),
          BoxShadow(
            blurRadius: 1.0,
            offset: const Offset(0, 3),
            spreadRadius: 0.0,
            color: Warna.netral1.withOpacity(0.06),
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
        crossAxisAlignment: align,
        children: [
          Tipografi().s1(isiText: person, warnaFont: Warna.netral1),
          Tipografi().b2(isiText: chat, warnaFont: Warna.netral1),
        ],
      ),
    );
  }
}
