class PrayerTimings {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String sunset;
  final String maghrib;
  final String isha;
  final String imsak;
  final String midnight;

  PrayerTimings({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
  });

  factory PrayerTimings.fromJson(Map<String, dynamic> json) {
    return PrayerTimings(
      fajr: json['Fajr'] ?? '',
      sunrise: json['Sunrise'] ?? '',
      dhuhr: json['Dhuhr'] ?? '',
      asr: json['Asr'] ?? '',
      sunset: json['Sunset'] ?? '',
      maghrib: json['Maghrib'] ?? '',
      isha: json['Isha'] ?? '',
      imsak: json['Imsak'] ?? '',
      midnight: json['Midnight'] ?? '',
    );
  }
}

class PrayerTimesResponse {
  final String code;
  final String status;
  final Map<String, dynamic> data;
  final PrayerTimings timings;
  final String date;
  final String hijriDate;
  final String hijriMonth;
  final String hijriYear;

  PrayerTimesResponse({
    required this.code,
    required this.status,
    required this.data,
    required this.timings,
    required this.date,
    required this.hijriDate,
    required this.hijriMonth,
    required this.hijriYear,
  });

  factory PrayerTimesResponse.fromJson(Map<String, dynamic> json) {
    // Navigate through the JSON structure safely
    final dateData = json['data']?['date'];
    final hijriData = dateData?['hijri'] ?? {};

    // Get month information - the 'en' field contains the English month name
    final monthData = hijriData['month'];
    String monthText = '';
    if (monthData is Map) {
      monthText = monthData['en']?.toString() ?? '';
    }

    // Get hijri date - it's in format "DD-MM-YYYY", extract the day part
    final fullDate = hijriData['date']?.toString() ?? '';
    String hijriDateValue = '';
    if (fullDate.isNotEmpty && fullDate.contains('-')) {
      hijriDateValue = fullDate.split('-')[0]; // Get day part
    }

    // Get hijri year
    var hijriYearValue = hijriData['year'];

    return PrayerTimesResponse(
      code: json['code']?.toString() ?? '',
      status: json['status'] ?? '',
      data: json['data'] ?? {},
      timings: PrayerTimings.fromJson(json['data']?['timings'] ?? {}),
      date: dateData?['readable']?.toString() ?? '',
      hijriDate: hijriDateValue,
      hijriMonth: _getMonthShorthand(monthText),
      hijriYear: hijriYearValue?.toString() ?? '',
    );
  }

  static String _getMonthShorthand(String monthText) {
    if (monthText.isEmpty) return '';

    final monthMap = {
      'Muharram': 'Muh',
      'Safar': 'Saf',
      'Rabi al-awwal': 'Rab',
      'Rabi al-thani': 'Rab',
      'Rabi al awwal': 'Rab',
      'Rabi al thani': 'Rab',
      'Jumada al-awwal': 'Jum',
      'Jumada al-thani': 'Jum',
      'Jumada al awwal': 'Jum',
      'Jumada al thani': 'Jum',
      'Rajab': 'Raj',
      'Sha\'ban': 'Sha',
      'Shaaban': 'Sha',
      'Sha\'baan': 'Sha',
      'Ramadan': 'Ram',
      'Shawwal': 'Shaw',
      'Shawwāl': 'Shaw',
      'Dhu al-Qi\'dah': 'Dhu',
      'Dhu al-Hijjah': 'Dhu',
      'Dhu al Qi\'dah': 'Dhu',
      'Dhu al Hijjah': 'Dhu',
      'Dhu al Qidah': 'Dhu',
      'Dhul-Qidah': 'Dhu',
      'Dhul-Hijjah': 'Dhu',
    };
    return monthMap[monthText] ?? monthText.substring(0, 3);
  }
}
