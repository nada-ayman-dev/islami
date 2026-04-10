import 'package:flutter/material.dart';
import 'package:islami/core/constants/app_images.dart';

class SebhaView extends StatefulWidget {
  const SebhaView({super.key});

  @override
  State<SebhaView> createState() => _SebhaViewState();
}

class _SebhaViewState extends State<SebhaView> {
  final List<Map<String, dynamic>> azkar = [
    {"text": "سبحان الله", "count": 33},
    {"text": "الحمد لله", "count": 33},
    {"text": "الله أكبر", "count": 34},
  ];

  int index = 0;
  int count = 0;

  String get currentZekr => azkar[index]["text"];
  int get maxCount => azkar[index]["count"];

  void increment() {
    setState(() {
      count++;

      if (count >= maxCount) {
        count = 0;
        index++;

        if (index >= azkar.length) {
          index = 0;
        }
      }
    });
  }

  void reset() {
    setState(() {
      count = 0;
      index = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.sebhabackg),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              const Color.fromRGBO(0, 0, 0, 0.45),
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Text(
              'Islami',
              style: TextStyle(
                fontFamily: 'Janna LT',
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: const Color.fromRGBO(255, 255, 255, 0.95),
                shadows: [
                  const Shadow(
                    color: Color.fromRGBO(0, 0, 0, 0.35),
                    offset: Offset(0, 3),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'سبِّح اسمَ رَبِّكَ الأَعْلَى',
              style: TextStyle(
                fontFamily: 'Janna LT',
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: increment,
                  child: SizedBox(
                    width: 320,
                    height: 340,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Image.asset(AppImages.SebhaBody, width: 320),
                        Positioned(
                          top: -10,
                          child: Image.asset(AppImages.SebhaHead, width: 120),
                        ),
                        Positioned(
                          top: 28,
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 255, 255, 0.15),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color.fromRGBO(
                                  255,
                                  255,
                                  255,
                                  0.35,
                                ),
                                width: 1.5,
                              ),
                            ),
                            child: const Icon(
                              Icons.touch_app,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 140,
                          child: Column(
                            children: [
                              Text(
                                currentZekr,
                                style: const TextStyle(
                                  fontFamily: 'Janna LT',
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                width: 120,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 0,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(
                                    255,
                                    255,
                                    255,
                                    0.12,
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Text(
                                  '$count',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: 'Janna LT',
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: reset,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(255, 255, 255, 0.18),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 34,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                  side: const BorderSide(
                    color: Color.fromRGBO(255, 255, 255, 0.25),
                  ),
                ),
              ),
              child: const Text(
                'إعادة الضبط',
                style: TextStyle(
                  fontFamily: 'Janna LT',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
