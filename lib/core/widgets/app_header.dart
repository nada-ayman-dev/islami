import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Center(
          child: Image.asset(
            "assets/images/Group 31.png",
            height: 330,
            width: 420,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
