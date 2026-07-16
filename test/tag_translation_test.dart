import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:boorusama/core/tags/autocompletes/translation.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TagTranslation', () {
    test('loads assets and translates tags correctly', () async {
      await TagTranslation.init();

      print('First 20 keys: ${TagTranslation.translations.keys.take(20).toList()}');
      print('Contains 1girl: ${TagTranslation.translations.containsKey('1girl')}');
      print('Value for 1girl: ${TagTranslation.translations['1girl']}');
      print('Value for solo: ${TagTranslation.translate('solo')}');
      print('Value for highres: ${TagTranslation.translate('highres')}');

      // Basic tags translation checks
      expect(TagTranslation.translate('1girl'), '1个女孩');
      expect(TagTranslation.translate('solo'), '单人');
      expect(TagTranslation.translate('highres'), '高分辨率');
    });

    test('searchLocal matches English with relevance sorting', () async {
      await TagTranslation.init();

      final matches = TagTranslation.searchLocal('cat');
      expect(matches.isNotEmpty, true);

      // Matches starting with "cat" (Bucket A) or word boundary (Bucket B) should rank first
      final firstMatchEn = matches.first.value.toLowerCase();
      expect(
        firstMatchEn.startsWith('cat') || 
        firstMatchEn.contains('_cat') || 
        firstMatchEn.contains(' cat'),
        true,
      );

      // Verify that substring matches like "application" do not rank higher than prefix matches
      final applicationIndex = matches.indexWhere((e) => e.value == 'application');
      final catIndex = matches.indexWhere((e) => e.value == 'cat');

      if (applicationIndex != -1 && catIndex != -1) {
        expect(catIndex < applicationIndex, true);
      }
    });
  });
}
