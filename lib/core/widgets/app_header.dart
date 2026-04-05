import 'package:flutter/material.dart';
import '../constants/app_images.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 20),
      child: Column(
        children: [
          Image.asset(AppImages.headerLogo, height: 151, width: 291),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
