import 'package:flutter/material.dart';
import 'package:islami/core/constants/app_colors.dart';
import '../models/azkar_model.dart';
import '../services/azkar_service.dart';

class AzkarDetailsScreen extends StatefulWidget {
  final String azkarType; // 'morning' or 'evening'

  const AzkarDetailsScreen({super.key, required this.azkarType});

  @override
  State<AzkarDetailsScreen> createState() => _AzkarDetailsScreenState();
}

class _AzkarDetailsScreenState extends State<AzkarDetailsScreen> {
  late Future<AzkarData> _azkarFuture;

  @override
  void initState() {
    super.initState();
    _loadAzkar();
  }

  void _loadAzkar() {
    if (widget.azkarType == 'morning') {
      _azkarFuture = AzkarService.getMorningAzkar();
    } else {
      _azkarFuture = AzkarService.getEveningAzkar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.azkarType == 'morning' ? 'Morning Azkar' : 'Evening Azkar',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/timebackground.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.darken,
            ),
          ),
        ),
        child: FutureBuilder<AzkarData>(
          future: _azkarFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFFB7935F)),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Color(0xFFE2BE7F)),
                ),
              );
            }

            final azkarData = snapshot.data!;
            final items = azkarData.items;

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  color: const Color(0xFF1F1F1F),
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(
                      color: Color(0xFFB7935F),
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Count and reference
                        if (item.count.isNotEmpty)
                          Text(
                            'عدد: ${item.count}',
                            style: const TextStyle(
                              color: Color(0xFFB7935F),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        const SizedBox(height: 8),
                        // Content
                        Text(
                          item.content,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFFE2BE7F),
                            fontSize: 16,
                            height: 1.8,
                            fontFamily: 'Janna LT',
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Description
                        if (item.description.isNotEmpty)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item.description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFFB7935F),
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
