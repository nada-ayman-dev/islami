import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islami/core/constants/app_colors.dart';
import 'package:islami/core/constants/app_icons.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadSurasFile() async {
  return await rootBundle.loadString('assets/files/Suras List.txt');
}
class QuranView extends StatelessWidget {
  const QuranView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header: أيقونة القرآن + سيرش لو عايزة
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "Quran",
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // القائمة
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: arabicAuranSuras.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.white54,
              thickness: 1,
              height: 24,
            ),
            itemBuilder: (context, index) {
              return Row(
                children: [
                  // أيقونة السورة مع رقمها
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        AppIcons.suraNumber, // الأيقونة واحدة لكل السور
                        height: 40,
                        width: 40,
                        color: AppColors.textPrimary,
                      ),
                      Text(
                        "${index + 1}", // رقم السورة
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),

                  // الاسم بالإنجليزي والعربي
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        englishQuranSurahs[index],
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        arabicAuranSuras[index],
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // عدد الآيات
                  Text(
                    "${AyaNumber[index]} آية",
                    style: TextStyle(
                      color: AppColors.textPrimary.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}