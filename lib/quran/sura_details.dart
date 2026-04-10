import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../core/constants/app_colors.dart';
import '../core/constants/app_images.dart';
import 'sura_model.dart';

Future<String> loadSuraFile(String suraNumber) async {
  try {
    return await rootBundle.loadString('assets/Suras/$suraNumber.txt');
  } catch (e) {
    return "خطأ: لا يمكن تحميل السورة.";
  }
}

class SuraDetails extends StatelessWidget {
  final Sura sura;

  const SuraDetails({super.key, required this.sura});

  @override
  Widget build(BuildContext context) {
    final suraNumber = sura.number.trim();
    final suraTitle =
        sura.english.trim().isEmpty ? 'Sura' : sura.english.trim();

    return SafeArea(
      child: Column(
        children: [
          /// 🔙 AppBar بديل
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            height: 60,
            color: AppColors.background,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Text(
                    suraTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      fontFamily: 'Janna LT',
                    ),
                  ),
                ),
                const SizedBox(width: 40),
              ],
            ),
          ),

          /// المحتوى
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  /// Header
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.imgleftcorner,
                        width: 93,
                        height: 92,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          sura.arabic,
                          style: const TextStyle(
                            fontSize: 24,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Janna LT',
                          ),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Image.asset(
                        AppImages.imgrightcorner,
                        width: 93,
                        height: 92,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// النص
                  Expanded(
                    child: FutureBuilder<String>(
                      future: loadSuraFile(suraNumber),
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
                              "خطأ في تحميل السورة",
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        }

                        final suraLines =
                            snapshot.data!
                                .split('\n')
                                .where((line) => line.trim().isNotEmpty)
                                .toList();

                        final formattedText = suraLines
                            .asMap()
                            .entries
                            .map((entry) => '${entry.value} [${entry.key + 1}]')
                            .join(' ');

                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Text(
                            formattedText,
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                              fontSize: 20,
                              color: AppColors.textPrimary,
                              height: 2.0,
                              fontFamily: 'Janna LT',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// bottom decoration
          Image.asset(
            AppImages.imgbottomdecoration,
            width: double.infinity,
            height: 112,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
