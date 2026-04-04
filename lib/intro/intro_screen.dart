import 'package:flutter/material.dart';
import 'package:islami/core/widgets/app_header.dart';
import 'package:islami/home/home_screen.dart';
import 'page_view.dart';
import 'screen_data.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const AppHeader(),
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: introList.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return IntroPage(model: introList[index]);
              },
            ),
          ),

          /// 🔹 Dots Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(introList.length, (index) {
              return Container(
                margin: const EdgeInsets.all(4),
                width: currentIndex == index ? 12 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: currentIndex == index ? Colors.amber : Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }),
          ),

          const SizedBox(height: 20),

          /// 🔹 Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    controller.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: const Text("Back"),
                ),

                TextButton(
                  onPressed: () {
                    if (currentIndex == introList.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                    } else {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Text(
                    currentIndex == introList.length - 1 ? "Finish" : "Next",
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
