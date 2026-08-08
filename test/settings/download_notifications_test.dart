// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:boorusama/core/settings/types.dart';

void main() {
  test('download notifications default to enabled for existing settings', () {
    final settings = Settings.fromJson(
      Settings.defaultSettings.toJson()..remove('downloadNotificationsEnabled'),
    );

    expect(settings.downloadNotificationsEnabled, isTrue);
  });

  test('download notification setting round trips', () {
    final disabled = Settings.defaultSettings.copyWith(
      downloadNotificationsEnabled: false,
    );
    final restored = Settings.fromJson(disabled.toJson());

    expect(restored.downloadNotificationsEnabled, isFalse);
  });
}
