import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/azkar_model.dart';

class AzkarService {
  static Future<AzkarData> getMorningAzkar() async {
    final jsonString = await rootBundle.loadString('assets/files/azkar.json');
    final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

    final morningList = jsonData['أذكار الصباح'] as List<dynamic>;
    final items = <AzkarItem>[];

    for (var item in morningList) {
      if (item is Map<String, dynamic>) {
        items.add(AzkarItem.fromJson(item));
      } else if (item is List) {
        for (var subItem in item) {
          if (subItem is Map<String, dynamic>) {
            items.add(AzkarItem.fromJson(subItem));
          }
        }
      }
    }

    return AzkarData(category: 'أذكار الصباح', items: items);
  }

  static Future<AzkarData> getEveningAzkar() async {
    final jsonString = await rootBundle.loadString('assets/files/azkar.json');
    final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

    final eveningList = jsonData['أذكار المساء'] as List<dynamic>;
    final items = <AzkarItem>[];

    for (var item in eveningList) {
      if (item is Map<String, dynamic>) {
        items.add(AzkarItem.fromJson(item));
      } else if (item is List) {
        for (var subItem in item) {
          if (subItem is Map<String, dynamic>) {
            items.add(AzkarItem.fromJson(subItem));
          }
        }
      }
    }

    return AzkarData(category: 'أذكار المساء', items: items);
  }
}
