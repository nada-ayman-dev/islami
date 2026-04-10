import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islami/core/constants/app_colors.dart';
import 'package:islami/core/constants/app_icons.dart';
import 'package:islami/core/constants/app_images.dart';
import 'sura_model.dart';
import 'sura_details.dart';

class QuranView extends StatefulWidget {
  const QuranView({super.key});

  @override
  State<QuranView> createState() => _QuranViewState();
}

class _QuranViewState extends State<QuranView> {
  List<Sura> suras = [];
  List<Sura> filteredSuras = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final loaded = await SuraLoader.loadSuras();
    setState(() {
      suras = loaded;
      filteredSuras = loaded;
    });
  }

  void _filterSuras(String text) {
    setState(() {
      filteredSuras =
          suras.where((sura) {
            final query = text.toLowerCase();
            return sura.english.toLowerCase().contains(query) ||
                sura.arabic.contains(query);
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (suras.isEmpty) return const Center(child: CircularProgressIndicator());

    final recentSuras = suras.take(4).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Field
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            onChanged: _filterSuras,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle: TextStyle(color: AppColors.textPrimary),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  AppIcons.home,
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

        // Most Recently
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "Most Recently",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: recentSuras.length,
            itemBuilder: (context, index) {
              final sura = recentSuras[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  width: 250,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.textPrimary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              sura.english,
                              style: TextStyle(
                                color: AppColors.background,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              sura.arabic,
                              style: TextStyle(
                                color: AppColors.background,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "${sura.ayaCount} Verses",
                              style: TextStyle(
                                color: AppColors.background,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Image.asset(
                        AppImages.recentlyimage,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        // Suras List
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "Suras List",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Expanded(
          child: ListView.builder(
            itemCount: filteredSuras.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final sura = filteredSuras[index];
              // غطي الـ Row كلها بـ InkWell
              return Padding(
                padding: const EdgeInsets.all(8),
                child: InkWell(
                  onTap: () {
                    if (sura.number.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SuraDetails(sura: sura),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('السورة غير متوفرة')),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // Number icon
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(
                                AppIcons.sura_number,
                                height: 52,
                                width: 52,
                                color: Colors.white,
                              ),
                              Text(
                                sura.number,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                sura.english,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "${sura.ayaCount} Verses",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            sura.arabic,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Divider(
                        color: Colors.white38,
                        thickness: 1,
                        indent: 8,
                        endIndent: 8,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
