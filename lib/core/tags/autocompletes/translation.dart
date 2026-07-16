// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/services.dart' show rootBundle;

// Project imports:
import 'types.dart';

class TranslationEntry {
  final String en;
  final String zh;
  TranslationEntry(this.en, this.zh);
}

class TagTranslation {
  static final Map<String, String> _translations = {};
  static final List<TranslationEntry> _originalList = [];
  static bool _initialized = false;

  static Map<String, String> get translations => _translations;

  static Future<void> init() async {
    if (_initialized) return;
    try {
      String data;
      if (Platform.environment.containsKey('FLUTTER_TEST')) {
        data = await File('assets/danbooru-10w-zh_cn.csv').readAsString();
      } else {
        data = await rootBundle.loadString('assets/danbooru-10w-zh_cn.csv');
      }

      final lines = data.split('\n');
      print('Total lines read: ${lines.length}');
      int parsedCount = 0;
      for (final line in lines) {
        if (line.trim().isEmpty) continue;
        final commaIndex = line.indexOf(',');
        if (commaIndex != -1) {
          final en = line.substring(0, commaIndex).trim();
          final zh = line.substring(commaIndex + 1).trim();
          if (en.isNotEmpty && zh.isNotEmpty) {
            _translations[en] = zh;
            _translations[en.replaceAll('_', ' ').toLowerCase()] = zh;
            _translations[en.replaceAll(' ', '_').toLowerCase()] = zh;
            _originalList.add(TranslationEntry(en, zh));
            parsedCount++;
          }
        }
      }
      print('Successfully parsed and loaded $parsedCount translations');
      _initialized = true;
    } catch (e) {
      print('Failed to load tag translations: $e');
    }
  }

  static String? translate(String tag) {
    final query = tag.trim().toLowerCase();
    String? translation = _translations[query];
    if (translation != null) return translation;

    final normalizedSpace = query.replaceAll('_', ' ');
    translation = _translations[normalizedSpace];
    if (translation != null) return translation;

    final normalizedUnderscore = query.replaceAll(' ', '_');
    translation = _translations[normalizedUnderscore];
    return translation;
  }

  static List<AutocompleteData> searchLocal(String queryText, {int skip = 0, int limit = 20}) {
    final cleanQuery = queryText.trim().toLowerCase();
    if (cleanQuery.isEmpty) return [];

    final hasChinese = RegExp(r'[\u4e00-\u9fa5]').hasMatch(cleanQuery);

    if (hasChinese) {
      final List<AutocompleteData> results = [];
      int matchCount = 0;
      for (final entry in _originalList) {
        if (entry.zh.toLowerCase().contains(cleanQuery)) {
          if (matchCount >= skip) {
            results.add(
              AutocompleteData(
                label: entry.en,
                value: entry.en,
                category: 'general',
              ),
            );
            if (results.length >= limit) {
              break;
            }
          }
          matchCount++;
        }
      }
      return results;
    } else {
      final List<AutocompleteData> bucketA = [];
      final List<AutocompleteData> bucketB = [];
      final List<AutocompleteData> bucketC = [];

      for (final entry in _originalList) {
        final en = entry.en.toLowerCase();
        if (en.startsWith(cleanQuery)) {
          bucketA.add(
            AutocompleteData(
              label: entry.en,
              value: entry.en,
              category: 'general',
            ),
          );
        } else if (en.contains('_${cleanQuery}') || en.contains(' ${cleanQuery}')) {
          bucketB.add(
            AutocompleteData(
              label: entry.en,
              value: entry.en,
              category: 'general',
            ),
          );
        } else if (cleanQuery.length > 2 && en.contains(cleanQuery)) {
          bucketC.add(
            AutocompleteData(
              label: entry.en,
              value: entry.en,
              category: 'general',
            ),
          );
        }
      }

      final combined = [...bucketA, ...bucketB, ...bucketC];
      if (skip >= combined.length) return [];
      final end = (skip + limit) < combined.length ? (skip + limit) : combined.length;
      return combined.sublist(skip, end);
    }
  }
}
