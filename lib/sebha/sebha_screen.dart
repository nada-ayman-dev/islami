import 'package:flutter/material.dart';

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

  int _index = 0;
  int _count = 0;

  String get currentZekr => azkar[_index]["text"];
  int get maxCount => azkar[_index]["count"];

  void _increment() {
    setState(() {
      _count++;

      // لو خلص الذكر الحالي
      if (_count >= maxCount) {
        _count = 0;
        _index++;

        // يرجع من الأول بعد آخر ذكر
        if (_index >= azkar.length) {
          _index = 0;
        }
      }
    });
  }

  void _reset() {
    setState(() {
      _count = 0;
      _index = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "السبحة",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'Janna LT',
              ),
            ),

            const SizedBox(height: 30),

            /// الذكر الحالي
            Text(
              currentZekr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Janna LT',
              ),
            ),

            const SizedBox(height: 20),

            /// العداد
            Text(
              "$_count / $maxCount",
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 40),

            /// زر التسبيح
            GestureDetector(
              onTap: _increment,
              child: Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                child: const Center(
                  child: Icon(Icons.touch_app, size: 60, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// reset
            ElevatedButton(onPressed: _reset, child: const Text("إعادة الضبط")),
          ],
        ),
      ),
    );
  }
}
