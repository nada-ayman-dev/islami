import 'package:flutter/material.dart';
import 'package:islami/core/constants/app_colors.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '../models/prayer_times_model.dart';
import '../services/prayer_times_service.dart';
import 'prayer_time_item.dart';

class PrayerTimesCard extends StatefulWidget {
  final String? city;
  final String? country;
  final String? date;

  const PrayerTimesCard({
    super.key,
    this.city = 'cairo',
    this.country = 'egypt',
    this.date,
  });

  @override
  State<PrayerTimesCard> createState() => _PrayerTimesCardState();
}

class _PrayerTimesCardState extends State<PrayerTimesCard> {
  late Future<PrayerTimesResponse> _prayerTimesFuture;
  final PrayerTimesService _service = PrayerTimesService();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _loadPrayerTimes();
    // Update next prayer every second
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _loadPrayerTimes() {
    final date = widget.date ?? DateFormat('dd-MM-yyyy').format(DateTime.now());
    _prayerTimesFuture = _service.getPrayerTimings(
      date: date,
      city: widget.city ?? 'cairo',
      country: widget.country ?? 'egypt',
    );
  }

  String _formatTime(String time24h) {
    try {
      final parts = time24h.split(':');
      int hour = int.parse(parts[0]);
      final minute = parts[1];
      if (hour > 12) hour -= 12;
      if (hour == 0) hour = 12;
      return '$hour:$minute';
    } catch (e) {
      return time24h;
    }
  }

  String _getPeriod(String time24h) {
    try {
      final hour = int.parse(time24h.split(':')[0]);
      return hour >= 12 ? 'PM' : 'AM';
    } catch (e) {
      return 'AM';
    }
  }

  TimeOfDay _parseTime(String time24h) {
    try {
      final parts = time24h.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      return TimeOfDay.now();
    }
  }

  Map<String, dynamic> _getNextPrayer(PrayerTimings timings) {
    final now = DateTime.now();
    final currentTime = TimeOfDay.fromDateTime(now);
    final currentMinutes = currentTime.hour * 60 + currentTime.minute;

    final prayers = [
      {'name': 'Fajr', 'time': timings.fajr},
      {'name': 'Sunrise', 'time': timings.sunrise},
      {'name': 'Dhuhr', 'time': timings.dhuhr},
      {'name': 'Asr', 'time': timings.asr},
      {'name': 'Maghrib', 'time': timings.maghrib},
      {'name': 'Isha', 'time': timings.isha},
    ];

    for (var prayer in prayers) {
      final prayerTime = _parseTime(prayer['time'] as String);
      final prayerMinutes = prayerTime.hour * 60 + prayerTime.minute;

      if (prayerMinutes >= currentMinutes) {
        return {
          'name': prayer['name'],
          'time': prayer['time'],
          'formattedTime': _formatTime(prayer['time'] as String),
        };
      }
    }

    // If no prayer found today, next is Fajr tomorrow
    return {
      'name': 'Fajr',
      'time': timings.fajr,
      'formattedTime': _formatTime(timings.fajr),
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PrayerTimesResponse>(
      future: _prayerTimesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF555555), width: 2),
            ),
            padding: const EdgeInsets.all(16.0),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.black),
            ),
          );
        }

        if (snapshot.hasError) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF555555), width: 2),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.black),
              ),
            ),
          );
        }

        final data = snapshot.data!;
        final timings = data.timings;

        return Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF555555), width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Header with dates
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('dd MMM,').format(DateTime.now()),
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat('yyyy').format(DateTime.now()),
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Pray Time',
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat('EEEE').format(DateTime.now()),
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          data.hijriDate.isNotEmpty &&
                                  data.hijriMonth.isNotEmpty
                              ? '${data.hijriDate.padLeft(2, '0')} ${data.hijriMonth},'
                              : (data.hijriYear.isNotEmpty
                                  ? data.hijriYear
                                  : 'N/A'),
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          data.hijriYear.isNotEmpty ? data.hijriYear : 'AH',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Prayer times grid
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PrayerTimeItem(
                      label: 'Dhuhr',
                      time: _formatTime(timings.dhuhr),
                      period: _getPeriod(timings.dhuhr),
                    ),
                    PrayerTimeItem(
                      label: 'ASR',
                      time: _formatTime(timings.asr),
                      period: _getPeriod(timings.asr),
                    ),
                    PrayerTimeItem(
                      label: 'Maghrib',
                      time: _formatTime(timings.maghrib),
                      period: _getPeriod(timings.maghrib),
                    ),
                    PrayerTimeItem(
                      label: 'Isha',
                      time: _formatTime(timings.isha),
                      period: _getPeriod(timings.isha),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Next prayer section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Next Pray - ${_getNextPrayer(timings)['name']} at ${_getNextPrayer(timings)['formattedTime']}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
