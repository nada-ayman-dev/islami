import 'package:flutter/material.dart';
import 'package:islami/core/constants/app_colors.dart';
import 'package:islami/core/constants/app_images.dart';
import 'package:islami/core/widgets/app_header.dart';

class SebhaView extends StatefulWidget {
  const SebhaView({super.key});

  @override
  State<SebhaView> createState() => _SebhaViewState();
}

class _SebhaViewState extends State<SebhaView> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  final List<Map<String, dynamic>> azkar = [
    {"text": "سبحان الله", "count": 33},
    {"text": "الحمد لله", "count": 33},
    {"text": "الله أكبر", "count": 34},
  ];

  int index = 0;
  int count = 0;

  String get currentZekr => azkar[index]["text"];
  int get maxCount => azkar[index]["count"];

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void increment() {
    _rotationController.forward(from: 0.0);
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
    _rotationController.reset();
    setState(() {
      count = 0;
      index = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            AppImages.sebhabackg,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.low,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.darkGradientStart,
                  AppColors.darkGradientEnd,
                ],
              ),
            ),
          ),
        ),

        /// 👇 المحتوى
        SafeArea(
          child: Column(
            children: [
              const AppHeader(), // 👈 ضيفي الهيدر هنا
              const SizedBox(height: 10),

              const Text(
                'سبِّح اسمَ رَبِّكَ الأَعْلَى',
                style: TextStyle(
                  fontFamily: 'Janna LT',
                  fontSize: 36, // 👈 بدل 18
                  color: Colors.white,
                  fontWeight: FontWeight.w700, // 👈 Bold
                  height: 1.0, // 👈 line-height 100%
                ),
              ),

              const SizedBox(height: 40),

              /// 👇 السبحة
              Expanded(
                child: Center(
                  child: GestureDetector(
                    onTap: increment,
                    child: SizedBox(
                      child: Stack(
                        alignment: Alignment.center,

                        children: [
                          /// 👇 جسم السبحة مع الدوران
                          RotationTransition(
                            turns: Tween(begin: 0.2, end: 0.5).animate(
                              CurvedAnimation(
                                parent: _rotationController,
                                curve: Curves.easeInOut,
                              ),
                            ),

                            child: Image.asset(
                              AppImages.SebhaBody,
                              width: 340,
                              height: 381,
                              fit: BoxFit.contain,
                            ),
                          ),

                          /// 👇 رأس السبحة
                          Positioned(
                            top: -10,
                            child: Image.asset(AppImages.SebhaHead, width: 100),
                          ),

                          /// 👇 الذكر + العدد (في النص)
                          Align(
                            alignment: const Alignment(
                              0,
                              0.3,
                            ), // 👈 مكان مظبوط بدل top:140
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
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
                                Text(
                                  '$count',
                                  style: const TextStyle(
                                    fontFamily: 'Janna LT',
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
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

              //const SizedBox(height: 40),
              // const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
