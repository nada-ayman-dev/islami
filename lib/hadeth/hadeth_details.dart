import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../core/constants/app_colors.dart';
import '../core/constants/app_images.dart';

Future<String> loadHadethFile(String hadethNumber) async {
  try {
    return await rootBundle.loadString('assets/Hadeeth/h$hadethNumber.txt');
  } catch (e) {
    return "خطأ: لا يمكن تحميل الحديث.";
  }
}

class HadethDetails extends StatelessWidget {
  final String hadethNumber;

  const HadethDetails({super.key, required this.hadethNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'تفاصيل الحديث',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<String>(
        future: loadHadethFile(hadethNumber),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "خطأ في تحميل الحديث",
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          // 👇 تقسيم الملف
          final lines = snapshot.data!.split('\n');

          // أول سطر = العنوان
          final title = lines.first;

          // باقي السطور = المحتوى
          final content = lines.skip(1).join('\n');

          return SafeArea(
            child: Column(
              children: [
                /// HEADER
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Image.asset(
                        AppImages.imgleftcorner,
                        width: 80,
                        height: 80,
                      ),

                      Expanded(
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),

                      Image.asset(
                        AppImages.imgrightcorner,
                        width: 80,
                        height: 80,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                /// CONTENT
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      content,
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.textPrimary,
                        height: 2.0,
                      ),
                    ),
                  ),
                ),

                SvgPicture.asset(
                  AppImages.imgbottomdecoration,
                  width: MediaQuery.of(context).size.width,
                  height: 112,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
