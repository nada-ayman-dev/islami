import 'package:flutter/material.dart';

class SoundWave extends StatefulWidget {
  const SoundWave({super.key});

  @override
  State<SoundWave> createState() => _SoundWaveState();
}

class _SoundWaveState extends State<SoundWave>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget bar(double h) {
    return Expanded(
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          return Center(
            child: Container(
              width: 1.5,
              height: (h * controller.value) + 10,
              margin: const EdgeInsets.symmetric(horizontal: 1),
              color: Colors.black,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        bar(30),
        bar(50),
        bar(25),
        bar(60),
        bar(35),
        bar(45),
        bar(55),
        bar(30),
        bar(40),
        bar(50),
        bar(20),
        bar(35),
        bar(45),
        bar(28),
        bar(52),
        bar(38),
        bar(48),
        bar(32),
        bar(58),
        bar(25),
        bar(42),
        bar(36),
        bar(46),
        bar(29),
        bar(54),
        bar(33),
        bar(44),
        bar(26),
        bar(51),
        bar(39),
        bar(49),
        bar(23),
        bar(37),
        bar(47),
        bar(31),
        bar(56),
        bar(27),
        bar(43),
        bar(34),
        bar(53),
        bar(41),
        bar(24),
        bar(52),
        bar(38),
        bar(57),
      ],
    );
  }
}
