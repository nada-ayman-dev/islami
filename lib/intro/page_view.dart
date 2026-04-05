import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import 'intro_model.dart';

class IntroPage extends StatelessWidget {
  final IntroModel model;
  final bool showWelcomeText;

  const IntroPage({
    super.key,
    required this.model,
    this.showWelcomeText = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final availableHeight = screenHeight * 0.5; // Adjust as needed for fitting

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            model.image,
            height:
                showWelcomeText
                    ? availableHeight * 0.5
                    : availableHeight * 0.6, // Smaller image for first page
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 16),

          Text(
            model.title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          Text(
            model.description,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
