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

  /// API
  List radios = [];
  bool isLoading = true;

  /// Audio
  final player = AudioPlayer();
  int currentIndex = -1;

  /// 🔊 حالة الصوت (GLOBAL)
  bool isMuted = false;

  @override
  void initState() {
    super.initState();
    fetchRadios();
  }

  Future<void> fetchRadios() async {
    final response = await http.get(
      Uri.parse("https://mp3quran.net/api/v3/radios?language=en"),
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
        Positioned.fill(
          child: Image.asset(AppImages.radioimg, fit: BoxFit.cover),
        ),

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

        SafeArea(
          child: Column(
            children: [
              const AppHeader(),
              const SizedBox(height: 20),

              /// Toggle
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
                              child: const Center(child: Text("Radio")),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = 1;
                                });
                              },
                              child: const Center(child: Text("Reciters")),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// List
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

  /// CARD
  Widget buildRadioCard({
    required String name,
    required String url,
    required int index,
  }) {
    bool isPlaying = currentIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: 390,
      height: 133,
      decoration: BoxDecoration(
        color: const Color(0xFFE2BE7F),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          /// BACKGROUND
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.asset(
                'assets/images/radioback.png',
                fit: BoxFit.cover,
                height: 90,
              ),
            ),
          ),

          /// CONTENT
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name.replaceFirst(RegExp('^Radio\\s+'), ''),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                /// ICONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// PLAY
                    IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 40,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        if (isPlaying) {
                          await player.stop();
                          setState(() {
                            currentIndex = -1;
                            isMuted = false;
                          });
                        } else {
                          await player.stop();
                          await player.setVolume(1);
                          await player.play(UrlSource(url));

                          setState(() {
                            currentIndex = index;
                            isMuted = false;
                          });
                        }
                      },
                    ),

                    /// SOUND - Always visible
                    IconButton(
                      icon: Icon(
                        isMuted ? Icons.volume_off : Icons.volume_up,
                        size: 28,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        if (!isPlaying) return;

                        if (isMuted) {
                          await player.setVolume(1);
                          setState(() {
                            isMuted = false;
                          });
                        } else {
                          await player.setVolume(0);
                          setState(() {
                            isMuted = true;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
