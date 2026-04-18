import 'package:flutter/material.dart';
import 'package:islami/core/constants/app_colors.dart';
import 'package:islami/core/constants/app_images.dart';
import 'package:islami/core/utils/cache_manager.dart';
import 'hadeth_details.dart';

class HadethView extends StatefulWidget {
  const HadethView({super.key});

  @override
  State<HadethView> createState() => _HadethViewState();
}

class _HadethViewState extends State<HadethView> {
  late PageController controller;
  late ValueNotifier<double> currentPageNotifier;
  final cacheManager = CacheManager();

  @override
  void initState() {
    super.initState();
    currentPageNotifier = ValueNotifier<double>(0.0);
    controller = PageController(viewportFraction: 0.75);
    controller.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    currentPageNotifier.value = controller.page ?? 0.0;
  }

  @override
  void dispose() {
    controller.removeListener(_onPageChanged);
    controller.dispose();
    currentPageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Background image
        Positioned.fill(
          child: Image.asset(
            AppImages.hadethbackground,
            fit: BoxFit.cover,
            cacheWidth: 1080,
            cacheHeight: 2340,
          ),
        ),

        /// Gradient overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.darkGradientStart,
                  AppColors.darkGradientEnd,
                ],
              ),
            ),
          ),
        ),

        /// PageView
        PageView.builder(
          controller: controller,
          itemCount: 50,
          itemBuilder: (context, index) {
            return ValueListenableBuilder<double>(
              valueListenable: currentPageNotifier,
              builder: (context, currentPage, _) {
                double scale = (1 - (currentPage - index).abs()).clamp(
                  0.85,
                  1.0,
                );
                return Transform.scale(
                  scale: scale,
                  child: HadethCard(
                    hadethNumber: (index + 1).toString(),
                    cacheManager: cacheManager,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

/// Optimized HadethCard
class HadethCard extends StatelessWidget {
  final String hadethNumber;
  final CacheManager cacheManager;

  const HadethCard({
    super.key,
    required this.hadethNumber,
    required this.cacheManager,
  });

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
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.textPrimary,
          border: Border.all(color: AppColors.textPrimary, width: 3),
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
          child: RepaintBoundary(
            child: Stack(
              children: [
                /// Background image
                Positioned.fill(
                  child: Center(
                    child: Opacity(
                      opacity: 0.2,
                      child: Image.asset(
                        AppImages.hadethback,
                        width: 313,
                        height: 428,
                        fit: BoxFit.contain,
                        cacheWidth: 313,
                        cacheHeight: 428,
                      ),
                    ),
                  ),
                ),

                /// Corner decorations
                Positioned(
                  top: 16,
                  left: 16,
                  child: Image.asset(
                    AppImages.imgleftcorner,
                    width: 80,
                    height: 80,
                    color: Colors.black,
                    cacheWidth: 80,
                    cacheHeight: 80,
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
                    cacheWidth: 80,
                    cacheHeight: 80,
                  ),
                ),

                /// Content
                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  bottom: 120,
                  child: FutureBuilder<String>(
                    future: cacheManager.loadFile(
                      'assets/Hadeeth/h$hadethNumber.txt',
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
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
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                /// Bottom decoration
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
