// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:kurumi/kurumi.dart' show Kurumi;

// Project imports:
import '../../colors/src/colors.dart';

export 'package:kurumi/kurumi.dart'
    show KurumiBrightness, KurumiColorSchemeX, KurumiThemeBuildContext;

extension AppThemeBuildContext on BuildContext {
  BoorusamaColors get colors =>
      Kurumi.themeOf(this).extension<BoorusamaColors>()!;
}
