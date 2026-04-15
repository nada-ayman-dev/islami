import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:islami/core/constants/app_colors.dart';
import 'package:islami/core/constants/app_images.dart';
import 'hadeth_details.dart';
import 'package:islami/core/widgets/app_header.dart';

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
  final PageController controller = PageController(viewportFraction: 0.75);
  double currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        currentPage = controller.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// 👇 الخلفية
        Positioned.fill(
          child: Image.asset(AppImages.hadethbackground, fit: BoxFit.cover),
        ),

        /// 👇 gradient
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromRGBO(32, 32, 32, 0.7), Color(0xFF202020)],
              ),
            ),
          ),
        ),

        /// 👇 المحتوى كله
        SafeArea(
          child: Column(
            children: [
              const AppHeader(),
              const SizedBox(height: 10),

              /// 👇 الكروت
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  itemCount: 50,
                  itemBuilder: (context, index) {
                    double scale = (1 - (currentPage - index).abs()).clamp(
                      0.85,
                      1.0,
                    );

                    return Transform.scale(
                      scale: scale,
                      child: HadethCard(hadethNumber: (index + 1).toString()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 👇 كارت الحديث
class HadethCard extends StatelessWidget {
  final String hadethNumber;

  const HadethCard({super.key, required this.hadethNumber});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HadethDetails(hadethNumber: hadethNumber),
          ),
        );
      },

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),

        child: Container(
          decoration: BoxDecoration(
            color: AppColors.textPrimary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),

          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                /// 👈 الزوايا
                Positioned(
                  top: 16,
                  left: 16,
                  child: Image.asset(
                    AppImages.imgleftcorner,
                    width: 80,
                    height: 80,
                    color: Colors.black,
                  ),
                ),

                Positioned(
                  top: 16,
                  right: 16,
                  child: Image.asset(
                    AppImages.imgrightcorner,
                    width: 80,
                    height: 80,
                    color: Colors.black,
                  ),
                ),

                /// 👇 النص
                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  bottom: 120,
                  child: FutureBuilder<String>(
                    future: loadHadethFile(hadethNumber),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
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
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            snapshot.data!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Janna LT',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              height: 1.2,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                /// 👇 الزخرفة تحت
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    AppImages.imgbottomdecoration,
                    height: 112,
                    fit: BoxFit.cover,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
