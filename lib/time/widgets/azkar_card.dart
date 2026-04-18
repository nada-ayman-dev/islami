import 'package:flutter/material.dart';
import '../screens/azkar_details_screen.dart';
import 'azkar_item.dart';

class AzkarSection extends StatelessWidget {
  const AzkarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16), // 👈 بدل left/right
      child: SizedBox(
        height: 259,
        width: double.infinity,
        child: Row(
          children: [
            /// 👇 Evening
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2), // 👈 border خفيف
                    width: 2,
                  ),
                ),
                child: AzkarItem(
                  imagePath: 'assets/images/Evening Azkar.png',
                  title: 'Evening Azkar',
                  backgroundColor: Colors.transparent, // 👈 مهم
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                const AzkarDetailsScreen(azkarType: 'evening'),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(width: 10), // 👈 مسافة بين الكاردين
            /// 👇 Morning
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: AzkarItem(
                  imagePath: 'assets/images/Morning Azkar.png',
                  title: 'Morning Azkar',
                  backgroundColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                const AzkarDetailsScreen(azkarType: 'morning'),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
