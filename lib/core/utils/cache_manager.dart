import 'package:flutter/services.dart';

class CacheManager {
  static final CacheManager _instance = CacheManager._internal();
  final Map<String, String> _cache = {};

  CacheManager._internal();

  factory CacheManager() {
    return _instance;
  }

  /// Load file with caching
  Future<String> loadFile(String filePath) async {
    if (_cache.containsKey(filePath)) {
      return _cache[filePath]!;
    }

    try {
      final content = await rootBundle.loadString(filePath);
      _cache[filePath] = content;
      return content;
    } catch (e) {
      return "خطأ: لا يمكن تحميل الملف.";
    }
  }

  /// Clear cache
  void clearCache() {
    _cache.clear();
  }

  /// Get cache size
  int getCacheSize() {
    return _cache.length;
  }
}
