import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:islami/core/constants/app_colors.dart';
import 'package:islami/core/constants/app_images.dart';
import 'sound_wave.dart';

class RadioCard extends StatelessWidget {
  final Map item;
  final int index;
  final int selectedIndex;
  final bool isPlaying;
  final bool isMuted;
  final AudioPlayer player;
  final Function(String url) onPlayRadio;
  final Function() onStopRadio;
  final Function() onPlayReciter;
  final Function() onToggleMute;

  const RadioCard({
    super.key,
    required this.item,
    required this.index,
    required this.selectedIndex,
    required this.isPlaying,
    required this.isMuted,
    required this.player,
    required this.onPlayRadio,
    required this.onStopRadio,
    required this.onPlayReciter,
    required this.onToggleMute,
  });

  @override
  Widget build(BuildContext context) {
    String name = item["name"] ?? "";

    String url =
        selectedIndex == 0
            ? item["url"] ?? ""
            : (item["moshaf"] != null && item["moshaf"].isNotEmpty)
            ? item["moshaf"][0]["server"]
            : "";

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.gold,
      ),
      child: Stack(
        children: [
          /// Background image
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                isPlaying ? AppImages.soundWave : AppImages.radioback,
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// Overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black.withOpacity(0.35),
            ),
          ),

          /// Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  selectedIndex == 0 ? name : name.replaceFirst("Radio ", ""),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Play
                    IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 40,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        if (isPlaying) {
                          onStopRadio();
                        } else {
                          if (selectedIndex == 0) {
                            onPlayRadio(url);
                          } else {
                            onPlayReciter();
                          }
                        }
                      },
                    ),

                    /// Mute
                    IconButton(
                      icon: Icon(
                        isMuted ? Icons.volume_off : Icons.volume_up,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        if (isPlaying) {
                          onToggleMute();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// Sound wave
          if (isPlaying)
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 50,
              child: SoundWave(),
            ),
        ],
      ),
    );
  }
}
