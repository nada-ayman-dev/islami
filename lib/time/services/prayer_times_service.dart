import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/prayer_times_model.dart';

class PrayerTimesService {
  static const String _baseUrl = 'https://api.aladhan.com/v1';

  Future<PrayerTimesResponse> getPrayerTimings({
    required String date, // Format: DD-MM-YYYY
    required String city,
    required String country,
  }) async {
    try {
      final url = '$_baseUrl/timingsByCity/$date?city=$city&country=$country';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return PrayerTimesResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load prayer times: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching prayer times: $e');
    }
  }

  Future<PrayerTimesResponse> getPrayerTimingsByCoordinates({
    required String date, // Format: DD-MM-YYYY
    required double latitude,
    required double longitude,
  }) async {
    try {
      final url =
          '$_baseUrl/timings/$date?latitude=$latitude&longitude=$longitude';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return PrayerTimesResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load prayer times: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching prayer times: $e');
    }
  }
}
