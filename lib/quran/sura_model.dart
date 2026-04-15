import 'package:flutter/services.dart' show rootBundle;

class Sura {
  final String number; // رقم السورة
  final String arabic;
  final String english;
  final String ayaCount;

  Sura({
    required this.number,
    required this.arabic,
    required this.english,
    required this.ayaCount,
  });
}

class SuraLoader {
  static Future<List<Sura>> loadSuras() async {
    final data = await rootBundle.loadString('assets/files/Suras List.txt');

    final arabicRegex = RegExp(
      r'List<String> arabicAuranSuras = \[(.*?)\];',
      dotAll: true,
    );
    final englishRegex = RegExp(
      r'List<String> englishQuranSurahs = \[(.*?)\];',
      dotAll: true,
    );
    final ayaRegex = RegExp(
      r'List<String> AyaNumber = \[(.*?)\];',
      dotAll: true,
    );

    List<String> parseList(String input) {
      final regex = RegExp('"([^"]*?)"|\'([^\']*?)\'');
      return regex
          .allMatches(input)
          .map((m) => (m.group(1) ?? m.group(2) ?? '').trim())
          .where((value) => value.isNotEmpty)
          .toList();
    }

    final arabicList = parseList(arabicRegex.firstMatch(data)?.group(1) ?? '');
    final englishList = parseList(
      englishRegex.firstMatch(data)?.group(1) ?? '',
    );
    final ayaList = parseList(ayaRegex.firstMatch(data)?.group(1) ?? '');
    final itemCount = [
      arabicList.length,
      englishList.length,
      ayaList.length,
    ].reduce((a, b) => a < b ? a : b);

    List<Sura> loadedSuras = [];
    for (int i = 0; i < itemCount; i++) {
      loadedSuras.add(
        Sura(
          number: (i + 1).toString(),
          arabic: arabicList[i],
          english: englishList[i],
          ayaCount: ayaList[i],
        ),
      );
    }

    return loadedSuras;
  }
}
