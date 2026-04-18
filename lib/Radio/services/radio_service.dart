import 'dart:convert';
import 'package:http/http.dart' as http;

class RadioService {
  /// Fetch radios from API
  static Future<List<dynamic>> fetchRadios() async {
    try {
      final response = await http
          .get(Uri.parse("https://mp3quran.net/api/v3/radios?language=en"))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["radios"] ?? [];
      } else {
        throw Exception('Failed to load radios: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching radios: $e');
      return [];
    }
  }

  /// Fetch reciters from API (English names)
  static Future<List<dynamic>> fetchReciters() async {
    try {
      final response = await http
          .get(Uri.parse("https://mp3quran.net/api/v3/reciters?language=en"))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["reciters"] ?? [];
      } else {
        throw Exception('Failed to load reciters: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching reciters: $e');
      return [];
    }
  }
}
