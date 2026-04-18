import 'package:flutter/material.dart';
import 'package:islami/core/constants/app_colors.dart';

class AzkarItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final Color backgroundColor;
  final VoidCallback onTap;

  const AzkarItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 185,
        height: 259,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE2BE7F), width: 2),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 130,
                width: 130,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Janna LT',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  height: 1.0,
                  letterSpacing: 0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
