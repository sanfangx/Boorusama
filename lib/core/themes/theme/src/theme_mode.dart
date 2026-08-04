// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:i18n/i18n.dart';
import 'package:kurumi/kurumi.dart';

extension AppThemeModeLocalization on KurumiThemeMode {
  String localize(BuildContext context) => switch (this) {
    KurumiThemeMode.dark => context.t.settings.theme.dark,
    KurumiThemeMode.system => context.t.settings.theme.system,
    KurumiThemeMode.amoledDark => context.t.settings.theme.amoled_dark,
    KurumiThemeMode.light => context.t.settings.theme.light,
  };

  dynamic toData() => index;
}
