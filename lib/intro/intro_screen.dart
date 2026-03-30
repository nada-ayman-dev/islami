import 'package:flutter/material.dart';
import 'package:islami/core/widgets/app_header.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppHeader(),

          Expanded(
            child: Center(
              child: Text("محتوى الشاشة هنا"),
            ),
          ),
        ],
      ),
    );
  }
}