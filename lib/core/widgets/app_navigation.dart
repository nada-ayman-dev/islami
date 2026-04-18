import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
///import 'package:flutter_svg/flutter_svg.dart';
import 'package:islami/core/constants/app_colors.dart';
import 'package:islami/core/constants/app_icons.dart'; // استدعاء ملف الأيقونات

class AppNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const AppNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  String _getIconPath(int index) {
    switch (index) {
      case 0:
        return AppIcons.home;
      case 1:
        return AppIcons.quran;
      case 2:
        return AppIcons.sebha;
      case 3:
        return AppIcons.radio;
      case 4:
        return AppIcons.time;
      default:
        return AppIcons.home;
    }
  }

  String _getLabel(int index) {
    switch (index) {
      case 0:
        return 'Quran';
      case 1:
        return 'hadith';
      case 2:
        return 'Sebha';
      case 3:
        return 'Radio';
      case 4:
        return 'Time';
      default:
        return 'Home';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      color: AppColors.textPrimary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(5, (index) {
          bool isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onItemTapped(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0x99202020) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    _getIconPath(index),
                    color: isSelected ? Colors.white : Colors.black,
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(height: 4),
                  if (isSelected)
                    Text(
                      _getLabel(index),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}