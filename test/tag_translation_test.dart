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
  });
}
