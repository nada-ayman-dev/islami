import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:islami/core/constants/app_images.dart';
import 'package:islami/core/widgets/app_header.dart';

class RadioView extends StatefulWidget {
  const RadioView({super.key});

  @override
  State<RadioView> createState() => _RadioViewState();
}

class _RadioViewState extends State<RadioView> {
  int selectedIndex = 0;

  /// 👇 API
  List radios = [];
  bool isLoading = true;

  /// 👇 الصوت
  final player = AudioPlayer();
  int currentIndex = -1;

  @override
  void initState() {
    super.initState();
    fetchRadios();
  }

  Future<void> fetchRadios() async {
    final response = await http.get(
      Uri.parse("https://mp3quran.net/api/v3/radios?language=ar"),
    );

    final data = jsonDecode(response.body);

    setState(() {
      radios = data["radios"];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// الخلفية
        Positioned.fill(
          child: Image.asset(AppImages.radioimg, fit: BoxFit.cover),
        ),

        /// gradient
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromRGBO(32, 32, 32, 0.7), Color(0xFF202020)],
              ),
            ),
          ),
        ),

        /// المحتوى
        SafeArea(
          child: Column(
            children: [
              const AppHeader(),
              const SizedBox(height: 20),

              /// 👇 التوجل
              Center(
                child: Container(
                  width: 390,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xB2202020),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 300),
                        left: selectedIndex == 0 ? 0 : 195,
                        child: Container(
                          width: 195,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2BE7F),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = 0;
                                });
                              },
                              child: Center(
                                child: Text(
                                  "Radio",
                                  style: TextStyle(
                                    color:
                                        selectedIndex == 0
                                            ? Colors.black
                                            : Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = 1;
                                });
                              },
                              child: Center(
                                child: Text(
                                  "Reciters",
                                  style: TextStyle(
                                    color:
                                        selectedIndex == 1
                                            ? Colors.black
                                            : Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// 👇 الليستة
              Expanded(
                child:
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                          itemCount: radios.length,
                          itemBuilder: (context, index) {
                            final radio = radios[index];

                            return buildRadioCard(
                              name: radio["name"],
                              url: radio["url"],
                              index: index,
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 👇 كارت الراديو
  Widget buildRadioCard({
    required String name,
    required String url,
    required int index,
  }) {
    bool isPlaying = currentIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: 390,
      height: 141,
      decoration: BoxDecoration(
        color: const Color(0xB2202020),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// اسم القارئ
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          /// زرار التشغيل
          IconButton(
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              size: 40,
              color: const Color(0xFFE2BE7F),
            ),
            onPressed: () async {
              if (isPlaying) {
                await player.stop();
                setState(() {
                  currentIndex = -1;
                });
              } else {
                await player.stop(); // يقفل القديم
                await player.play(UrlSource(url));

                setState(() {
                  currentIndex = index;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
