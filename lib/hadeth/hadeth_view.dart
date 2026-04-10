import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:islami/core/constants/app_colors.dart';
import 'package:islami/core/constants/app_images.dart';

Future<String> loadHadethFile(String hadethNumber) async {
  try {
    return await rootBundle.loadString('assets/Hadeeth/h$hadethNumber.txt');
  } catch (e) {
    return "خطأ: لا يمكن تحميل الحديث.";
  }
}

class HadethView extends StatefulWidget {
  const HadethView({super.key});

  @override
  State<HadethView> createState() => _HadethListViewState();
}

class _HadethListViewState extends State<HadethView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: 50,
      itemBuilder: (context, index) {
        int hadethNumber = index + 1;
        return HadethCard(hadethNumber: hadethNumber.toString());
      },
    );
  }
}

// 👇 كارت الحديث الفردي
class HadethCard extends StatelessWidget {
  final String hadethNumber;

  const HadethCard({super.key, required this.hadethNumber});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 👇 البوردر والخلفية
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.background,
              border: Border.all(color: AppColors.textPrimary, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                // الصورة مع Overlay أسود
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      AppColors.textPrimary.withOpacity(0.40),
                      BlendMode.colorBurn,
                    ),
                    child: Image.asset(
                      AppImages.quran,
                      width: double.infinity,
                      height: 350,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // 👈 الصورة على اليسار
                Positioned(
                  top: 16,
                  left: 16,
                  child: SvgPicture.asset(
                    AppImages.imgleftcorner,
                    width: 80,
                    height: 80,
                  ),
                ),

                // 👉 الصورة على اليمين
                Positioned(
                  top: 16,
                  right: 16,
                  child: Image.asset(
                    AppImages.imgrightcorner,
                    width: 80,
                    height: 80,
                  ),
                ),

                // النص المحمل من الملف
                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  bottom: 100,
                  child: FutureBuilder<String>(
                    future: loadHadethFile(hadethNumber),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError ||
                          snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            "خطأ في تحميل الحديث",
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            snapshot.data!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // 👇 الصورة في الزاوية السفلى اليسار
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: SvgPicture.asset(
                    AppImages.imgleftcorner,
                    width: 80,
                    height: 80,
                  ),
                ),

                // 👇 الصورة في الزاوية السفلى اليمين
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: SvgPicture.asset(
                    AppImages.imgrightcorner,
                    width: 80,
                    height: 80,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
