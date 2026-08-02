import 'package:i18n_cli/src/placeholder_validator.dart';
import 'package:test/test.dart';

void main() {
  const validator = PlaceholderValidator();

  test('treats braced and unbraced placeholders as the same parameter', () {
    final warnings = validator.validate(
      key: 'booru.using_status',
      baseValue: r'Using ${booru}',
      locale: 'vi-VN',
      localeValue: r'Dang dung $booru',
    );

    expect(warnings, isEmpty);
  });

  test('reports a missing braced placeholder', () {
    final warnings = validator.validate(
      key: 'booru.using_status',
      baseValue: r'Using ${booru}',
      locale: 'ar-AA',
      localeValue: 'Currently in use',
    );

    expect(warnings, [
      r'ar-AA:booru.using_status is missing placeholder(s): $booru',
    ]);
  });

  test('reports translated placeholder identifiers', () {
    final warnings = validator.validate(
      key: 'settings.disk_space',
      baseValue: r'$freeSpace free of $totalSpace',
      locale: 'id-ID',
      localeValue: r'$freeRuang bebas dari $totalRuang',
    );

    expect(warnings, [
      r'id-ID:settings.disk_space is missing placeholder(s): $freeSpace, $totalSpace',
      r'id-ID:settings.disk_space has extra placeholder(s): $freeRuang, $totalRuang',
    ]);
  });
}
