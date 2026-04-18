import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:islami/core/constants/app_colors.dart';
import 'package:islami/core/constants/app_images.dart';
import 'package:islami/core/widgets/app_header.dart';
import 'services/radio_service.dart';
import 'widgets/radio_card.dart';

class RadioView extends StatefulWidget {
  const RadioView({super.key});

  @override
  State<RadioView> createState() => _RadioViewState();
}

class _RadioViewState extends State<RadioView> {
  int selectedIndex = 0;

  List radios = [];
  bool isLoading = true;

  final player = AudioPlayer();
  int currentIndex = -1;

  bool isMuted = false;

  /// reciter playlist
  List<String> suras = List.generate(
    114,
    (i) => "${(i + 1).toString().padLeft(3, '0')}.mp3",
  );

  int currentSuraIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadRadios();
  }

  Future<void> _loadRadios() async {
    setState(() => isLoading = true);
    final data = await RadioService.fetchRadios();
    setState(() {
      radios = data;
      isLoading = false;
    });
  }

  Future<void> _loadReciters() async {
    setState(() => isLoading = true);
    final data = await RadioService.fetchReciters();
    setState(() {
      radios = data;
      isLoading = false;
    });
  }

  /// Play reciter (all suras)
  Future<void> playReciter(String server, int index) async {
    setState(() {
      currentIndex = index;
      currentSuraIndex = 0;
    });

    await player.stop();
    await player.setVolume(1);

    playNextSura(server);
  }

  void playNextSura(String server) async {
    if (currentSuraIndex >= suras.length) return;

    String url = server + suras[currentSuraIndex];

    await player.play(UrlSource(url));

    player.onPlayerComplete.listen((event) {
      currentSuraIndex++;
      playNextSura(server);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// background
        Positioned.fill(
          child: Image.asset(AppImages.radioimg, fit: BoxFit.cover),
        ),

        Positioned.fill(child: Container(color: const Color(0xCC202020))),

        SafeArea(
          child: Column(
            children: [
              const AppHeader(),
              const SizedBox(height: 20),

              /// toggle
              Center(
                child: Container(
                  width: 390,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.darkBackgroundWithOpacity,
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
                            color: AppColors.gold,
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
                                _loadRadios();
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
                                _loadReciters();
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

              /// list
              Expanded(
                child:
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                          itemCount: radios.length,
                          itemBuilder: (context, index) {
                            final item = radios[index];

                            return RadioCard(
                              item: item,
                              index: index,
                              isPlaying: currentIndex == index,
                              selectedIndex: selectedIndex,
                              isMuted: isMuted,
                              player: player,
                              onPlayRadio: (url) async {
                                await player.play(UrlSource(url));
                                setState(() => currentIndex = index);
                              },
                              onStopRadio: () async {
                                await player.stop();
                                setState(() => currentIndex = -1);
                              },
                              onPlayReciter: () {
                                final server =
                                    (item["moshaf"] != null &&
                                            item["moshaf"].isNotEmpty)
                                        ? item["moshaf"][0]["server"]
                                        : "";
                                playReciter(server, index);
                              },
                              onToggleMute: () async {
                                if (isMuted) {
                                  await player.setVolume(1);
                                } else {
                                  await player.setVolume(0);
                                }
                                setState(() => isMuted = !isMuted);
                              },
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
}
