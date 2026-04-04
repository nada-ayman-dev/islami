import 'package:flutter/material.dart';
import 'intro_model.dart';

class IntroPage extends StatelessWidget {
  final IntroModel model;

  const IntroPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(model.image, height: 300),

        const SizedBox(height: 20),

        Text(
          model.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          model.description,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70),
        ),
      ],
    );
  }
}
