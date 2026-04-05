import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islami/core/constants/app_colors.dart';
import 'package:islami/core/constants/app_icons.dart';

class QuranView extends StatelessWidget {
  const QuranView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [

              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(color: AppColors.textPrimary),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0), // هنا تقدري تغيري حسب المسافة اللي عايزاها
                      child: SvgPicture.asset(
                        AppIcons.home, // أيقونة القرآن أو أي أيقونة
                        height: 20,
                        width: 20,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.textPrimary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.textPrimary, width: 2),
                    ),
                  ),
                ),
              ),
            ],
          )
        ),

        const Expanded(
          child: Center(
            child: Text(
              "Quran Content Here",
              style: TextStyle(color: AppColors.textPrimary),
            ),
          ),
        ),
      ],
    );
  }
}